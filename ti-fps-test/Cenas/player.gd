extends CharacterBody3D

var config = ConfigFile.new()
var obj_picker = load("res://Interação/Obj_Gravity_picker.gd")

const RAY_LENGTH = 1000
var SPEED
var JUMP_VELOCITY
func _ready() -> void:
	var err = config.load("res://Resources/Config.cfg")
	if err != OK:
		print("NO CONFIG FILE FOUND")
	else:
		print("CFG: OK")
		SPEED = config.get_value("PlayerData", "Speed")
		JUMP_VELOCITY = config.get_value("PlayerData", "Jump_Height")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("esquerda", "direita", "frente", "tras")
	var direction = (get_node("Neck").transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
#raycast int

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == 1:	
		#var space_state = get_world_3d().direct_space_state
		#var camera3d = $Neck/CamPlayer
		#var from = camera3d.project_ray_origin(event.position)
		#var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		#var query = PhysicsRayQueryParameters3D.create(from, to)
		#query.collide_with_areas = true
		#var result = space_state.intersect_ray(query)
		#print(result)
