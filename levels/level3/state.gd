extends State

class_name Level3State
@export var next_level = "Level4"

func enter_state(machine: GameStateMachine):
	machine.current_level = preload("res://levels/level3/level.tscn").instantiate()
	var player = machine.current_level.get_node("Player")
	player.CHEESEBURGERS = machine.player_stats["cheese_burger_count"]
	machine.add_child(machine.current_level)

func exit_state(machine: GameStateMachine) -> void:
	var player = machine.current_level.get_node("Player")
	player.get_parent().remove_child(player)
	machine.current_level.queue_free()
	machine.player_stats["cheese_burger_count"] = player.CHEESEBURGERS

func process_state(machine: GameStateMachine, _delta: float) -> void:
	var player = machine.current_level.get_node("Player")
	if player != null:
		print(player.CHEESEBURGERS)

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass

func _on_go_to_next_level_body_entered(body: Node2D) -> void:
	print(next_level)
	EventHandler.emit_signal(&"change_state", next_level)
