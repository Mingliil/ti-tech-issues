extends Node


var objectMovable
@export var obj_vars: ObjectVariables

signal interact


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
	obj_vars.IntObject = objectMovable.get_path()
	print("DEBUG - objeto: ",objectMovable)
	print("DEBUG - caminho: ",obj_vars.IntObject)
func Interact() -> void:
	pass
