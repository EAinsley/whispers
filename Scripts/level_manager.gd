extends Control

@onready var canvas_modulate: CanvasModulate = $GameLayer/CanvasModulate
var player : Player
var collected := 0
var collected_expected:= 0
var collectables :Array
var lighting_up := false

var elapsed_time := 0.

func _process(delta: float) -> void:
	if lighting_up:
		elapsed_time += delta
		canvas_modulate.color = canvas_modulate.color.lerp(Color(1,1,1,1), elapsed_time)
		if elapsed_time > 1.:
			lighting_up = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	collectables = get_tree().get_nodes_in_group("collectables")
	for c in collectables:
		if c is Collectable:
			c.collected.connect(collect_register)
		
	collected_expected = collectables.size()
	print("expected:", collected_expected)

func collect_register() -> void:
	collected += 1
	print("connect register, left: ", collected_expected - collected)
	if collected == collected_expected:
		lighting_up = true
