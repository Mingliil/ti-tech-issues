extends Button

func _ready() -> void:
	pass

func _on_pressed() -> void:
	print(get_parent().get_node("MissionHub"))
	pass # Replace with function body.
