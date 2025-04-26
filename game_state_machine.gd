extends Node2D

class_name GameStateMachine

var sound_on: bool = true
var main_menu: CanvasLayer = null

var current_state: State = null
var current_level: Node = null
@onready var player: CharacterBody2D = preload("res://player/player.tscn").instantiate()
@onready var states: Dictionary = {
	"Level1": preload("res://levels/level1/state.gd").new(),
	"Level2": preload("res://levels/level2/state.gd").new(),
}

func _ready() -> void:
	change_state("Level1")

func change_state(state_name: String) -> void:
	if current_state != null:
		current_state.exit_state(self)
	if not states.has(state_name):
		push_error("State " + state_name + " not found")
		return
	current_state = states[state_name]
	current_state.enter_state(self)

func _process(delta: float) -> void:
	if current_state == null:
		return

	current_state.process_state(self, delta)

func _physics_process(delta: float) -> void:
	if current_state == null:
		return

	current_state.physics_process_state(self, delta)

func _input(event: InputEvent) -> void:
	if current_state == null:
		return

	current_state.input_state(self, event)
