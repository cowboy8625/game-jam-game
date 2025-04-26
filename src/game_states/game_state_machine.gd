extends Node2D

class_name GameStateMachine

var sound_on: bool = true
var main_menu: CanvasLayer = null

var current_state: State = null
var level: Node2D = null;
@onready var states: Dictionary = {
	"MainMenu": preload("res://src/game_states/main_menu.gd").new(),
	"Playing": preload("res://src/game_states/playing.gd").new(),
}

var sound_player: AudioStreamPlayer = preload("res://scenes/sound_player.tscn").instantiate()
@onready var sounds: Dictionary = {
	"button_hover": preload("res://assets/sounds/button_hover.mp3"),
}

func _ready() -> void:
	EventHandler.connect("play_sound", _play_sound)
	change_state("MainMenu")

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

func _play_sound(sound_name: String) -> void:
	if not self.sound_on:
		return
	if not sounds.has(sound_name):
		push_error("Sound " + sound_name + " not found")
		return
	if self.sound_player.is_playing():
		return
	#var audio_stream = self.sounds[sound_name]
	#self.sound_player.stream = audio_stream
	#self.sound_player.play()
	print("playing", sound_name)
