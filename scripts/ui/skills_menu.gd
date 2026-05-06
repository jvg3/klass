class_name SkillsMenu
extends PanelContainer

signal skill_selected(skill_name: String, mp_cost: int)

const SKILLS := [
	{"name": "Slam",   "mp_cost": 10},
	{"name": "Charge", "mp_cost": 20},
]

var _buttons: Array[Button] = []


func _ready() -> void:
	var vbox := VBoxContainer.new()
	add_child(vbox)
	for skill: Dictionary in SKILLS:
		var btn := Button.new()
		var mp_cost: int = skill["mp_cost"]
		btn.text = "%s  (%d MP)" % [skill["name"], mp_cost]
		btn.pressed.connect(_on_skill_pressed.bind(skill["name"] as String, mp_cost))
		vbox.add_child(btn)
		_buttons.append(btn)
	hide()


func open(unit: Node2D) -> void:
	var mp: int = unit.get(&"mana")
	for i: int in _buttons.size():
		_buttons[i].disabled = mp < (SKILLS[i]["mp_cost"] as int)
	show()


func close() -> void:
	hide()


func _on_skill_pressed(skill_name: String, mp_cost: int) -> void:
	skill_selected.emit(skill_name, mp_cost)
	hide()
