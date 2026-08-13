extends RigidBody3D




var objectMovable
@export var obj_vars: ObjectVariables

signal interact

@onready var subView = $Contrato/SubView
@onready var paperText = $Contrato/SubView/PaperInf. get_child(0).get_child(0)
func _ready() -> void:
	if $"." is RigidBody3D or StaticBody3D:
		objectMovable = self
	else:
		for i in get_child_count():
			var child = get_child(i)
			if child is RigidBody3D or StaticBody3D:
				objectMovable = child
				break
	interact.connect(Interact)
	print("DEBUG - objeto: ",objectMovable)
func Interact() -> void:
	pass
func InsertContractInfo(infoContrato) -> void:
	print("foi ", infoContrato)
