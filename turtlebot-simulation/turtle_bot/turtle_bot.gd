extends VehicleBody3D

@export var engine_force_value := 10.0
@export var turn_speed := 0.75
@export var brake_strength = 0.08
@onready var left_wheel = $"Left Wheel"
@onready var right_wheel = $"Right Wheel"

func _physics_process(delta: float):
	left_wheel.set_brake(0.01)
	right_wheel.set_brake(0.01)
	
	var left: float = Input.get_axis("move_backward", "move_forward")
	var right: float = left
	left = (left + Input.get_axis("rotate_left", "rotate_right")) / 2.0
	right = (right + Input.get_axis("rotate_right", "rotate_left")) / 2.0
	left_wheel.engine_force = left * engine_force_value
	right_wheel.engine_force = right * engine_force_value
	
