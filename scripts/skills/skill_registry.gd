class_name SkillRegistry

const _Cleave := preload("res://scripts/skills/cleave.gd")
const _Charge := preload("res://scripts/skills/charge.gd")

static var CLEAVE: Skill
static var CHARGE: Skill


static func _static_init() -> void:
	CLEAVE = _Cleave.new()
	CHARGE = _Charge.new()


static func all() -> Array:
	return [CLEAVE, CHARGE]
