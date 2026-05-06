class_name HealthBar
extends Node2D

const WIDTH  := 48.0
const HEIGHT := 6.0

var _ratio: float = 1.0


func update(current: int, maximum: int) -> void:
	_ratio = float(current) / float(maximum)
	queue_redraw()


func _draw() -> void:
	var bg   := Rect2(-WIDTH * 0.5, -HEIGHT * 0.5, WIDTH, HEIGHT)
	var fill := Rect2(-WIDTH * 0.5, -HEIGHT * 0.5, WIDTH * _ratio, HEIGHT)
	var fill_color: Color
	if _ratio > 0.5:
		fill_color = Color(0.2, 0.8, 0.2)
	elif _ratio > 0.25:
		fill_color = Color(0.9, 0.7, 0.1)
	else:
		fill_color = Color(0.9, 0.2, 0.2)
	draw_rect(bg,   Color(0.1, 0.1, 0.1, 0.85))
	draw_rect(fill, fill_color)
	draw_rect(bg,   Color(0.0, 0.0, 0.0, 0.7), false, 1.0)
