class_name Charge
extends "res://scripts/skills/skill.gd"


func _init() -> void:
	display_name = "Charge"
	mp_cost = 20


func get_affected_cells(from: Vector2i, dir: Vector2i) -> Array[Vector2i]:
	return []  # TODO: implement


func execute(caster: Node2D, targets: Array[Node2D]) -> void:
	super(caster, targets)
	# TODO: implement charge effect
