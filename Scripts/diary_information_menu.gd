class_name DiaryInformationMenu
extends Control

var page_count: int
var current_page: int = 0
var names: Array[String]
var descriptions: Array[String]

@onready var item_explanation: Label = %ItemExplanation
@onready var item_name: Label = %ItemName
@onready var left_button: Button = %LeftButton
@onready var right_button: Button = %RightButton

func set_item(page_count_: int, names_: Array[String], descriptions_: Array[String]) -> void:
	page_count = page_count_
	names = names_
	descriptions = descriptions_
	current_page = 0
	show_page(current_page)
	if page_count > 1:
		right_button.disabled = false
	
func set_item_onetime(item: ItemResorce) -> void:
	descriptions = [item.item_description]
	names = [item.name]
	show_page(0)
	left_button.visible = false
	right_button.visible = false
	
	

func show_page(index: int) -> void:
	if !names[index] or names[index] == "":
		item_name.text = "Unkown"
		item_explanation.text = "Unkown"
	else:
		item_name.text = names[index]
		item_explanation.text = descriptions[index]

func _on_close_button_pressed() -> void:
	queue_free()


func _on_left_button_pressed() -> void:
	current_page -= 1
	if current_page <= 0:
		left_button.disabled = true
	show_page(current_page)


func _on_right_button_pressed() -> void:
	current_page += 1
	left_button.disabled = false
	if current_page >= page_count - 1:
		right_button.disabled = true
	show_page(current_page)
