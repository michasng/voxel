extends CharacterBody3D
class_name MovementBody
# abstract super class for moving entities, both AI or player controlled


@export_range(1, 35, 1) var max_velocity : float = 10 # m/s
@export_range(10, 400, 1) var acceleration : float = 100 # m/s^2
@export_range(10, 400, 1) var deceleration : float = 100 # m/s^2
@export_range(0.1, 3.0, 0.1) var jump_height : float = 1 # m

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func get_view_direction() -> Transform3D:
	assert(false, "method not implemented")
	return Transform3D()


func get_move_direction() -> Vector2:
	assert(false, "method not implemented")
	return Vector2.ZERO


func get_transformed_move_direction() -> Vector3:
	var move_dir_2d = get_move_direction()
	var move_dir_3d = Vector3(move_dir_2d.x, 0, move_dir_2d.y)
	return (get_view_direction().basis * move_dir_3d).normalized()


func is_jump_action() -> bool:
	assert(false, "method not implemented")
	return false


func can_fly() -> bool:
	return false


func get_fly_axis() -> float:
	return 0.0
