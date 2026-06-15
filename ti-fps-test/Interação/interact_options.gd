extends Node3D

@export var DisplaySize:Vector2 = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D/SubViewport.size = $Sprite3D/SubViewport/HBoxContainer.size
	$Sprite3D.offset.x = $Sprite3D/SubViewport.size.x / 4
	print($Sprite3D/SubViewport.size)
	pass # Replace with function body.
