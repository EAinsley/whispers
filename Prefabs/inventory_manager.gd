extends CanvasLayer

var item_count = 0
var item_list : Array[ItemGrid]


@onready var inventory_grid_container: GridContainer = %InventoryGridContainer
@onready var inventory_grid_scene: PackedScene = preload("res://Prefabs/item_grid.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 16:
		var grid : ItemGrid = inventory_grid_scene.instantiate()
		item_list.append(grid)
		inventory_grid_container.add_child(grid)

func add_item(item: ItemResorce) -> void:
	print("add item: ", item)
	item_list[item_count].item = item
	print(item_list[item_count])
	item_list[item_count].connect("gui_input", item_list[item_count]._on_margin_container_gui_input)
	item_count += 1
