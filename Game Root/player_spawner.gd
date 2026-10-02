class_name PlayerSpawner extends MultiplayerSpawner

const player: PackedScene = preload("res://Game Root/PlayerRoot.tscn")
var players: Dictionary[int, Node] = {}

func _ready() -> void:
	spawn_function = player_builder


func start_host() -> void:
	if multiplayer.is_server():
		player_joined(multiplayer.get_unique_id())
		multiplayer.peer_connected.connect(player_joined)
		multiplayer.peer_disconnected.connect(player_left)
func stop_host() -> void:
	if multiplayer.is_server():
		multiplayer.peer_connected.disconnect(player_joined)
		multiplayer.peer_disconnected.disconnect(player_left)

func player_joined(id: int) -> void:
	spawn(id)

func player_builder(id: int) -> Node:
	var new_player: Node = player.instantiate()
	new_player.name = str(id)
	new_player.set_multiplayer_authority(id)
	players[id] = new_player
	return new_player

func player_left(id: int) -> void:
	players[id].queue_free()
