class_name BattleMap
extends Node2D

enum Mode { MOVE, ATTACK }

signal mode_changed(new_mode: Mode)
signal unit_hovered(unit: Node2D)
signal unit_unhovered

const UnitScene := preload("res://scenes/units/unit.tscn")

const _MOVE_COLOR       := Color(0.3, 0.7, 1.0, 0.35)
const _ATTACK_COLOR     := Color(1.0, 0.3, 0.3, 0.35)
const _MOVE_HIGHLIGHT   := Color(1.0, 0.95, 0.5, 0.35)
const _ATTACK_HIGHLIGHT := Color(1.0, 0.3, 0.3, 0.45)

@export var map_width: int = 8
@export var map_height: int = 8
@export var move_range: int = 5
@export var attack_range: int = 4

@onready var tile_layer: TileMapLayer = $TileMapLayer
@onready var _highlight: Polygon2D = $TileHighlight
@onready var _range_display: Node2D = $MoveRangeDisplay

var _grid: Dictionary = {}
var _units: Dictionary = {}  # Vector2i -> Node2D
var _active_unit: Node2D = null
var _reachable: Dictionary = {}
var _mode: Mode = Mode.MOVE
var _hovered_unit: Node2D = null


func _ready() -> void:
	_build_default_map()
	_center_camera()
	_active_unit = UnitScene.instantiate()
	place_unit(_active_unit, Vector2i(2, 2))
	var enemy := UnitScene.instantiate()
	enemy.set(&"team", 1)
	place_unit(enemy, Vector2i(5, 5))
	_refresh_range()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var cell := world_to_grid(get_global_mouse_position())

		var occupant: Node2D = _units.get(cell)
		if occupant != _hovered_unit:
			_hovered_unit = occupant
			if occupant:
				unit_hovered.emit(occupant)
			else:
				unit_unhovered.emit()

		if _reachable.has(cell):
			_highlight.position = grid_to_world(cell)
			_highlight.visible = true
		else:
			_highlight.visible = false
		return

	if not event is InputEventMouseButton:
		return
	if not (event as InputEventMouseButton).pressed:
		return
	if (event as InputEventMouseButton).button_index != MOUSE_BUTTON_LEFT:
		return
	var cell := world_to_grid(get_global_mouse_position())
	if not _reachable.has(cell) or not _active_unit:
		return
	match _mode:
		Mode.MOVE:
			move_unit(_active_unit, cell)
		Mode.ATTACK:
			_resolve_attack(cell)


func _build_default_map() -> void:
	for row in map_height:
		for col in map_width:
			var cell := Vector2i(col, row)
			tile_layer.set_cell(cell, 0, Vector2i(0, 0))
			_grid[cell] = {"walkable": true, "height": 0}


func _center_camera() -> void:
	var center_cell := Vector2i(map_width / 2, map_height / 2)
	var center_world := grid_to_world(center_cell)
	get_viewport().get_camera_2d().position = center_world


func _refresh_range() -> void:
	var from: Vector2i = _active_unit.get(&"grid_cell")
	var cells: Array[Vector2i]
	var range_color: Color
	match _mode:
		Mode.MOVE:
			cells = get_reachable_cells(from, move_range)
			range_color = _MOVE_COLOR
			_highlight.color = _MOVE_HIGHLIGHT
		Mode.ATTACK:
			cells = get_attack_cells(from, attack_range)
			range_color = _ATTACK_COLOR
			_highlight.color = _ATTACK_HIGHLIGHT
	_reachable.clear()
	for cell in cells:
		_reachable[cell] = true
	_range_display.show_range(cells, grid_to_world, range_color)


func _get_targetable_cells(from: Vector2i, max_range: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	var active_team: int = _active_unit.get(&"team")
	for cell in get_attack_cells(from, max_range):
		var occupant: Node2D = _units.get(cell)
		if occupant and occupant.get(&"team") != active_team:
			result.append(cell)
	return result


func _resolve_attack(cell: Vector2i) -> void:
	var target: Node2D = _units.get(cell)
	if not target:
		return
	var power: int = _active_unit.get(&"attack_power")
	target.call(&"take_damage", power)
	if target.get(&"health") <= 0:
		_units.erase(cell)
		target.queue_free()
	toggle_mode()


func toggle_mode() -> void:
	_mode = Mode.ATTACK if _mode == Mode.MOVE else Mode.MOVE
	_highlight.visible = false
	_refresh_range()
	mode_changed.emit(_mode)


func in_attack_mode() -> bool:
	return _mode == Mode.ATTACK


func get_active_unit() -> Node2D:
	return _active_unit


func grid_to_world(cell: Vector2i) -> Vector2:
	return tile_layer.map_to_local(cell)


func world_to_grid(world_pos: Vector2) -> Vector2i:
	return tile_layer.local_to_map(tile_layer.to_local(world_pos))


func is_in_bounds(cell: Vector2i) -> bool:
	return _grid.has(cell)


func is_walkable(cell: Vector2i) -> bool:
	return _grid.get(cell, {}).get("walkable", false)


func get_reachable_cells(from: Vector2i, max_steps: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	var visited: Dictionary = {from: 0}
	var frontier: Array[Vector2i] = [from]
	while not frontier.is_empty():
		var current: Vector2i = frontier.pop_front()
		var dist: int = visited[current]
		if dist > 0:
			result.append(current)
		if dist < max_steps:
			for neighbor: Vector2i in get_neighbors(current):
				if not visited.has(neighbor) and is_walkable(neighbor):
					visited[neighbor] = dist + 1
					frontier.append(neighbor)
	return result


func get_attack_cells(from: Vector2i, max_range: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	for dy: int in range(-max_range, max_range + 1):
		for dx: int in range(-max_range, max_range + 1):
			var dist: int = abs(dx) + abs(dy)
			if dist == 0 or dist > max_range:
				continue
			var cell := from + Vector2i(dx, dy)
			if is_in_bounds(cell):
				result.append(cell)
	return result


func get_neighbors(cell: Vector2i) -> Array[Vector2i]:
	var neighbors: Array[Vector2i] = []
	for offset: Vector2i in [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]:
		var neighbor := cell + offset
		if _grid.has(neighbor):
			neighbors.append(neighbor)
	return neighbors


func place_unit(unit: Node2D, cell: Vector2i) -> void:
	_units[cell] = unit
	add_child(unit)
	unit.set(&"grid_cell", cell)
	unit.position = grid_to_world(cell)


func move_unit(unit: Node2D, cell: Vector2i) -> void:
	var from: Vector2i = unit.get(&"grid_cell")
	_units.erase(from)
	_units[cell] = unit
	unit.set(&"grid_cell", cell)
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(unit, "position", grid_to_world(cell), 0.25)
	_refresh_range()


func set_tile_walkable(cell: Vector2i, walkable: bool) -> void:
	if _grid.has(cell):
		_grid[cell]["walkable"] = walkable
