class_name ManaBar
extends Node2D

const WIDTH  := 48.0
const HEIGHT := 6.0

var _ratio: float = 1.0


func update(current: int, maximum: int) -> void:
	_ratio = float(current) / float(maximum) if maximum > 0 else 0.0
	queue_redraw()


func _draw() -> void:
	var bg   := Rect2(-WIDTH * 0.5, -HEIGHT * 0.5, WIDTH, HEIGHT)
	var fill := Rect2(-WIDTH * 0.5, -HEIGHT * 0.5, WIDTH * _ratio, HEIGHT)
	draw_rect(bg,   Color(0.1, 0.1, 0.1, 0.85))
	draw_rect(fill, Color(0.2, 0.5, 0.95))
	draw_rect(bg,   Color(0.0, 0.0, 0.0, 0.7), false, 1.0)
