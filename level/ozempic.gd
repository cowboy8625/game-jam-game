class_name Ozempic
extends Area2D
## Collectible that disappears when the player touches it.


func _on_body_entered(body: Node2D) -> void:
	if not (body is Player):
		return

	(body as Player).CHEESEBURGERS = body.CHEESEBURGERS - 4
	(body as Player).scale_player(-.1)
	(body as Player).set_tshirt_size()
	queue_free()
