class_name Exit
extends Area2D

@export var next_level : PackedScene
@export var transition_time : float = 0.5
@onready var player = get_tree().get_first_node_in_group("player")
@onready var blanck_screen: ColorRect = $CanvasLayer/BlanckScreen

var is_showing := false
var is_closing := false
var elapsed_time :float = 0.

func _ready() -> void:
	print("diable player")
	player.set_process(false)
	is_showing = true
	
func _process(delta: float) -> void:
	if is_showing or is_closing:
		elapsed_time += delta / transition_time
		print(elapsed_time)
		if is_showing:
			blanck_screen.modulate = Color(1, 1, 1, 1).lerp(Color(1,1,1,0), elapsed_time)
		else:
			blanck_screen.modulate = Color(1, 1, 1, 0).lerp(Color(1,1,1,1), elapsed_time)
		if elapsed_time > 1.:
			player.set_process(true)
			elapsed_time = 0.
			if is_closing:
				get_tree().change_scene_to_packed.bind(next_level).call_deferred()
			is_showing = false
			is_closing = false
		

func _change_scene():
	var player = get_tree().get_first_node_in_group("player")
	player.set_process(false)
	is_closing = true


func _on_body_entered(body: Node2D) -> void:
	print("exit entered")
	if next_level and body.is_in_group("player"):
		_change_scene()
		
