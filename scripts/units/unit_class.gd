class_name UnitClass
extends Resource

@export var display_name: String = ""
@export var element: Element = null
@export var tier: int = 1
@export var promotions: Array[UnitClass] = []

static var FIGHTER:      UnitClass
static var MAGE:         UnitClass
static var ROGUE:        UnitClass
static var CLERIC:       UnitClass
static var FLAMEBREAKER: UnitClass
static var FROSTGUARD:   UnitClass
static var STORMBLADE:   UnitClass
static var STONEWARDEN:  UnitClass
static var TEMPLAR:      UnitClass
static var DREADKNIGHT:  UnitClass


static func _static_init() -> void:
	FIGHTER      = _make("Fighter",      1, null)
	MAGE         = _make("Mage",         1, null)
	ROGUE        = _make("Rogue",        1, null)
	CLERIC       = _make("Cleric",       1, null)
	FLAMEBREAKER = _make("Flamebreaker", 2, Element.FIRE)
	FROSTGUARD   = _make("Frostguard",   2, Element.WATER)
	STORMBLADE   = _make("Stormblade",   2, Element.AIR)
	STONEWARDEN  = _make("Stonewarden",  2, Element.EARTH)
	TEMPLAR      = _make("Templar",      2, Element.LIGHT)
	DREADKNIGHT  = _make("Dreadknight",  2, Element.DARK)

	FIGHTER.promotions = [
		FLAMEBREAKER, FROSTGUARD, STORMBLADE,
		STONEWARDEN, TEMPLAR, DREADKNIGHT,
	]


static func _make(dname: String, t: int, elem: Element) -> UnitClass:
	var c := UnitClass.new()
	c.display_name = dname
	c.tier = t
	c.element = elem
	return c
