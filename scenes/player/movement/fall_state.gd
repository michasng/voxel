extends MovementState
class_name FallState


func get_transition() -> BaseState:
	if body.is_on_floor():
		return $"../StandState"
	return self


func enter_state(_previous_state: BaseState, _delta: float):
	pass


func exit_state(_next_state: BaseState, _delta: float):
	pass


func handle_physics(delta: float):
	move(delta)
	apply_gravity(delta)
	body.move_and_slide()

