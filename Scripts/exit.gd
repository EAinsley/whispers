class_name Exit
extends Area2D

@export var next_level : PackedScene

func _on_body_entered(body: Node2D) -> void:
	print("exit entered")
	if next_level and body.is_in_group("player"):
		get_tree().change_scene_to_packed.bind(next_level).call_deferred()
