class_name StatPanel
extends PanelContainer

var _values: Dictionary = {}


func _ready() -> void:
	var margin := MarginContainer.new()
	for side in ["margin_left", "margin_right", "margin_top", "margin_bottom"]:
		margin.add_theme_constant_override(side, 8)
	add_child(margin)

	var vbox := VBoxContainer.new()
	margin.add_child(vbox)

	var title := Label.new()
	title.text = "Unit Stats"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title)
	vbox.add_child(HSeparator.new())

	var grid := GridContainer.new()
	grid.columns = 2
	grid.add_theme_constant_override("h_separation", 24)
	vbox.add_child(grid)

	for stat: String in ["HP", "STR", "DEX", "MP", "SPD"]:
		var key := Label.new()
		key.text = stat
		grid.add_child(key)
		var val := Label.new()
		val.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		val.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		grid.add_child(val)
		_values[stat] = val

	hide()


func show_unit(unit: Node2D) -> void:
	var hp: int = unit.get(&"health")
	var max_hp: int = unit.get(&"max_health")
	_values["HP"].text  = "%d / %d" % [hp, max_hp]
	_values["STR"].text = str(unit.get(&"strength"))
	_values["DEX"].text = str(unit.get(&"dexterity"))
	_values["MP"].text  = str(unit.get(&"mana"))
	_values["SPD"].text = str(unit.get(&"speed"))
	show()
