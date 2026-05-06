class_name Unit
extends Node2D

@export var max_health: int = 100
@export var max_mana: int = 30
@export var strength: int = 10
@export var dexterity: int = 8
@export var speed: int = 5
@export var attack_power: int = 25
@export var team: int = 0  # 0 = player, 1 = enemy
@export var grid_cell: Vector2i = Vector2i(0, 0)

var health: int
var mana: int

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _health_bar: HealthBar = $HealthBar
@onready var _mana_bar: ManaBar = $ManaBar


func _ready() -> void:
	health = max_health
	mana = max_mana
	_health_bar.update(health, max_health)
	_mana_bar.update(mana, max_mana)
	if team == 1:
		_sprite.modulate = Color(1.0, 0.3, 0.3)


func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	_health_bar.update(health, max_health)


func use_mana(amount: int) -> bool:
	if mana < amount:
		return false
	mana -= amount
	_mana_bar.update(mana, max_mana)
	return true
