extends MovementBody
class_name Player

@export_range(0.001, 0.005, 0.0001) var mouse_sensitivity : float = 0.003

@onready var camera: Camera3D = $Camera3D
@onready var movement_state_machine: StateMachine = $MovementStateMachine


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	movement_state_machine.set_state(movement_state_machine.get_node("FlyState"))


func _input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		_aim_camera(event.relative)

	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _aim_camera(mouse_motion: Vector2) -> void:
	camera.rotation.y -= mouse_motion.x * mouse_sensitivity
	camera.rotation.x -= mouse_motion.y * mouse_sensitivity
	camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)


# override
func get_view_direction() -> Transform3D:
	return camera.global_transform


# override
func get_move_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_backward")


# override
func is_jump_action() -> bool:
	return Input.is_action_just_pressed("jump")


# override
func can_fly() -> bool:
	return true


# override
func get_fly_axis() -> float:
	return Input.get_axis("sneak", "jump")

