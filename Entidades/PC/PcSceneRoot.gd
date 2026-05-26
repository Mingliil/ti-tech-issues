extends Node3D

@export var Lista_Gabinete: Array[PackedScene]
func _ready() -> void:
	var objPicker= preload("uid://chc1s6pahdmib").new()
	add_child(objPicker)
	add_child(Lista_Gabinete[0].instantiate())
	get_node("Gabinete").position =Vector3(0,3.0,0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
