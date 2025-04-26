extends State

class_name Playing

func enter_state(machine: GameStateMachine):
	machine.player = preload("res://scenes/player.tscn").instantiate()
	machine.add_child(machine.player)

func exit_state(machine: GameStateMachine) -> void:
	machine.player.queue_free()
	machine.player = null

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass
