extends Area3D

const DialogueSysPreload = preload("res://GUIandHUDS/Dialogo/chat_gui.tscn")

@export var active_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector2
@export var dialogue: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(160,48)
var dialogue_bottom_pos: Vector2 = Vector2(160, 192)

var player_body_in: bool = false
var has_activated_already: bool = false
var desired_dialogue_pos: Vector2

var PLAYER: CharacterBody3D = null

func _ready() -> void:
	print(get_tree().get_first_node_in_group("Player"))
	PLAYER = get_tree().get_first_node_in_group()
func _process(delta: float) -> void:
	if PLAYER == null:
		PLAYER = get_tree().get_first_node_in_group("Player")
		print(PLAYER)
	if !active_instant and player_body_in:
		if only_activate_once and has_activated_already:
			set_process(false)
			return
		
		if Input.is_action_just_pressed("Interact"):
			_activate_dialogue()
			player_body_in = false
 
func _activate_dialogue() -> void:
	# PLAYER.move_and_slide() = false
	
	var new_dialogue = DialogueSysPreload.instantiate()
	
	if override_dialogue_position:
		desired_dialogue_pos = override_position
	#else:
	#	if PLAYER.global_position.y > get_viewport().get_camera_3d().y:
	#		desired_dialogue_pos = dialogue_top_pos
	#	else:
	#		desired_dialogue_pos = dialogue_bottom_pos
	new_dialogue.global_position = desired_dialogue_pos
	new_dialogue.dialogue = dialogue
	get_parent().add_child(new_dialogue)

func _on_body_entered(body: Node3D) -> void:
	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("Player"):
		player_body_in = true
		if active_instant:
			_activate_dialogue()
	pass

	
func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_body_in = false
	pass # Replace with function body.
