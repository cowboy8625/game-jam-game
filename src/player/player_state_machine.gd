extends Node2D

class_name PlayerStateMachine

var sound_on: bool = true
var main_menu: CanvasLayer = null

var current_state: State = null
@onready var states: Dictionary = {
	"Idle": preload("res://src/player/idle.gd").new(),
}

var sound_player: AudioStreamPlayer = preload("res://scenes/sound_player.tscn").instantiate()
@onready var sounds: Dictionary = {
	"button_hover": preload("res://assets/sounds/button_hover.mp3"),
}

func _ready() -> void:
	change_state("Idle")

func change_state(state_name: String) -> void:
	if current_state != null:
		current_state.exit_state(self)
	if not states.has(state_name):
		push_error("Player State " + state_name + " not found")
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
