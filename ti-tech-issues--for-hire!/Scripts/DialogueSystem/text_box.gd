extends PanelContainer

@onready var DialogueLabel: RichTextLabel
@onready var SpeakerSprite: TextureRect = $TextureRect
@onready var ButtaoContainer: VBoxContainer = $VBoxContainer/MarginContainer/DiagOptions
@onready var FalaNome: Label = $VBoxContainer/Nome
func FixSize()->void:
	pass
