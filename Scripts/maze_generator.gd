class_name MazeGenerator
extends TileMapLayer

@export var maze_size := Vector2i(15, 15)
@export var entrance := Vector2i(0, -1)
@export var exit := Vector2i(14, 15)
@export var next_level: PackedScene

var union_parent: Array[int]
var union_edges: Array[Vector2i]
var walls : Array[Vector2i]
@onready var exit_scene: PackedScene = preload("res://Prefabs/exit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Generate boarder")
	generage_boarder()
	union_initialize()
	generate_maze()
	set_cells_terrain_connect(walls, 0, 0, false)
	set_cells_terrain_connect([exit * 2 + Vector2i.UP, exit * 2 + Vector2i.DOWN, exit * 2 + Vector2i.LEFT, exit * 2 + Vector2i.RIGHT], 0, -1)
	var exit_node: Exit = exit_scene.instantiate()
	add_child(exit_node)
	exit_node.position = map_to_local(exit * 2)
	exit_node.next_level = next_level
	
# Union find terrain generator?
func union_initialize() -> void:
	var node_number = maze_size.x * maze_size.y
	union_parent.resize(node_number)
	for i in node_number:
		union_parent[i] = i
		if i % maze_size.y != 0:
			union_edges.append(Vector2i(i - 1, i)) #left
		if i >= maze_size.x:
			union_edges.append(Vector2i(i - maze_size.x, i)) # up
	union_edges.shuffle()
	
func union_find(x: int) -> int:
	if union_parent[x] != x:
		union_parent[x] = union_find(union_parent[x])
		return union_parent[x]
	else:
		return x

# Try merge two node. Returns true on success
func union_union(x, y) -> bool:
	var px = union_find(x)
	var py = union_find(y)
	if px == py:
		return false
	else:
		union_parent[py] = px
		return true
func calc_wall_index(edge: Vector2i) -> Vector2i:
	var x_index := Vector2i(edge.x % maze_size.x, edge.x / maze_size.x)
	if(edge.x == edge.y - 1): # horizontal
		return Vector2i(x_index.x * 2 + 1, x_index.y * 2)
	else: # vetical
		return Vector2i(x_index.x * 2, x_index.y * 2 + 1)
		
func generate_maze() -> void:
	for edge : Vector2i in union_edges:
		if edge.x >= 0 and edge. y >= 0:
			if !union_union(edge.x, edge.y):
				walls.append(calc_wall_index(edge))
func generage_boarder() -> void:
	for i in maze_size.x * 2:
		set_cells_terrain_connect([Vector2i(-1, i),Vector2i(maze_size.x * 2 - 1, i), Vector2i(i, -1), Vector2i(i, maze_size.y * 2 - 1)], 0, 0, false)
	for i in maze_size.x - 1:
		for j in maze_size.y - 1:
			walls.append(Vector2i(i * 2 + 1, j * 2 + 1))
	
	
