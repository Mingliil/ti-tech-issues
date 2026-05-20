extends Area3D
var dentro = false
var body
func _on_area_entered(area: Area3D) -> void:
	body = area.get_parent()
	if body.tipo_peca.fonte:
		dentro = true

func _on_area_exited(area: Area3D) -> void:
	dentro = false
func _process(delta: float) -> void:
	if dentro:
		if !body.segurado:
			body.freeze = true
			body.position = position
