@abstract
class_name State extends Node

signal state_switched(new_state: StringName)

var parent_machine: StateMachine = null

@abstract
func enter() -> void

@abstract 
func exit() -> void
