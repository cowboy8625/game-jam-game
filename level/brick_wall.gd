extends Node
@export var breakingPoint :int = 1

@onready var break_wall_sound = $WallBreakSound

func play_sound_and_free(sound: AudioStreamPlayer2D):
	sound.get_parent().remove_child(sound)
	get_tree().current_scene.add_child(sound)
	sound.play()
	sound.connect("finished", Callable(sound, "queue_free"))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body as Player and body.CHEESEBURGERS > breakingPoint:
		play_sound_and_free(break_wall_sound)
		queue_free()
