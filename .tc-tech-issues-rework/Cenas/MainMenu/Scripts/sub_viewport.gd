extends SubViewport

const DIST = 9000000.0
var mouse
@onready var camera3d = $"../../CamNode/Camera"
@onready var mainRoot = $"../../.."
@export var msg: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			print(msg)
	pass
