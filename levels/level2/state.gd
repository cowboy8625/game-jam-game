extends State

class_name Level2State
@export var next_level = "Level3"
@export var prev_level = "Level1"

func enter_state(machine: GameStateMachine):
	machine.current_level = preload("res://levels/level2/level.tscn").instantiate()
	var player = machine.current_level.get_node("Player")
	player.CHEESEBURGERS = machine.player_stats["cheese_burger_count"]
	player.set_tshirt_size()
	machine.add_child(machine.current_level)

func exit_state(machine: GameStateMachine) -> void:
	var player = machine.current_level.get_node("Player")
	player.get_parent().remove_child(player)
	machine.current_level.queue_free()
	machine.player_stats["cheese_burger_count"] = player.CHEESEBURGERS
	machine.current_level = null

func process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func physics_process_state(_machine: GameStateMachine, _delta: float) -> void:
	pass

func input_state(_machine: GameStateMachine, _event: InputEvent) -> void:
	pass


func _on_go_to_next_level_body_entered(body: Node2D) -> void:
	EventHandler.emit_signal(&"change_state", next_level)

func _on_go_to_last_level_body_entered(body: Node2D) -> void:
	EventHandler.emit_signal(&"change_state", prev_level)
