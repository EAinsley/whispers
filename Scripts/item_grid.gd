class_name ItemGrid
extends Control

var item_menu_scene: PackedScene = preload("res://Prefabs/item_information_menu.tscn")
@onready var icon: TextureRect = %Icon

var item : ItemResorce :
	set(value):
		item = value
		icon.texture = item.icon



func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and item:
		var item_menu: ItemInformationMenu = item_menu_scene.instantiate()
		get_tree().get_first_node_in_group("ui_layer").add_child(item_menu)
		if item:
			item_menu.set_item(item)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		print("panel clicked")
