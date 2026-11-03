extends Node3D

var sensibilidade :=0.5
enum States{Interagindo, Normal, NoMenu}

@onready var player = get_parent()
@export var originalPos: Vector3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if player.currentState == player.States.Normal:
		if event is InputEventMouseMotion:
			get_parent().rotate_y(deg_to_rad(-event.relative.x*sensibilidade))
			rotate_x(deg_to_rad(-event.relative.y * sensibilidade))
			rotation.x = clamp(rotation.x,deg_to_rad(-90), deg_to_rad(90))
			originalPos = $Cam.position
	

func returnCameraPos()->void:
	$Cam.position = originalPos
