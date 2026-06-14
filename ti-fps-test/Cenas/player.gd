extends CharacterBody3D

var config = ConfigFile.new()
var obj_picker = load("res://Interação/Obj_Gravity_picker.gd")

const RAY_LENGTH = 1000
var SPEED
var JUMP_VELOCITY
var altura = 1
var altura_agachada = 0.5
var segura_agacha:bool = false
var sprint = 1.0
var max_stamina = 10
var max_sanidade = 10
@export var resting: int #-1 sleeping, 0 resting, 1 walking, 2 running
@export var estamina_atual:float
@export var sanidade_atual:float
@onready var modelo = $Modelo
@onready var colisao = $Colisao
@onready var statusDisplay = $Neck/Control/Status
func _ready() -> void:
	var err = config.load("res://Resources/Config.cfg")
	if err != OK:
		print("NO CONFIG FILE FOUND")
	else:
		print("CFG: OK")
		SPEED = config.get_value("PlayerData", "Speed")
		JUMP_VELOCITY = config.get_value("PlayerData", "Jump_Height")
		altura = config.get_value("PlayerData", "altura")
		altura_agachada = config.get_value("PlayerData", "altura_agachada")
		segura_agacha = config.get_value("PlayerData", "segurar_agacho")
		max_stamina = config.get_value("PlayerData", "max_estamina")
		max_sanidade = config.get_value("PlayerData", "max_sanidade")
		print(config.get_section_keys("PlayerData"))
		sanidade_atual = max_sanidade
		estamina_atual = max_stamina
		statusDisplay.get_node("Estamina").text = "Estamina: %s" %estamina_atual
		statusDisplay.get_node("Sanidade").text = "Sanidade: %s" %sanidade_atual
		


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("agachar"): 
		colisao.shape.height = altura_agachada
		modelo.mesh.height = altura_agachada
	else:
		colisao.shape.height = altura
		modelo.mesh.height = altura
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("esquerda", "direita", "frente", "tras")
	var direction = (get_node("Neck").transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		
		resting = 1
		if Input.is_action_pressed("correr") and estamina_atual > 20:
			sprint = config.get_value("PlayerData", "vel_correr")
			resting = 2
		else:
			sprint = 1
		velocity.x = direction.x * SPEED * sprint
		velocity.z = direction.z * SPEED * sprint
	else:
		resting = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	print(direction)
	move_and_slide()


func _on_update_tick_timeout() -> void:
	if estamina_atual >= max_stamina and resting <=0:
		estamina_atual = max_stamina
	else:
		match resting:
			-1: #dormindo/relaxando
				estamina_atual = snapped(estamina_atual + 0.005, 0.001)
				statusDisplay.get_node("Estamina").text = "Estamina: %s" %snapped(estamina_atual, 0.01)
				pass
			0: # parado/descansando
				estamina_atual = snapped(estamina_atual + 0.0005, 0.0001)
				statusDisplay.get_node("Estamina").text = "Estamina: %s" %snapped(estamina_atual, 0.01)
				pass
			1: # andando
				estamina_atual = snapped(estamina_atual - 0.001, 0.0001)
				statusDisplay.get_node("Estamina").text = "Estamina: %s" %snapped(estamina_atual, 0.01)
				pass
			2: # correndo
				estamina_atual = snapped(estamina_atual - 0.005, 0.001)
				statusDisplay.get_node("Estamina").text = "Estamina: %s" %snapped(estamina_atual, 0.01)
				pass
		if estamina_atual < 0:
			estamina_atual = 0
	#print(resting, estamina_atual)
