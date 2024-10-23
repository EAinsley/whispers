class_name Collectable
extends StaticBody2D

signal collected

@export var item: ItemResorce

var is_clickable := false
var item_menu_scene: PackedScene = preload("res://Prefabs/item_information_menu.tscn")
var diary_menu_scene: PackedScene = preload("res://Prefabs/diary_information_menu.tscn")
@onready var nearby_sound: AudioStreamPlayer2D = %NearbySound
@onready var timer: Timer = $CollisionShape2D/NearbySound/Timer

	
func set_clickable(clickable):
	is_clickable = clickable
	if !nearby_sound.stream:
		return
		
	if is_clickable:
		nearby_sound.play()
	else:
		nearby_sound.stop()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if is_clickable and event.is_action_pressed("click"):
		collected.emit()
		create_item_menu()
		Inventory.add_item(item)
		visible = false
		queue_free()
		

func create_item_menu() -> void:
	if !item:
		return
	if item.is_explicit:
		var item_menu: ItemInformationMenu = item_menu_scene.instantiate()
		get_tree().get_first_node_in_group("ui_layer").add_child(item_menu)
		item_menu.set_item(item)
	else:
		var diary_menu: DiaryInformationMenu = diary_menu_scene.instantiate()
		get_tree().get_first_node_in_group("ui_layer").add_child(diary_menu)
		diary_menu.set_item_onetime(item)
		


func _on_nearby_sound_finished() -> void:
	timer.start()



func _on_mouse_entered() -> void:
	if !is_clickable:
		return
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_timer_timeout() -> void:
	nearby_sound.pitch_scale = randf() + 0.5
	nearby_sound.play()
