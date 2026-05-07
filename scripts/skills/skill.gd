class_name Skill
extends Resource

@export var display_name: String = ""
@export var mp_cost: int = 0


func get_affected_cells(from: Vector2i, dir: Vector2i) -> Array[Vector2i]:
	return []


func execute(caster: Node2D, targets: Array[Node2D]) -> void:
	caster.call(&"use_mana", mp_cost)
