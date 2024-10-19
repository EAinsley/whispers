class_name Collectable
extends StaticBody2D

@export var item: ItemResorce

var is_clickable := false
var item_menu_scene: PackedScene = preload("res://Prefabs/item_information_menu.tscn")
	
	
func set_clickable(clickable):
	is_clickable = clickable


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if is_clickable and event.is_action_pressed("click"):
		create_item_menu()
		Inventory.add_item(item)
		queue_free()

func create_item_menu() -> void:
	var item_menu: ItemInformationMenu = item_menu_scene.instantiate()
	get_tree().get_first_node_in_group("ui_layer").add_child(item_menu)
	if item:
		item_menu.set_item(item)
