class_name SkillsMenu
extends PanelContainer

signal skill_selected(skill: Skill)

const _SkillRegistry := preload("res://scripts/skills/skill_registry.gd")

var _skills: Array = []
var _buttons: Array[Button] = []


func _ready() -> void:
	_skills = _SkillRegistry.all()
	var vbox := VBoxContainer.new()
	add_child(vbox)
	for skill: Skill in _skills:
		var btn := Button.new()
		btn.text = "%s  (%d MP)" % [skill.display_name, skill.mp_cost]
		btn.pressed.connect(_on_skill_pressed.bind(skill))
		vbox.add_child(btn)
		_buttons.append(btn)
	hide()


func open(unit: Node2D) -> void:
	var mp: int = unit.get(&"mana")
	for i: int in _buttons.size():
		_buttons[i].disabled = mp < (_skills[i] as Skill).mp_cost
	show()


func close() -> void:
	hide()


func _on_skill_pressed(skill: Skill) -> void:
	skill_selected.emit(skill)
	hide()
