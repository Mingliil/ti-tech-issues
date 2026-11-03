extends Node3D
var fonte
@export var pickable:bool = false
@export var GabineteRes: Array[PCE]
@onready var reparScript = preload("res://Codigos/ReparentScript.gd")


func _ready() -> void:
	if !GabineteRes[0].temFonte:
		fonte = get_node("Fonte")
		if fonte:
			var ScenRoot = get_parent()
			fonte.reparent(ScenRoot, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
