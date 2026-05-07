class_name UnitClass
extends Resource

@export var display_name: String = ""
@export var element: Element = null

static var FIGHTER:     UnitClass
static var MAGE:        UnitClass
static var ROGUE:       UnitClass
static var CLERIC:      UnitClass
static var FLAMEBREAKER: UnitClass
static var FROSTGUARD:   UnitClass
static var STORMBLADE:   UnitClass
static var STONEWARDEN:  UnitClass
static var TEMPLAR:      UnitClass
static var DREADKNIGHT:  UnitClass


static func _static_init() -> void:
	FIGHTER     = _make("Fighter",     null)
	MAGE        = _make("Mage",        null)
	ROGUE       = _make("Rogue",       null)
	CLERIC      = _make("Cleric",      null)
	FLAMEBREAKER = _make("Flamebreaker", Element.FIRE)
	FROSTGUARD   = _make("Frostguard",   Element.WATER)
	STORMBLADE   = _make("Stormblade",   Element.AIR)
	STONEWARDEN  = _make("Stonewarden",  Element.EARTH)
	TEMPLAR      = _make("Templar",      Element.LIGHT)
	DREADKNIGHT  = _make("Dreadknight",  Element.DARK)


static func _make(dname: String, elem: Element) -> UnitClass:
	var c := UnitClass.new()
	c.display_name = dname
	c.element = elem
	return c
