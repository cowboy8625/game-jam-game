class_name TshirtSizeUi
extends CanvasLayer

@onready var _shirt_label := $HBoxContainer/Label as Label
@onready var _player := get_node("/root/GameStateMachine/Level/Player")

func _ready() -> void:
	updateSize()

func updateSize() -> void:
	if _player:
		_shirt_label.text = _player.get_shirt_size_name(null)
