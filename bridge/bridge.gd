extends RigidBody2D

var player = null
var player_on_bridge = false
@export var crack_sound: AudioStream
@export var break_sound: AudioStream
@onready var audio_player = $AudioStreamPlayer

var crack_sound_played = false
var break_sound_played = false

func _ready():
	freeze = true
	if !has_node("AudioStreamPlayer"):
		var new_audio = AudioStreamPlayer.new()
		new_audio.name = "AudioStreamPlayer"
		add_child(new_audio)
		audio_player = new_audio

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body:
		player = (body as Player) 
		player_on_bridge = true
		update_bridge_state(player.CHEESEBURGERS)

func _process(delta):
	if player_on_bridge and player:
		update_bridge_state(player.CHEESEBURGERS)

func update_bridge_state(burger_count: int) -> void:
	if burger_count >= 10 and !break_sound_played:
		break_bridge()
	elif burger_count >= 5 and !crack_sound_played:
		crack_bridge()

func crack_bridge() -> void:
	if crack_sound and audio_player:
		audio_player.stream = crack_sound
		audio_player.play()
		crack_sound_played = true  

func break_bridge() -> void:	
	if break_sound and audio_player:
		audio_player.stream = break_sound
		audio_player.play()
		break_sound_played = true 
	
	freeze = false
	await get_tree().create_timer(1.0).timeout
	queue_free()
