extends Node3D


var fechado: bool = false
@export var podetrancar: bool = false
@onready var corpo = $Hinge/PortaCorpo
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if corpo.rotation_degrees.x <= -89.9 and podetrancar:
		fechado = true
	if !podetrancar:
		fechado = false

	if fechado:
		corpo.lock_rotation = true
	else:
		corpo.lock_rotation = false

func _entered(body: Node3D) -> void:
	if body == get_node("Hinge/PortaCorpo"):
		podetrancar = true
