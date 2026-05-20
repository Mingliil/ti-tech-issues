extends RigidBody3D

@export var tipo_peca: PCCOMP
@export var segurado: bool
var place_limit: Vector3 = Vector3(5,5,5)
func _physics_process(delta: float) -> void:
	var pX = position.x
	var pY = position.y
	var pZ = position.z
	if pX > 0:
		if pX > place_limit.x:
			linear_velocity.x = -2
	elif pX < 0:
		if pX < -place_limit.x:
			linear_velocity.x = 2
	if pY > 0:
		if pY > place_limit.y:
			linear_velocity.y = -2
	elif pY < 0:
		if pY < -place_limit.y:
			linear_velocity.y = 2
	if pZ > 0:
		if pZ > place_limit.z:
			linear_velocity.z = -2
	elif pZ < 0:
		if pZ < -place_limit.z:
			linear_velocity.z = 2
