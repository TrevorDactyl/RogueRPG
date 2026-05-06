extends State

@export var playerTurn : State

func process_physics(delta: float) -> State:
	await get_tree().create_timer(5.0).timeout
	return playerTurn
