extends State

class_name Level2State


func enter_state(machine: GameStateMachine):
	machine.current_level = preload("res://levels/level2/level.tscn").instantiate()
	machine.add_child(machine.current_level)
		# Wait until the level is added
	await machine.get_tree().process_frame

	# Optional: wait a frame to make sure it's ready
	await machine.get_tree().process_frame

	# Find the player
	var player = machine.current_level.get_node("Path/To/Player") # Adjust this path

	if player:
		var camera = player.get_node("Camera2D") # Assuming it's directly under Player
		if camera:
			camera.current = true

func exit_state(machine: GameStateMachine) -> void:
	machine.current_level.queue_free()

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass
