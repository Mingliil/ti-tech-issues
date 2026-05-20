extends RigidBody3D

@export var tipo_peca: PCCOMP
@export var segurado: bool
var rebound_speed = 3
var place_limit: Vector3 = Vector3(5,5,5)
func _physics_process(delta: float) -> void:
	var pX = position.x
	var pY = position.y
	var pZ = position.z
	if !segurado:
		if pX > 0:
			if pX > place_limit.x:
				linear_velocity.x += -rebound_speed
		elif pX < 0:
			if pX < -place_limit.x:
				linear_velocity.x += rebound_speed
		if pY > 0:
			if pY > place_limit.y:
				linear_velocity.y += -rebound_speed
		elif pY < 0:
			if pY < -place_limit.y:
				linear_velocity.y += rebound_speed
		if pZ > 0:
			if pZ > place_limit.z:
				linear_velocity.z += -rebound_speed
		elif pZ < 0:
			if pZ < -place_limit.z:
				linear_velocity.z += rebound_speed
