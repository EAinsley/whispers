class_name MainMenu
extends Control

@onready var start_buttom = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var exit_buttom = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@export var start_level :  PackedScene
@onready var scene_changer: SceneChanger = $SceneChanger

func _ready():
	Inventory.visible = false
	start_buttom.button_down.connect(on_start_pressed)
	exit_buttom.button_down.connect(on_exit_pressed)
	
func on_start_pressed() -> void:
	scene_changer.change_scene(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
