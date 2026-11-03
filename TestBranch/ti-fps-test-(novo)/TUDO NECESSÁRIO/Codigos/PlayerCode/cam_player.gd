extends Camera3D
@export var Override: bool = false
@onready var player = $"../.."

func _unhandled_input(event: InputEvent) -> void:
	if !player.interagindo or Override:
		if event is InputEventMouseButton:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				rotate_x(-event.relative.y * 0.01)
				get_parent().rotate_y(-event.relative.x * 0.01)
				rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

func override_cam_pos(OverridePos: Vector3, OverrideRot: Vector3) -> void:
	if !Override:
		position = OverridePos
		rotation = OverrideRot
		Override = true
	else:
		Override = false
