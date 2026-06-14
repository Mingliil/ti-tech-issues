extends Node3D

@export var DisplaySize:Vector2 = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D/SubViewport.size = $Sprite3D/SubViewport/HBoxContainer.size
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
