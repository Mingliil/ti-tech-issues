extends RigidBody3D
#https://www.youtube.com/watch?v=ocI_2f-HNws
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


func _on_conexao_fonte_entered(body: Node3D) -> void:
	if 'Name'in body:
		if body.Name == "Fonte":
			print("Conectado")
			$Generic6DOFJoint3D
	pass # Replace with function body.
