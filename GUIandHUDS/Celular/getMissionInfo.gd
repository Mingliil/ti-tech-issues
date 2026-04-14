extends Button
var root: Control
@export var MissionInfo: MissoesData
func _ready() -> void:
	pass

func _on_pressed() -> void:
	root = get_parent().get_parent().get_parent().get_parent().get_parent()
	print(MissionInfo)
	root.get_child(0).queue_free()
	pass # Replace with function body.
