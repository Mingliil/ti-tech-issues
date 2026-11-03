extends Node

@export var obj_vars: ObjectVariables
@export var dialogue: Array[DE]
@export var DialogoSemintro: Array[DE]
@export var DialogoSeSim: Array[DE]
@export var DialogoSeNAO: Array[DE]
var interagiuAntes: bool = false
func Interact() -> void:
	var DiagSys = preload("uid://dyueuslttejau").new()
	DiagSys.PLAYER = get_tree().get_first_node_in_group("PLAYER")
	if interagiuAntes:
		DiagSys.dialogue = dialogue
		DiagSys._activate_dialogue(dialogue)
	else:
		DiagSys.dialogue = DialogoSemintro
		DiagSys._activate_dialogue(DialogoSemintro)
	
	interagiuAntes = true
func OpcaoSimNao(shek:bool)->void:
	var PLAYER = get_tree().get_first_node_in_group("PLAYER")
	var DiagSys = get_tree().get_first_node_in_group("DIALOGUE")
	DiagSys.PLAYER = get_tree().get_first_node_in_group("PLAYER")
	if shek:
		DiagSys.dialogue = DialogoSeSim
		DiagSys.current_dialogue_item =0
	else:
		DiagSys.dialogue = DialogoSeNAO
		DiagSys.current_dialogue_item=0
