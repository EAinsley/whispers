extends PointLight2D

var time_elapes:= 0.
var speed = 4.

@onready var initial_energy = energy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapes += delta
	energy = initial_energy + sin(time_elapes * speed) * 0.3
