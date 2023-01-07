extends MovementState
class_name FlyState


@export_range(1, 20, 0.5) var fly_speed: float = 10


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
	fly(delta)
	body.move_and_slide()


func fly(_delta: float):
	body.velocity.y = body.get_fly_axis() * fly_speed

