extends Node

class_name State

# GD script does not have Generic Types so I just left the type off so it can be used
# for the player or the enemy or any other item with state.
# There my be a better way to do this but currently this is all I could find.
func enter_state(_machine) -> void:
	pass

func exit_state(_machine) -> void:
	pass

func process_state(_machine, _delta: float) -> void:
	pass

func physics_process_state(_machine, _delta: float) -> void:
	pass

func input_state(_machine, _event: InputEvent) -> void:
	pass
