extends RigidBody3D
@export var obj_vars: ObjectVariables
@export var itemVars: ItemData
@export var televisao: NodePath
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func teste():
	print("oi")
	
func trocarCanal() -> void:
	print("oi")
	if InteractHdlr.obj_looking:
		if "nome" in InteractHdlr.obj_looking:
			var tv: String = InteractHdlr.obj_looking.nome
			if tv == "Tv":
				print(InteractHdlr.obj_looking)
