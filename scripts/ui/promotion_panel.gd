class_name PromotionPanel
extends PanelContainer

signal class_chosen(uc: Resource)

const _UnitClass := preload("res://scripts/units/unit_class.gd")

var _options: Array = []
var _buttons: Array[Button] = []


func _ready() -> void:
	var margin := MarginContainer.new()
	for side in ["margin_left", "margin_right", "margin_top", "margin_bottom"]:
		margin.add_theme_constant_override(side, 16)
	add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 12)
	margin.add_child(vbox)

	var title := Label.new()
	title.text = "Choose Promotion"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title)
	vbox.add_child(HSeparator.new())

	var hbox := HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 16)
	vbox.add_child(hbox)

	for i: int in 2:
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(130, 56)
		btn.pressed.connect(_on_option_pressed.bind(i))
		hbox.add_child(btn)
		_buttons.append(btn)

	hide()


func open(options: Array) -> void:
	_options = options
	for i: int in _buttons.size():
		var uc: _UnitClass = options[i]
		var elem := " (%s)" % uc.element.display_name if uc.element else ""
		_buttons[i].text = "%s%s\nTier %d" % [uc.display_name, elem, uc.tier]
	show()


func _on_option_pressed(index: int) -> void:
	class_chosen.emit(_options[index])
	hide()
