extends Node
@export var breakingPoint :int = 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not (body is Player):
		return

	if (body as Player).CHEESEBURGERS > breakingPoint:
		queue_free()
