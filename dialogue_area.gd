extends Area3D

const DialogueSysPreload = preload("res://GUIandHUDS/Dialogo/chat_gui.tscn")

@export var active_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector3
@export var dialogue: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(160,48)
var dialogue_bottom_pos: Vector2 = Vector2(160, 192)

var player_body_in: bool = false
var has_activated_already: bool = false
var desired_dialogue_pos: Vector2

var PLAYER: CharacterBody3D = null

func _ready() -> void:
	PLAYER = get_tree().get_first_node_in_group("player")

func _on_body_entered(body: Node3D) -> void:
	
	pass # Replace with function body.


func _on_body_exited(body: Node3D) -> void:
	
	pass # Replace with function body.
