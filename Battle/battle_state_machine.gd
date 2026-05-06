extends Node


@export var current_state : State 
@export var starting_state : State

@export var targetState : State



func init(parent: battleManager) -> void:
	for child in get_children():
		child.parent = parent
	#Initialize to the starting state
	change_state(starting_state)
	parent.menuMngr.init()

#Change state, calling exit logic on the current one
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()

#Pass functions for the player to call, handeling state changes when needed
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event :InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
