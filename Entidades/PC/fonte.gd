extends Node3D
@onready var camera: Camera3D
var canHold: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_3d()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	canHold = true
func _on_mouse_exited() -> void:
	canHold = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ClickPrim") and canHold:
		print("segurando")
		var z = 1
		var position2D = get_viewport().get_mouse_position()
		var dropPlane  = Plane(Vector3(0, 0, 1), z)
		var position3D = dropPlane.intersects_ray(
							 camera.project_ray_origin(position2D),
							 camera.project_ray_normal(position2D))
		position = position3D
