extends Control

@export var parentNode: Node
enum States{Interagindo, Normal, NoMenu}
var player
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player = get_tree().get_first_node_in_group("PLAYER")
	player.currentState = States.Interagindo

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		sair()
	if event is InputEventMouseButton:
		sair()
func sair():
	player.currentState = States.Normal
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
