extends VehicleBody3D

@export var engine_force_value := 10.0
@export var turn_speed := 0.75
@export var brake_strength = 0.08
@onready var left_wheel = $"Left Wheel"
@onready var right_wheel = $"Right Wheel"
@export var registration_agent: FEAGI_RegistrationAgent_Motor
var global_data

func _ready():
	registration_agent.register_with_FEAGI(get_motion_data)
	print("version: v0.0.7") # bump over time to help you with your debug
	
func get_motion_data(data: FEAGI_Data_MotionControl):
	global_data = data
	return data

func _physics_process(delta: float):
	left_wheel.set_brake(0.01)
	right_wheel.set_brake(0.01)
	var left = 0
	var right = 0
	
	if global_data:
		if global_data.move_forward or global_data.move_backward:
			left = global_data.move_forward
			right = left
		if global_data.move_right:
			right = (global_data.move_right) / 2
			left = (left - global_data.move_right) / 2
		if global_data.move_left:
			left = (global_data.move_left) / 2
			right = (right - global_data.move_left) / 2
		#left = (left + Input.get_axis("rotate_left", "rotate_right")) / 2.0
		#right = (right + Input.get_axis("rotate_right", "rotate_left")) / 2.0
		left_wheel.engine_force = left * engine_force_value
		right_wheel.engine_force = right * engine_force_value
	global_data = null 
