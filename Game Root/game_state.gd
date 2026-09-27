@abstract
class_name GameState extends State


var game_machine: GameStateMachine:
	get: return parent_machine as GameStateMachine
