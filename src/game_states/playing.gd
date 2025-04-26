extends State

class_name Playing

func enter_state(machine: GameStateMachine):
	machine.level = preload("res://scenes/levels/level1.tscn").instantiate()
	machine.add_child(machine.level)

func exit_state(machine: GameStateMachine) -> void:
	machine.level.queue_free()
	machine.level = null

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass
