extends Node3D
func _input(event: InputEvent) -> void:
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
