extends RigidBody3D
@export var obj_vars: ObjectVariables
@export var itemVars: ItemData
@export var televisao: NodePath
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func teste()->void:
	print("here lies afonso,
	you can tell it because we put his name on the song")

func getTheTv():
	if InteractHdlr.obj_looking:
		if "nome" in InteractHdlr.obj_looking:
			var tv: String = InteractHdlr.obj_looking.nome
			if tv == "Tv":
				print(InteractHdlr.obj_looking)
				return InteractHdlr.obj_looking
			else:
				return null
		else:
			return null
	else:
		return null

func pausar()->void:
	var Tv = getTheTv()
	if Tv:
		Tv.Desligar()
	else:
		return

func trocarCanal() -> void:
	var Tv = getTheTv()
	if Tv:
		Tv.TrocarCanal()
	else:
		return

func Volume(up: bool) -> void:
	print(up)
	var Tv = getTheTv()
	if Tv:
		Tv.changeVol(up)
func trocarEntradaVideo() -> void:
	print("canalTrocado")
