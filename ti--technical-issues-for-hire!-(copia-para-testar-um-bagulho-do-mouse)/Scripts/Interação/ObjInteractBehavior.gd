extends Node

@export var obj_vars: ObjectVariables
@export var dialogue: Array[DE]
@export var DialogoSemintro: Array[DE]
@export var DialogoSeSim: Array[DE]
@export var DialogoSeNAO: Array[DE]
var interagiuAntes: bool = false
signal Adicionou
func Interact() -> void:
	var DiagSys = preload("uid://dyueuslttejau").new()
	DiagSys.PLAYER = get_tree().get_first_node_in_group("PLAYER")
	var dummyArray : Array[DE]
	if !interagiuAntes:
		DiagSys.dialogue = dialogue.duplicate()
		DiagSys._activate_dialogue(self)
	else:
		DiagSys.dialogue = DialogoSemintro.duplicate()
		DiagSys._activate_dialogue(self)
	
	interagiuAntes = true
func OpcaoSimNao(shek:bool)->void:
	var PLAYER = get_tree().get_first_node_in_group("PLAYER")
	var DiagSys = get_tree().get_first_node_in_group("DIALOGUE")
	DiagSys.PLAYER = get_tree().get_first_node_in_group("PLAYER")
	var dummyArray : Array[DE]
	if shek:
		dummyArray=DialogoSeSim.duplicate()
		DiagSys.dialogue.append_array(dummyArray)
		#DiagSys.current_dialogue_item =0
		
		
	else:
		dummyArray=DialogoSeNAO.duplicate()
		DiagSys.dialogue.append_array(dummyArray)
		#DiagSys.current_dialogue_item=0
		
	Adicionou.emit()
