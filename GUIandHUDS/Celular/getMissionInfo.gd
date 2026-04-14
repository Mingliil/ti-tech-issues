extends Button
var root: Control
@export var MissionInfo: MissoesData
@onready var preloadInfMis = preload("res://GUIandHUDS/Celular/Aplicativos/MissionInfo.tscn")
func _ready() -> void:
	pass

func _on_pressed() -> void:
	var InfMis = preloadInfMis.instantiate()
	root = get_parent().get_parent().get_parent().get_parent().get_parent()
	print(MissionInfo)
	
	print(InfMis.get_child(0))
	InfMis.get_child(0).size.x = root.size.x
	InfMis.get_child(0).size.y = root.size.y
	root.add_child(InfMis)
	root.get_child(0).queue_free()
	pass # Replace with function body.
