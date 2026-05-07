class_name Cleave
extends "res://scripts/skills/skill.gd"


func _init() -> void:
	display_name = "Cleave"
	mp_cost = 10


func get_affected_cells(from: Vector2i, dir: Vector2i) -> Array[Vector2i]:
	var perp := Vector2i(dir.y, dir.x)
	return [from + perp, from + dir + perp, from + dir, from + dir - perp, from - perp]


func execute(caster: Node2D, targets: Array[Node2D]) -> void:
	super(caster, targets)
	var power: int = caster.get(&"attack_power")
	for target: Node2D in targets:
		target.call(&"take_damage", power)
