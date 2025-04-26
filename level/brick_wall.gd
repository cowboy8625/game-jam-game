extends Node


func _on_area_2d_body_entered(body: Node2D) -> void:
	print('cheeseburgers')
	print(body.CHEESEBURGERS);
	if body.CHEESEBURGERS > 1:
		queue_free()
