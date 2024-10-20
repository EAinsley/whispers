extends Control

@export var show_duration : float = 1.

var elapsed_time := 0.

var is_showing := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	modulate = Color(1, 1, 1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_showing:
		elapsed_time += delta / show_duration
		modulate = modulate.lerp(Color(1,1,1,1), elapsed_time)
		if elapsed_time > 1.:
			is_showing = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		visible = true
		is_showing = true
