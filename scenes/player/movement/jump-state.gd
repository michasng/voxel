extends MovementState
class_name JumpState


func get_transition() -> BaseState:
	if body.is_jump_action() and body.can_fly():
		return $"../FlyState"
	if body.velocity.y < 0:
		return $"../FallState"
	return self


func enter_state(_previous_state: BaseState, _delta: float):
	body.velocity.y += sqrt(2 * body.gravity * body.jump_height)
	pass


func exit_state(_next_state: BaseState, _delta: float):
	pass


func handle_physics(delta: float):
	move(delta)
	apply_gravity(delta)
	body.move_and_slide()

