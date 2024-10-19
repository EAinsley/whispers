extends CharacterBody2D

@export var MOVE_SPEED = 400

func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * MOVE_SPEED 
	move_and_slide()
