class_name SceneChanger
extends CanvasLayer

var is_showing := false
var is_closing := false
var elapsed_time :float = 0.

@export var transition_time : float = 0.5
@onready var player = get_tree().get_first_node_in_group("player")
@onready var blanck_screen: ColorRect = $BlanckScreen

var next_level : PackedScene

func _ready() -> void:
	if player:
		player.set_process(false)
	is_showing = true

func _process(delta: float) -> void:
	if is_showing or is_closing:
		elapsed_time += delta / transition_time
		if is_showing:
			blanck_screen.modulate = Color(1, 1, 1, 1).lerp(Color(1,1,1,0), elapsed_time)
		else:
			blanck_screen.modulate = Color(1, 1, 1, 0).lerp(Color(1,1,1,1), elapsed_time)
		if elapsed_time > 1.:
			if player:
				player.set_process(true)
			elapsed_time = 0.
			if is_closing:
				get_tree().change_scene_to_packed.bind(next_level).call_deferred()
			is_showing = false
			is_closing = false


func change_scene(level : PackedScene):
	var player = get_tree().get_first_node_in_group("player")
	player.set_process(false)
	is_closing = true
	next_level = level
