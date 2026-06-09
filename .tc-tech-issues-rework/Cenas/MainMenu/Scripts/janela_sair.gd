extends Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_sim_pressed() -> void:
	await get_tree().create_timer(1).timeout
	get_tree().quit()

func _on_não_pressed() -> void:
	get_tree().get_first_node_in_group("Root").consegueInteragir = true
	queue_free()
