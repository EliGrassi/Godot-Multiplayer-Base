@abstract
class_name State extends Node

#Abstract class for implementing different states. All states need an enter
#and exit function.

signal state_switched(new_state: StringName)

#States store their parent state machine, it is passed to it by the machine
#on startup
var parent_machine: StateMachine = null

@abstract
func enter() -> void

@abstract 
func exit() -> void
