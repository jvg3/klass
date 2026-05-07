class_name UnitClass
extends Resource

@export var display_name: String = ""
@export var element: Element = null
@export var tier: int = 1
@export var promotions: Array[UnitClass] = []

# Tier 1
static var FIGHTER: UnitClass
static var MAGE:    UnitClass
static var ROGUE:   UnitClass
static var CLERIC:  UnitClass

# Fighter promotions (tier 2)
static var FLAMEBREAKER: UnitClass
static var FROSTGUARD:   UnitClass
static var STORMBLADE:   UnitClass
static var STONEWARDEN:  UnitClass
static var TEMPLAR:      UnitClass
static var DREADKNIGHT:  UnitClass

# Rogue promotions (tier 2)
static var EMBER_ASSASSIN:   UnitClass
static var FROST_STALKER:    UnitClass
static var WINDRUNNER:       UnitClass
static var GRAVE_LURKER:     UnitClass
static var SHADOW_INQUISITOR: UnitClass
static var NIGHTBLADE:       UnitClass

# Mage promotions (tier 2)
static var PYROMANCER: UnitClass
static var CRYOMANCER: UnitClass
static var STORMCALLER: UnitClass
static var GEOMANCER:  UnitClass
static var LUMINARY:   UnitClass
static var NECROMANCER: UnitClass

# Cleric promotions (tier 2)
static var CINDER_SAGE:   UnitClass
static var TIDEBINDER:    UnitClass
static var ASTRAL_WEAVER: UnitClass
static var ROOT_SHAMAN:   UnitClass
static var ORACLE:        UnitClass
static var VOIDCALLER:    UnitClass


static func _static_init() -> void:
	# Tier 1
	FIGHTER = _make("Fighter", 1, null)
	MAGE    = _make("Mage",    1, null)
	ROGUE   = _make("Rogue",   1, null)
	CLERIC  = _make("Cleric",  1, null)

	# Fighter promotions
	FLAMEBREAKER = _make("Flamebreaker", 2, Element.FIRE)
	FROSTGUARD   = _make("Frostguard",   2, Element.WATER)
	STORMBLADE   = _make("Stormblade",   2, Element.AIR)
	STONEWARDEN  = _make("Stonewarden",  2, Element.EARTH)
	TEMPLAR      = _make("Templar",      2, Element.LIGHT)
	DREADKNIGHT  = _make("Dreadknight",  2, Element.DARK)

	# Rogue promotions
	EMBER_ASSASSIN    = _make("Ember Assassin",    2, Element.FIRE)
	FROST_STALKER     = _make("Frost Stalker",     2, Element.WATER)
	WINDRUNNER        = _make("Windrunner",         2, Element.AIR)
	GRAVE_LURKER      = _make("Grave Lurker",       2, Element.EARTH)
	SHADOW_INQUISITOR = _make("Shadow Inquisitor",  2, Element.LIGHT)
	NIGHTBLADE        = _make("Nightblade",         2, Element.DARK)

	# Mage promotions
	PYROMANCER  = _make("Pyromancer",  2, Element.FIRE)
	CRYOMANCER  = _make("Cryomancer",  2, Element.WATER)
	STORMCALLER = _make("Stormcaller", 2, Element.AIR)
	GEOMANCER   = _make("Geomancer",   2, Element.EARTH)
	LUMINARY    = _make("Luminary",    2, Element.LIGHT)
	NECROMANCER = _make("Necromancer", 2, Element.DARK)

	# Cleric promotions
	CINDER_SAGE   = _make("Cinder Sage",   2, Element.FIRE)
	TIDEBINDER    = _make("Tidebinder",    2, Element.WATER)
	ASTRAL_WEAVER = _make("Astral Weaver", 2, Element.AIR)
	ROOT_SHAMAN   = _make("Root Shaman",   2, Element.EARTH)
	ORACLE        = _make("Oracle",        2, Element.LIGHT)
	VOIDCALLER    = _make("Voidcaller",    2, Element.DARK)

	# Promotion mappings
	FIGHTER.promotions = [FLAMEBREAKER, FROSTGUARD, STORMBLADE, STONEWARDEN, TEMPLAR, DREADKNIGHT]
	ROGUE.promotions   = [EMBER_ASSASSIN, FROST_STALKER, WINDRUNNER, GRAVE_LURKER, SHADOW_INQUISITOR, NIGHTBLADE]
	MAGE.promotions    = [PYROMANCER, CRYOMANCER, STORMCALLER, GEOMANCER, LUMINARY, NECROMANCER]
	CLERIC.promotions  = [CINDER_SAGE, TIDEBINDER, ASTRAL_WEAVER, ROOT_SHAMAN, ORACLE, VOIDCALLER]


static func _make(dname: String, t: int, elem: Element) -> UnitClass:
	var c := UnitClass.new()
	c.display_name = dname
	c.tier = t
	c.element = elem
	return c
