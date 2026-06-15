extends RigidBody3D

@onready var modelo: MeshInstance3D = $Mesh



@export var obj_vars: Array[UniResExpo]
signal interact
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact.connect(on_interact)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_interact() -> void:
	print("deu certo")
