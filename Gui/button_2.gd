extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !multiplayer.is_server():
		queue_free()
