extends RigidBody3D
#https://www.youtube.com/watch?v=ocI_2f-HNws
@export var Pc_Comp: PCComponents
@export var ligado: bool = true
@export var obj_vars: ObjectVariables
const OsDoorsPreload = preload("uid://cu4silnqcvsnr")
const InteractMenuPreload = preload("uid://qrb0un5g28b1")


signal TurnOnOff


func OpenInteractMenu() -> void:
	var intMenu = InteractMenuPreload.instantiate()
	get_tree().get_first_node_in_group("PLAYER").get_node("HUD").add_child(intMenu)

func shutDown()->void:
	
	pass
func startUp()->void:
	
	pass


func _on_conexao_fonte_entered(body: Node3D) -> void:
	if 'Name'in body:
		if body.Name == "Fonte":
			print("Conectado")
			var joint: Generic6DOFJoint3D = get_node("Generic6DOFJoint3D")
			joint.node_b = body.get_path()
	pass # Replace with function body.
