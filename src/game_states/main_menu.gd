extends State

class_name MainMenu

func enter_state(machine: GameStateMachine):
	EventHandler.emit_signal("play_sound", "main_menu")

	machine.main_menu = preload("res://scenes/main_menu.tscn").instantiate()
	var button = machine.main_menu.get_node("Control/Button")
	button.connect("pressed", Callable(machine, "change_state").bind("MainMenu"))
	button.connect("mouse_entered", Callable(EventHandler, "play_sound").bind("button_hover"))
	machine.add_child(machine.main_menu)

func exit_state(machine: GameStateMachine) -> void:
	machine.main_menu.queue_free()
	machine.main_menu = null

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass
