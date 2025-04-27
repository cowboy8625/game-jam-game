extends RigidBody2D

var player: Player = null
var player_on_bridge := false

@export var crack_sound: AudioStream
@export var break_sound: AudioStream
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var cracked_sprite: Sprite2D = $CrackedSprite

var crack_sound_played := false
var break_sound_played := false

func _ready():
	freeze = true
	if cracked_sprite:
		cracked_sprite.visible = false
	
	if !audio_player:
		var new_audio = AudioStreamPlayer.new()
		new_audio.name = "AudioStreamPlayer"
		add_child(new_audio)
		audio_player = new_audio

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		player_on_bridge = true
		check_player_weight()


func _physics_process(delta):
	if player_on_bridge and player:
		check_player_weight()

func check_player_weight() -> void:
	if not player_on_bridge or player == null:
		return
	
	var burger_count = player.CHEESEBURGERS
	
	if burger_count >= 4:
		break_bridge()
	elif burger_count >= 2:
		crack_bridge()

func crack_bridge() -> void:
	if crack_sound and audio_player:
		audio_player.stream = crack_sound
		audio_player.play()
		crack_sound_played = true  
	if cracked_sprite:
		cracked_sprite.visible = true

func break_bridge() -> void:
	print(player_on_bridge, player)
	if not player_on_bridge or player == null:
		return
	
	if break_sound and audio_player:
		audio_player.stream = break_sound
		audio_player.play()
		break_sound_played = true 
	
	freeze = false
	await get_tree().create_timer(1.0).timeout
	queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = body
		player_on_bridge = false
