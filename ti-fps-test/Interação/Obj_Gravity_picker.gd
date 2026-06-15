extends Node3D

var grabbed_object = null
var obj_looking = null
var mouse = Vector2()
var last_obj_looking = null


@export var grab_distance = 3
var pegar_obj = false
const DIST = 50 #Ray Max distance
var I = 300.0 #influence #export to make adjustable
var S = 20.0 #stiffness #export to make adjustable

var IntOptPreload = preload("res://Interação/Interact_Options.tscn")
func _process(delta: float) -> void:
	if grabbed_object:
		if grabbed_object is RigidBody3D:
			lift_item(grabbed_object,get_grab_position(),delta)
		else:
			grabbed_object.position = get_grab_position()
	#print(obj_looking)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position
		get_mouse_world_pos(mouse)
	if Input.is_action_just_pressed("interagir"):
		if !pegar_obj:
			if obj_looking:
				grabbed_object = obj_looking
				if grabbed_object.get_node("IntOptionsRoot"):
					grabbed_object.get_node("IntOptionsRoot").queue_free()
				if grabbed_object:
					if "obj_vars" in grabbed_object:
						if !obj_looking.obj_vars[0].pickable:
							grabbed_object = null
							pegar_obj = false
						else:
							pegar_obj = true
					else:
						grabbed_object = null
						pegar_obj = false
		else:
			grabbed_object = null
			pegar_obj = false
		print(pegar_obj)
		
	#if event is InputEventMouseButton:
		#if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			#if obj_looking:
				#grabbed_object = obj_looking
				#if grabbed_object.get_node("IntOptionsRoot"):
					#grabbed_object.get_node("IntOptionsRoot").queue_free()
				#if grabbed_object:
					#if "pickable" in grabbed_object:
						#if !grabbed_object.pickable:
							#grabbed_object = null
					#else:
						#grabbed_object = null
			#else:
				#pass
		#elif event.pressed == false and event.button_index == MOUSE_BUTTON_RIGHT:
			#grabbed_object = null


func get_mouse_world_pos(mouse:Vector2):
	#The physics state of the world
	var space = get_world_3d().direct_space_state
	#start and end world positions for the ray
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse,DIST)
	#Params for 3D raycast
	#Alt var params = PhysicsRayQueryParameters3D.create(start,end)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	#cast the ray using the space and return the results as a Dictionary
	var result = space.intersect_ray(params)
	if result.is_empty() == false:
		obj_looking = result.collider
		if "obj_vars" in obj_looking and !grabbed_object:
			if obj_looking.obj_vars[0].pickable:
				show_interact_options()
				if last_obj_looking != obj_looking and last_obj_looking:
					if last_obj_looking.get_node("IntOptionsRoot"):
						last_obj_looking.get_node("IntOptionsRoot").queue_free()
				last_obj_looking = obj_looking
		else:
			obj_looking = null
			if last_obj_looking:
				if last_obj_looking.get_node("IntOptionsRoot"):
					last_obj_looking.get_node("IntOptionsRoot").queue_free()
	elif last_obj_looking:
		if last_obj_looking.get_node("IntOptionsRoot"):
			last_obj_looking.get_node("IntOptionsRoot").queue_free()

func show_interact_options() -> void:

		if !obj_looking.get_node("IntOptionsRoot"):
			obj_looking.add_child(IntOptPreload.instantiate())
		else:
			if last_obj_looking != obj_looking:
				if last_obj_looking.get_node("IntOptionsRoot"):
					last_obj_looking.get_node("IntOptionsRoot").queue_free()
			pass

#Get the position in the world you want to object to follow
func get_grab_position():
	return get_viewport().get_camera_3d().project_position(mouse,grab_distance)

func lift_item(item:RigidBody3D,target_position:Vector3,delta):
		#attach to objects to move

		var P = target_position - item.global_position
		var M = item.mass
		var V = item.linear_velocity
		var impulse = (I*P) - (S*M*V)
		item.apply_central_impulse(impulse * delta)
