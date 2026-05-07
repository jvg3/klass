extends Node2D

@onready var _battle_map:      BattleMap      = $BattleMap
@onready var _attack_btn:      Button         = $HUD/AttackButton
@onready var _skills_btn:      Button         = $HUD/SkillsButton
@onready var _skills_menu:     SkillsMenu     = $HUD/SkillsMenu
@onready var _stat_panel:      StatPanel      = $HUD/StatPanel
@onready var _promote_btn:     Button         = $HUD/PromoteButton
@onready var _promotion_panel: PromotionPanel = $HUD/PromotionPanel


func _ready() -> void:
	_attack_btn.pressed.connect(_battle_map.toggle_mode)
	_battle_map.mode_changed.connect(_on_mode_changed)
	_battle_map.unit_hovered.connect(_stat_panel.show_unit)
	_battle_map.unit_unhovered.connect(_stat_panel.hide)

	_skills_btn.pressed.connect(_on_skills_pressed)
	_skills_menu.skill_selected.connect(_on_skill_selected)

	_promote_btn.pressed.connect(_on_promote_pressed)
	_promotion_panel.class_chosen.connect(_on_class_chosen)


func _on_mode_changed(mode: BattleMap.Mode) -> void:
	_attack_btn.text = "Attack" if mode == BattleMap.Mode.MOVE else "Cancel"
	if mode == BattleMap.Mode.MOVE:
		_skills_btn.text = "Skills"
		_skills_menu.close()


func _on_skills_pressed() -> void:
	if _skills_menu.visible:
		_skills_menu.close()
		_skills_btn.text = "Skills"
	else:
		_skills_menu.open(_battle_map.get_active_unit())
		_skills_btn.text = "Skills ▼"


func _on_skill_selected(skill: Skill) -> void:
	_skills_btn.text = "Skills"
	_battle_map.start_skill(skill)


func _on_promote_pressed() -> void:
	var unit := _battle_map.get_active_unit()
	var uc: UnitClass = unit.get(&"unit_class")
	if not uc or uc.promotions.is_empty():
		return
	var pool := uc.promotions.duplicate()
	pool.shuffle()
	_promotion_panel.open(pool.slice(0, 2))


func _on_class_chosen(new_class: Resource) -> void:
	_battle_map.get_active_unit().set(&"unit_class", new_class)
