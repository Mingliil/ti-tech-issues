extends CharacterBody3D
class_name PlayerCode


var SPEED = 9.0
var SprtSpeed = 13.0
var JUMP_VELOCITY = 4.5
signal PlSpeed(Plspeed)
signal interact(Interact)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("Sprint") and is_on_floor():
		SPEED = SprtSpeed
	elif not Input.is_action_pressed("Sprint") and is_on_floor():
		SPEED = 9
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("esquerda", "direita", "cima", "baixo")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_just_pressed("ui_down"):
		print(get_tree().get_nodes_in_group("Player"))
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("interact", true)
	emit_signal("PlSpeed", velocity)
	move_and_slide()
