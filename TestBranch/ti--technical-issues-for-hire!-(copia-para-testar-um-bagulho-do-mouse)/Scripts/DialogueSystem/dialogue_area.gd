extends Area3D

const DialogueSysPreload = preload("uid://ca4whgc5wgkjp")

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
	PLAYER = get_tree().get_first_node_in_group("Player")
 
func _activate_dialogue(diag: Array[DE]) -> void:
	var new_dialogue = DialogueSysPreload.instantiate()
	new_dialogue.dialogue = diag
	PLAYER.get_node("HUD").add_child(new_dialogue)
