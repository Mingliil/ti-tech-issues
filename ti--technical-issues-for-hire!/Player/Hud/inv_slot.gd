extends PanelContainer

@export var slotNum : int
@onready var SlotNumLabel:Label = $SlotNumber
@onready var ItemIcon: TextureRect= $MarginContainer/SlotTexture

func setSlot(num:int) -> void:
	slotNum = num
	SlotNumLabel.text = "%s" %slotNum

func setIcon(image: CompressedTexture2D) -> void:
	ItemIcon.texture = image
