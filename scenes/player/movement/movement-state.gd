extends BaseState
class_name MovementState

@onready var body: MovementBody = $"../.."


func move(delta: float):
	var new_velocity: Vector3
	if body.get_move_direction():
		var move_dir = body.get_transformed_move_direction()
		move_dir = Vector3(move_dir.x, 0, move_dir.z).normalized()
		new_velocity = body.velocity.move_toward(
			move_dir * body.max_velocity,
			body.acceleration * delta
		)
	else:
		new_velocity = body.velocity.move_toward(
			Vector3.ZERO,
			body.deceleration * delta
		)
	body.velocity.x = new_velocity.x
	body.velocity.z = new_velocity.z


func apply_gravity(delta: float):
	body.velocity.y -= body.gravity * delta


