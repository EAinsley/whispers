extends Node2D

var is_left: = true

var feet_step_scene = preload("res://Prefabs/feet_step.tscn")
@onready var parent: Player = get_parent()
@onready var timer: Timer = $Timer
@onready var foot_steps: Node2D = $FootSteps

var last_rotation: float = 0.

func step() -> void:
	var foot_step: Node2D = feet_step_scene.instantiate()
	get_tree().get_first_node_in_group("game_layer").add_child(foot_step)
	foot_step.is_left = is_left
	foot_step.global_position = parent.global_position
	rotation = parent.velocity.angle()
	foot_step.rotation = rotation
	
	is_left = !is_left

func _process(delta: float) -> void:
	if (timer.is_stopped() and
		(Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down") 
		or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"))):
		step()
		foot_steps.visible = false
		timer.start()
		

func _on_timer_timeout() -> void:
	if parent.velocity.length_squared() > 0.04:
		if foot_steps.visible:
			foot_steps.visible = false
		step()
	else:
		if !foot_steps.visible:
			foot_steps.visible = true
		timer.stop()


	
