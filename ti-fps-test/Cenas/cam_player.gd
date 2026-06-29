extends Camera3D

@onready var player = $"../.."
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if !player.interagindo:
		if event is InputEventMouseButton:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				rotate_x(-event.relative.y * 0.01)
				get_parent().rotate_y(-event.relative.x * 0.01)
				rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
