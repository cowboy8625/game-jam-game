class_name Ozempic
extends Area2D
## Collectible that disappears when the player touches it.


@onready var animation_player := $AnimationPlayer as AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	animation_player.play(&"picked")

	if not (body is Player):
		return

	(body as Player).CHEESEBURGERS = body.CHEESEBURGERS - 5
	(body as Player).scale_player(0.9)
	(body as Player).set_tshirt_size()
	queue_free()
