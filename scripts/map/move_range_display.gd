extends Node2D

var _DIAMOND := PackedVector2Array([Vector2(0, -32), Vector2(64, 0), Vector2(0, 32), Vector2(-64, 0)])
var _COLOR := Color(0.3, 0.7, 1.0, 0.35)

var _cells: Array[Vector2i] = []
var _to_world: Callable


func show_range(cells: Array[Vector2i], to_world: Callable, color: Color = Color(0.3, 0.7, 1.0, 0.35)) -> void:
	_cells = cells
	_to_world = to_world
	_COLOR = color
	queue_redraw()


func clear() -> void:
	_cells.clear()
	queue_redraw()


func _draw() -> void:
	for cell in _cells:
		var pos: Vector2 = _to_world.call(cell)
		draw_set_transform(pos, 0.0, Vector2.ONE)
		draw_colored_polygon(_DIAMOND, _COLOR)
