extends CharacterBody3D


var SPEED:float = 5.0
const JUMP_VELOCITY :float= 4.5
const NORMAL_HEIGHT:float= 1.8
const CROUCH_HEIGHT:float= NORMAL_HEIGHT/2
enum ActionType {Right,Left,ScrollUp, ScrollDown, F}
enum keygroup {KEY_1, KEY_2, KEY_3, KEY_4, KEY_5}
@export var interagindo: bool = false
@export var Inventory: InventoryData
@onready var handSprite: MeshInstance3D = $Head/MeshInstance3D
@onready var HUD: Control = $HUD
@onready var InvSlot:PackedScene = preload("uid://b7wrcxuqymh4u")
@onready var flavourText = preload("uid://ch8xv1204camr")
@export var selectedInvSlot: int = 1

func _ready() -> void:
	var invNode: HBoxContainer = HUD.get_node("Panel/Inv")
	for i in Inventory.Size:
		invNode.add_child(InvSlot.instantiate())
		invNode.get_child(i).setSlot(i+1)

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

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey:
		var i = OS.get_keycode_string(event.physical_keycode)
		var regex = RegEx.new()
		regex.compile("\\d+")
		var all_numbers_found = regex.search_all(i)
		for number in all_numbers_found:
			var number_found = int(number.get_string())
			if number_found:
				selectedInvSlot = number_found
	if Input.is_action_pressed("control"):
		SPEED = 2.5
		$CollisionShape3D.shape.height = CROUCH_HEIGHT
	elif Input.is_action_just_released("control"):
		SPEED = 5.0
		$CollisionShape3D.shape.height = NORMAL_HEIGHT
	if Input.is_action_pressed("altAction"):
		if Input.is_action_just_pressed("ItemAction"):
			useItemFunction(true,ActionType.F)
	elif Input.is_action_just_pressed("ItemAction"):
		useItemFunction(false,ActionType.F)
	if Input.is_action_just_pressed("clickEsq"):
			if Input.is_action_pressed("altAction"):
				useItemFunction(true,ActionType.Left)
			else:
				useItemFunction(false,ActionType.Left)
	elif Input.is_action_just_pressed("clickDir"):
		if Input.is_action_pressed("altAction"):
			useItemFunction(true,ActionType.Right)
		else:
			useItemFunction(false,ActionType.Right)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			useItemFunction(false, ActionType.ScrollDown)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			useItemFunction(false, ActionType.ScrollUp)
	if event is InputEventKey:

		if event.as_text_keycode().to_int() >= 1 and event.as_text_keycode().to_int() <= 5:
			selectedInvSlot = event.as_text_keycode().to_int()
			
		if Input.is_action_just_pressed("soltar"):
			DropItem()

func playFlavourText(NewText: String) -> void:
	HUD.add_child(flavourText.instantiate())
	HUD.get_node("Flavour Text/MarginContainer/Label").text = NewText

func getItemToInventory(Item: Node3D) -> void:
	if !Inventory.InvItens.size() >= Inventory.Size:
		var inv = HUD.get_node("Panel/Inv")
		var itemvar: ItemData
		if "itemVars" in Item:
			itemvar = Item.itemVars
		else:
			return
		var slot = inv.get_child(selectedInvSlot-1)
		Inventory.InvItens.append(itemvar)
		Inventory.ItenSlot.append(selectedInvSlot)
		slot.setIcon(itemvar.ItemSprite)
		Item.queue_free()
		pass
	else:
		playFlavourText("Inventário cheio")

func DropItem() -> void:
	if Inventory.InvItens.size():
		var i = getSelectedItem()
		if i == -1:
			return
		else:
			var resPath: String = Inventory.InvItens[i].resource_path
			
			print(resPath)
			var itemRealObjload: PackedScene = load(resPath.get_slice("::", 0))
			get_tree().root.add_child(itemRealObjload.instantiate())
			get_tree().root.get_child(-1).position = getMouseWorldPosReturn(get_viewport().get_mouse_position(),1)
			Inventory.InvItens.remove_at(i)
			Inventory.ItenSlot.remove_at(i)
			var inv = HUD.get_node("Panel/Inv")
			var slot = inv.get_child(selectedInvSlot-1)
			slot.setIcon(null)
	pass

func getSelectedItem()-> int:
	if Inventory.ItenSlot.size()>=1:
		for i in Inventory.ItenSlot.size():
			if Inventory.ItenSlot[i] == selectedInvSlot:
				if Inventory.InvItens[i]:
					return i
				else:
					return -1
			else:
				return -1
		return -1
	return -1

func useItemFunction(alt: bool, button: ActionType) -> void:
	var o = getSelectedItem()
	if o == -1:
		return
	var item = Inventory.InvItens[o] 
	print(item)
	if !item:
		return
	print("é uma ação alt?: ",alt)
	for i in item.Funtions.size():
		print(i)
		print(item.Funtions[i].FunctionType, "teste e ", button)
		if item.Funtions[i].FunctionType == button and item.Funtions[i].alternativeFunction == alt:
			var funcScript = item.Itemfunction.new()
			funcScript.callv(item.Funtions[i].FunctionName, item.Funtions[i].FunctionVars)
			#pass


func getMouseWorldPosReturn(mouse: Vector2, DIST: float) -> Vector3:
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
	return params.to
