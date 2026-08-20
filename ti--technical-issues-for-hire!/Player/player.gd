extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var interagindo: bool = false
@export var Inventory: InventoryData
@onready var hand: HingeJoint3D = $Head/Hand
@onready var HUD: Control = $HUD
@onready var InvSlot:PackedScene = preload("uid://b7wrcxuqymh4u")
func _ready() -> void:
	for i in Inventory.Size:
		HUD.get_node("Panel/Inv").add_child(InvSlot.instantiate())
	
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("esquerda", "direita", "frente", "tras")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func getItemToInventory(Itemnode:Node3D) -> void:
	print(Itemnode.itemVars)
	if Itemnode is RigidBody3D:
		hand.node_b = Itemnode.get_path()
		Itemnode.position = hand.position
	pass
