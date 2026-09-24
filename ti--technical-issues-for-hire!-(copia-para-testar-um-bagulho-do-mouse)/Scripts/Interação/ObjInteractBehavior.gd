extends Node

@export var obj_vars: ObjectVariables
@export var dialogue: Array[DE]

func Interact() -> void:
	var DiagSys =preload("uid://dyueuslttejau").new()
	DiagSys.dialogue = dialogue
	DiagSys.PLAYER = get_tree().get_first_node_in_group("PLAYER")
	DiagSys._activate_dialogue()
