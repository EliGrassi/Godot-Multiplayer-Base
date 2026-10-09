class_name LobbyGuiStateMachine extends StateMachine




var lobby_gui: LobbyGui = null

#Lets the state machines owner pass itself to it so we can access its components

#This somewhat breaks our children knowing about parents rule, but in practice we say
#That the root component "is" the state machine

func _ready() -> void:
	#Make sure the parent has set our lobby GUI before going on to
	#do things with our state machien
	await get_parent().ready
	super()


#We just cant make any arbitrary node a state machine with extension without
#making tons of state machine classes
func set_lobby_gui(gui: LobbyGui) -> void:
	lobby_gui = gui
