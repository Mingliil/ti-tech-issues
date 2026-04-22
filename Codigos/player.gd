extends CharacterBody3D
class_name PlayerCode

@export var JUMP_VELOCITY = 4.5
@export var PlayerStats: Array[PRE]
@onready var camera = $Pivot/PlayerCam
@onready var Phone = preload("res://GUIandHUDS/Celular/celular.tscn")
var celularNaTela: bool = false
signal PlSpeed(Plspeed)
signal interact(Interact)

func _ready() -> void:
	camera.make_current()
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tab"):
		var celular
		if !celularNaTela:
			celular = Phone.instantiate()
			celularNaTela = true
			get_parent().add_child(celular)
		else:
			var i = get_parent().get_node("Celular")
			i.queue_free()
			celularNaTela = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var i = PlayerStats[0]
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if i.podeMover == true:
		if Input.is_action_just_pressed("pulo") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("Sprint") and is_on_floor():
			i.baseSpeed = i.sprintSpeed
		elif not Input.is_action_pressed("Sprint") and is_on_floor():
			i.baseSpeed = 9
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("esquerda", "direita", "cima", "baixo")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * i.baseSpeed
			velocity.z = direction.z * i.baseSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, i.baseSpeed)
			velocity.z = move_toward(velocity.z, 0, i.baseSpeed)
		if Input.is_action_just_pressed("Interact"):
			if PlayerStats[0].podeInteragir:
				emit_signal("interact", 1)
		emit_signal("PlSpeed", velocity)
	i.velocidadeAtual = velocity

	move_and_slide()
	
