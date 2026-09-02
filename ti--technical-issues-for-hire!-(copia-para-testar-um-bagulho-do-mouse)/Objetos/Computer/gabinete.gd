@tool
extends RigidBody3D

@export var Pc_Comp: PCComponents
@export var ligado: bool = true
@export var obj_vars: ObjectVariables
const OsDoorsPreload = preload("uid://cu4silnqcvsnr")
signal TurnOnOff

func _TurnOnOrOff() -> void:
	if ligado:
		shutDown()
	else:
		startUp()

func shutDown()->void:
	
	pass
func startUp()->void:
	
	pass
