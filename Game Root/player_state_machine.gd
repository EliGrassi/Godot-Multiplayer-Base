class_name PlayerStateMachine extends StateMachine

var player_root: PlayerRoot = null

#Lets the state machines owner pass itself to it so we can access its components

#This somewhat breaks our children knowing about parents rule, but in practice we say
#That the root component "is" the state machine

#We just cant make any arbitrary node a state machine with extension without
#making tons of state machine classes
func set_player_root(player: PlayerRoot) -> void:
	player_root = player
