extends State

class_name Level1State


func enter_state(machine: GameStateMachine):
	machine.current_level = preload("res://levels/level1/level.tscn").instantiate()
	machine.add_child(machine.current_level)

func exit_state(machine: GameStateMachine) -> void:
	var player = machine.current_level.get_node("Player")
	player.get_parent().remove_child(player)
	machine.current_level.queue_free()
	print(player)

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass


func _on_go_to_level_2_body_entered(body: Node2D) -> void:
	EventHandler.emit_signal(&"change_state", &"Level2")
