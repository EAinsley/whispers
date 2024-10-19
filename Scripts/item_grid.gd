class_name ItemGrid
extends Control

var item_menu_scene: PackedScene = preload("res://Prefabs/item_information_menu.tscn")
var diary_menu_scene: PackedScene = preload("res://Prefabs/diary_information_menu.tscn")
var title : Array[String]
var description : Array[String]
var count : int
var id := ""
var has_set := false

@onready var icon: TextureRect = %Icon

var item : ItemResorce 
func set_item(i: ItemResorce) -> void:
	if !has_set:
		has_set = true
		id = i.id
		count = i.size
		title.resize(count)
		description.resize(count)
		item = i
	description[i.index - 1] = i.item_description
	title[i.index - 1] = i.name
	icon.texture = item.icon
	

func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and has_set:
		var ui_layer = get_tree().get_first_node_in_group("ui_layer")
		if count == 1:
			var item_menu: ItemInformationMenu = item_menu_scene.instantiate()
			ui_layer.add_child(item_menu)
			item_menu.set_item(item)
		else:
			var diary_menu: DiaryInformationMenu = diary_menu_scene.instantiate()
			ui_layer.add_child(diary_menu)
			diary_menu.set_item(count, title, description)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		print("panel clicked")
