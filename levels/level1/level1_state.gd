extends State

class_name Level1State


func enter_state(machine: GameStateMachine):
	machine.current_level = preload("res://level/level.tscn").instantiate()
	machine.add_child(machine.current_level)
	machine.current_level.add_child(machine.player)

func exit_state(machine: GameStateMachine) -> void:
	machine.current_level.queue_free()

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass
