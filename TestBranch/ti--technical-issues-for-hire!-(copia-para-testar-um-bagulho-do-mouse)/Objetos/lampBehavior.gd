extends StaticBody3D

@export var interruptor: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if interruptor:
		interruptor.Setlamp(self)
