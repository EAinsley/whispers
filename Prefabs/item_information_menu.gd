class_name ItemInformationMenu
extends Node

@onready var _item_picture: TextureRect = %ItemPicture
@onready var _item_explanation: Label = %ItemExplanation
@onready var _item_name: Label = %ItemName

func set_item(item:ItemResorce) -> void:
		if item.icon:
			_item_picture.texture = item.icon
		if item.item_description:
			_item_explanation.text = item.item_description
		if item.name:
			_item_name.text = item.name

func _on_button_pressed() -> void:
	queue_free()
