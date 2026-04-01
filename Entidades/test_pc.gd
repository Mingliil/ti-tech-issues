extends Node3D

const DialogueSysPreload = preload("res://GUIandHUDS/Dialogo/chat_gui.tscn")
@export var active_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector2
@export var option0: Array[DE]
@export var option1: Array[DE]
@export var option2: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(160,48)
var dialogue_bottom_pos: Vector2 = Vector2(160, 192)

var player_body_in: bool = false
var has_activated_already: bool = false
var desired_dialogue_pos: Vector2

func _option_dialogue(escolha: int) -> void:
	# PLAYER.move_and_slide() = false
	var new_dialogue = DialogueSysPreload.instantiate()
	print(get_children())
	var ChatGUI = get_tree().get_first_node_in_group("Dialogue")
	
	print(ChatGUI)
	if ChatGUI != null:
		ChatGUI.visible = false
		print("teste")
	if override_dialogue_position:
		desired_dialogue_pos = override_position
	#else:
	#	if PLAYER.global_position.y > get_viewport().get_camera_3d().y:
	#		desired_dialogue_pos = dialogue_top_pos
	#	else:
	#		desired_dialogue_pos = dialogue_bottom_pos
	new_dialogue.global_position = desired_dialogue_pos
	match escolha:
		0:
			new_dialogue.dialogue = option0
	
	get_parent().add_child(new_dialogue)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
