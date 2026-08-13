extends Node3D


var fechado: bool = false
@export var podetrancar: bool = false
@onready var corpo = $Hinge/PortaCorpo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if corpo.rotation_degrees.x <= -89.9 and podetrancar:
		fechado = true
		podetrancar = false
	if !podetrancar:
		fechado = false
	if fechado:
		corpo.lock_rotation = true
	else:
		corpo.lock_rotation = false

func _on_timeout() -> void:
	podetrancar = true
