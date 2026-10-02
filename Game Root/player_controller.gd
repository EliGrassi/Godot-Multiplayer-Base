extends Node3D

var spawner: MultiplayerSpawner = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner = MultiplayerSpawner.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
