class_name Element
extends Resource

@export var display_name: String = ""

static var FIRE:  Element
static var WATER: Element
static var AIR:   Element
static var EARTH: Element
static var LIGHT: Element
static var DARK:  Element


static func _static_init() -> void:
	FIRE  = _make("Fire")
	WATER = _make("Water")
	AIR   = _make("Air")
	EARTH = _make("Earth")
	LIGHT = _make("Light")
	DARK  = _make("Dark")


static func _make(dname: String) -> Element:
	var e := Element.new()
	e.display_name = dname
	return e
