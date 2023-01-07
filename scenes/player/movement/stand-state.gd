extends MovementState
class_name StandState


func get_transition() -> BaseState:
	if body.is_on_floor():
		if body.is_jump_action():
			return $"../JumpState"
	else:
		return $"../FallState"
	return self


func enter_state(_previous_state: BaseState, _delta: float):
	pass


func exit_state(_next_state: BaseState, _delta: float):
	pass


func handle_physics(delta: float):
	move(delta)
	body.move_and_slide()

