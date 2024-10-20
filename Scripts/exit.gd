class_name Exit
extends Area2D

@export var next_level : PackedScene
@export var transition_time : float = 0.5
@onready var player = get_tree().get_first_node_in_group("player")
@onready var scene_changer: SceneChanger = $SceneChanger

var is_showing := false
var is_closing := false
var elapsed_time :float = 0.


func _on_body_entered(body: Node2D) -> void:
	print("exit entered")
	if next_level and body.is_in_group("player"):
		scene_changer.change_scene(next_level)
		
