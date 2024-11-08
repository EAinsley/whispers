class_name Player
extends CharacterBody2D

@export var move_speed := 200
@export var light_radius := 150
@export var has_right := true

@onready var light_on_right: PointLight2D = $LightOnRight
@onready var light_on_left: PointLight2D = $LightOnLeft
@onready var detection_area_size: CollisionShape2D = $LightOnRight/DetectionArea/DetectionAreaSize
@onready var ear: AudioListener2D = $LightOnRight/Ear

func _ready() -> void:
	light_on_right.position.x = light_on_left.position.x + (500)
	light_on_right.position.y = light_on_left.position.y
	light_on_left.texture_scale = float(light_radius)/32.
	light_on_right.texture_scale = float(light_radius)/32.
	Inventory.visible = true

	
	detection_area_size.shape.radius = light_radius
	ear.make_current()
	if !has_right:
		light_on_right.visible = false


func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed 
	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Collectable:
		print("enter body:", body)
		body.set_clickable(true)


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Collectable:
		print("exit body: ", body)
		body.set_clickable(false)
