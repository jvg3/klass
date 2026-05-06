extends Node2D

@onready var _battle_map: BattleMap  = $BattleMap
@onready var _attack_btn: Button     = $HUD/AttackButton
@onready var _skills_btn: Button     = $HUD/SkillsButton
@onready var _skills_menu: SkillsMenu = $HUD/SkillsMenu
@onready var _stat_panel: StatPanel  = $HUD/StatPanel


func _ready() -> void:
	_attack_btn.pressed.connect(_battle_map.toggle_mode)
	_battle_map.mode_changed.connect(_on_mode_changed)
	_battle_map.unit_hovered.connect(_stat_panel.show_unit)
	_battle_map.unit_unhovered.connect(_stat_panel.hide)

	_skills_btn.pressed.connect(_on_skills_pressed)
	_skills_menu.skill_selected.connect(_on_skill_selected)


func _on_mode_changed(mode: BattleMap.Mode) -> void:
	_attack_btn.text = "Cancel" if mode == BattleMap.Mode.ATTACK else "Attack"


func _on_skills_pressed() -> void:
	if _skills_menu.visible:
		_skills_menu.close()
		_skills_btn.text = "Skills"
	else:
		_skills_menu.open(_battle_map.get_active_unit())
		_skills_btn.text = "Skills ▼"


func _on_skill_selected(skill_name: String, _mp_cost: int) -> void:
	_skills_btn.text = "Skills"
	print("Used skill: ", skill_name)  # TODO: execute skill
