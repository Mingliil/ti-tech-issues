extends RigidBody3D

@export var obj_vars: ObjectVariables
@export var connectedPc: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if connectedPc:
		connectedPc.Pc_Comp.Mouse = self.get_path()
