extends Button
var rot: Control
@export var MissionInfo: MissoesData
@onready var preloadInfMis = preload("res://GUIandHUDS/Celular/Aplicativos/MissionInfo.tscn")
func _on_pressed() -> void:
	var InfMis = preloadInfMis.instantiate()
	rot = get_parent().get_parent().get_parent().get_parent().get_parent()
	InfMis.MissionInf = MissionInfo
	rot.add_child(InfMis)
	get_tree().root.get_node("Celular").adapt_app_size(1)
	rot.get_child(0).queue_free()
