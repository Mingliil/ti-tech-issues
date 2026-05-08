extends TextureRect

@onready var icon = $icon
@onready var quantity = $quantity


#setup the slot data
func set_slot(data:Dictionary):
	quantity.hide()
	if data.is_empty():
		tooltip_text = ""
		icon.texture = null
		return
	tooltip_text = GameData.get_item_name(data.item_name)
	icon.texture = Inventory.get_item_texture(data.item_name)
	quantity.text = "%2d" % data.quantity
	if data.quantity > 1:
		quantity.show()

#begin of a drag from this slot generate data needed
func _get_drag_data(at_position: Vector2) -> Variant:
	if Inventory.inventory[name].is_empty():
		return
	var prev = Control.new()
	var picon = TextureRect.new()
	picon.position -= Vector2(32,32)
	picon.texture = icon.texture
	prev.add_child(picon)
	set_drag_preview(prev)
	modulate = Color(1,1,1,0.5)
	var data = Inventory.inventory[name].duplicate()
	if Input.is_action_pressed("shift"):
		if data.quantity > 1:
			data.quantity = round(data.quantity/2)
	elif Input.is_action_pressed("control"):
		data.quantity = 1
	
	data.from_slot = name
	data.dragged = self
	print(data)
	return data

#check if data can be dropped on this slot
#useful for equipment i.e swords can only go in weapon slot
#just returning true here
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
#drop the data on this slot
#make all changes here 
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if typeof(data.from_slot) == TYPE_INT: #An equipment slot
		Inventory.unequip_item(data.from_slot,name)
		data.dragged.set_slot(Inventory.equipment[data.from_slot])
	else:
		Inventory.move_item(data.quantity,data.from_slot,name)
		data.dragged.set_slot(Inventory.inventory[data.from_slot])
	set_slot(Inventory.inventory[name])
#end of a drag
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1,1,1,1)
		
#input on this slot to show context menu
func _gui_input(event: InputEvent) -> void:
	if Inventory.inventory[name].is_empty():
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_released():
				%PopupMenu.open(self)
