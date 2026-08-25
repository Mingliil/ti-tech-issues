extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
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
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			selectedInvSlot -= 1
			if selectedInvSlot <= 0:
				selectedInvSlot = 5
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			selectedInvSlot += 1
			if selectedInvSlot >= 6:
				selectedInvSlot = 1
		print(selectedInvSlot)
		if event.button_index == MOUSE_BUTTON_LEFT:
			useItemFunction("left")
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			useItemFunction("right")
	if event is InputEventKey:
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

func useItemFunction(button: String) -> void:
	var i = getSelectedItem()
	if i == -1:
		return
	var item: ItemData = Inventory.InvItens[i]
	if item.Itemfunction:
		var funcScript = item.Itemfunction.new()
		match button:
			"left":
				funcScript.call(item.LeftClickFunction)
			"right":
				funcScript.call(item.RightClickFunction)
			_:
				pass


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
