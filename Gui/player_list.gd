extends VBoxContainer

var myId: int = -1
var otherIds: Array[int] = []


func update_players(id: int) -> void:
	myId = multiplayer.get_unique_id()
	otherIds.assign(multiplayer.get_peers())
	render_players()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_players(-1)
	multiplayer.peer_connected.connect(update_players)
	multiplayer.peer_disconnected.connect(update_players)


func render_players() -> void:
	
	for child: Control in get_children():
		child.queue_free()
	
	var myself: Label = Label.new()
	myself.text = "You:  "+str(myId)
	add_child(myself)
	for id: int in otherIds:
		var id_label: Label = Label.new()
		id_label.text = str(id)	
		add_child(id_label)
