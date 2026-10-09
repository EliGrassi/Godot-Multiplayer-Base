class_name NetworkCreator extends Node

#Enum for the different networking types we can use
enum NetworkingStates {STEAM, ENET}

signal confirm_client_connected

#Determine if were using Steam multiplayer or Godots EnetPacketPeer
@export var networking_mode: NetworkingStates = NetworkingStates.ENET
#Set to your steam apps id. set to 480 as default value
@export var steam_app_id: int = 480
#Pick what port you want your game hosted on when using Enet
#I have set this to an arbitrary number as the default
@export var enet_port: int = 7290
#Pick a server for your enet host. Default is 127.0.0.1 for localhost
@export var enet_server_ip: String = "127.0.0.1"
#Pick a max number of players in one server
@export var max_players: int = 4



var hosting_server: bool = false
var lobby_id: int = 0
var enet_peer: ENetMultiplayerPeer = null
var steam_peer: SteamMultiplayerPeer = null


func _ready() -> void:
	if networking_mode == NetworkingStates.STEAM:
		steam_peer = SteamMultiplayerPeer.new()
		Steam.steamInit(steam_app_id, true)
		Steam.initRelayNetworkAccess()
		multiplayer.multiplayer_peer = steam_peer
	elif networking_mode == NetworkingStates.ENET:
		enet_peer = ENetMultiplayerPeer.new()
	multiplayer.peer_connected.connect(player_joined)
	multiplayer.peer_disconnected.connect(player_left)
	multiplayer.connection_failed.connect(client_failed_connection)


#Handles opening a server
func open_server() -> void:
	if networking_mode == NetworkingStates.STEAM:
		Steam.createLobby(Steam.LobbyType.LOBBY_TYPE_FRIENDS_ONLY, max_players)
		
	elif networking_mode == NetworkingStates.ENET:
		enet_peer.create_server(enet_port, max_players)
		multiplayer.multiplayer_peer = enet_peer
	#Mark that we have a server open
	hosting_server = true

#Handles joining a server
func join_server() -> void:
	if networking_mode == NetworkingStates.STEAM:
		Steam.joinLobby(lobby_id)
		
	elif networking_mode == NetworkingStates.ENET:
		enet_peer.create_client("127.0.0.1", enet_port)
		multiplayer.multiplayer_peer = enet_peer

#Remote function that lets a server confirm to a client that it has joined
@rpc("authority","call_remote","reliable")
func confirm_client_join(id: int) -> void:
	confirm_client_connected.emit(id)

func client_failed_connection() -> void:
	print("client failed to connect")
	
	
#Functions called when players join/leave
#Trigger a remote function to confirm to the connecting client it has joined	
func player_joined(id: int) -> void:
	if multiplayer.is_server():
		print("Player has joined with id: "+str(id))
		confirm_client_join.rpc(id)
func player_left(id: int) -> void:
	print("Player id "+str(id)+" has disconnected")
