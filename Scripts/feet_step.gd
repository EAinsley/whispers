extends Node2D
@onready var left_step: Sprite2D = $LeftStep
@onready var right_step: Sprite2D = $RightStep

@export var is_transiant := true
var duration := 10.
var time = 0.
var is_left : bool : 
	set(value):
		is_left = value
		if is_left:
			left_step.visible = true
		else:
			right_step.visible = true

func _ready() -> void:
	if !is_transiant:
		left_step.visible = true
		right_step.visible = true

func _process(delta: float) -> void:
	if !is_transiant:
		return
	time += delta / duration
	modulate = modulate.lerp(Color(1, 1, 1, 0), time)
	if time > 1. :
		queue_free()
