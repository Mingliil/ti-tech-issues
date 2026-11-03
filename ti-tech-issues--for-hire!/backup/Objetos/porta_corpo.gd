extends RigidBody3D

@export var obj_vars: ObjectVariables
@onready var portaRoot = $"../.."


var abrirporta = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _abrirPorta() ->void:
	SceneLoader.load_scene("res://Areas/predio_dentro_corredor.tscn",Vector3(12.68,0,0))
	portaRoot.podetrancar = false
	linear_velocity.x += abrirporta
