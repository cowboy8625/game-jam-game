extends State

class_name Level2State


func enter_state(machine: GameStateMachine):
	machine.current_level = preload("res://levels/level2/level.tscn").instantiate()
	machine.add_child(machine.current_level)
	var player = machine.current_level.get_node("Player")
	print(player.CHEESEBURGERS)
	player.CHEESEBURGERS = machine.player_stats["cheese_burger_count"]
	print(player.CHEESEBURGERS)
	

func exit_state(machine: GameStateMachine) -> void:
	machine.current_level.queue_free()

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass
