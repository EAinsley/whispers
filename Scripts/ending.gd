extends Control

@export_multiline var true_end: Array[String]
@export_multiline var normal_end: Array[String]
@export var true_end_bgm : AudioStream
@export var false_end_bgm : AudioStream

var menu_scene :PackedScene


@onready var ending_bgm: AudioStreamPlayer = $EndingBGM
@onready var scene_changer: SceneChanger = $SceneChanger

var is_true := false

var current_index := -1
@onready var text_lable: Label = $CenterContainer/TextLable

# check if is true ending
func _ready() -> void:
	is_true = Inventory.is_true_end()
	print(is_true, " ending")
	if is_true:
		ending_bgm.stream = true_end_bgm
	else:
		ending_bgm.stream = false_end_bgm
	ending_bgm.play()
	menu_scene = load("res://Scene/main.tscn")
	show_next()
	Inventory.visible = false

func show_next() -> bool:
	current_index += 1
	if is_true:
		if true_end.size() <= current_index:
			return false
		text_lable.text = true_end[current_index]
	else:
		if normal_end.size() <= current_index:
			return false
		text_lable.text = normal_end[current_index]
	return true
		

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and !show_next():
		scene_changer.change_scene(menu_scene)
		Inventory.clean()
