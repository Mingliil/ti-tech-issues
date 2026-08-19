extends RigidBody3D

@export var obj_vars: ObjectVariables
var iluminacao : float = 2
var lamp: Array[Node3D]

func _ready() -> void:
	if lamp.size() > 0:
		lamp.clear()
func turn_light() -> void:
	if lamp.size()>0:
		for i in lamp.size():
			var L = lamp[i].get_node("Luz").get_children()
			for c in L.size():
				print(c)
				if L[c].light_energy == 1 or L[c].light_energy == iluminacao:
					L[c].light_energy =0
				else:
					L[c].light_energy = iluminacao
					print(L[c].light_energy)
func Setlamp(lampada:Node) -> void:
	lamp.append(lampada)
	print(lamp)
