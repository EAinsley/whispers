extends CanvasLayer

var item_count = 0
var item_list : Array[ItemGrid]

@export var inexplicit_number := 9
@export var explicit_number := 11
@onready var inventory_grid_container: GridContainer = %InventoryGridContainer
@onready var inventory_grid_scene: PackedScene = preload("res://Prefabs/item_grid.tscn")
# Called when the node enters the scene tree for the first time.
var collected_inexplicit := 0
var collected_explicit := 0
func _ready() -> void:
	print("condition: ", inexplicit_number,  "ex: ", explicit_number)
	for i in 16:
		var grid : ItemGrid = inventory_grid_scene.instantiate()
		item_list.append(grid)
		inventory_grid_container.add_child(grid)

func add_item(item: ItemResorce) -> void:
	if !item.is_explicit:
		collected_inexplicit += 1
		for i in item_count:
			if item_list[i].id == item.id:
				item_list[i].set_item(item)
				return
	else:
		collected_explicit += 1
	item_list[item_count].set_item(item)
	item_list[item_count].connect("gui_input", item_list[item_count]._on_margin_container_gui_input)
	item_count += 1
		
func is_true_end() -> bool:
	print("in:", inexplicit_number, "ex:", explicit_number)
	print("cin: ", collected_inexplicit, "cex: ", collected_explicit)
	return collected_inexplicit == inexplicit_number and collected_explicit == explicit_number
