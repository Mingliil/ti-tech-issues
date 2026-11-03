extends StaticBody2D
const tile_size: Vector2 = Vector2(84,100)

var segurado: bool = false
var podeSegurar: bool = false
func _physics_process(delta: float) -> void:
	if segurado:
		global_position = get_global_mouse_position().snapped(tile_size) + tile_size/2
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and podeSegurar:
			segurado = true
	


func _on_mouse_entered() -> void:
	podeSegurar = true
func _on_mouse_exited() -> void:
	podeSegurar = false
