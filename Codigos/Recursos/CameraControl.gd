extends Node3D

var zoomSpeed = 1
@onready var subpiv = $SubPivot 
func _input(event: InputEvent) -> void:
	
	#lida com o zoom, talvez coloque em uma função separada
	if Input.is_action_just_released("scrool_cima"):
		if scale.z <= 1:
			pass
		else:
			scale.z -= zoomSpeed
	elif Input.is_action_just_released("scroll_baixo"):
		if scale.z >= 7:
			pass
		else:
			scale.z += zoomSpeed
	
	#lida com o movimento da camera
	if Input.is_action_pressed("ClickSec"):
		if event is InputEventMouseMotion:
			#input cima/baixo
			if event.relative.x > 0:
				print(event.relative.x)
				rotation.y += event.relative.x *0.05
			elif event.relative.x < 0:
				print(event.relative.x)
				rotation.y += event.relative.x *0.05
			#input lados
			if event.relative.y > 0:
				print(event.relative.y)
				rotation.x -= event.relative.y *0.05
			elif event.relative.y < 0:
				print(event.relative.y)
				rotation.x -= event.relative.y *0.05
