extends Node
@export var breakingPoint :int = 1

@onready var break_wall_sound = $WallBreakSound
@onready var _player := get_node("/root/GameStateMachine/Level/Player")
@onready var _shirt_label := $VBoxContainer/Label as Label


func _ready() -> void:
	if _player:
		_shirt_label.text = _player.get_shirt_size_name(breakingPoint + 1)
	

func play_sound_and_free(sound: AudioStreamPlayer2D):
	sound.get_parent().remove_child(sound)
	get_tree().current_scene.add_child(sound)
	sound.play()
	sound.connect("finished", Callable(sound, "queue_free"))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body as Player and body.TSHIRTSIZE > breakingPoint:
		play_sound_and_free(break_wall_sound)
		queue_free()
