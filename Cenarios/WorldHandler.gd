extends Node3D
class_name WorldHandler
@onready var playerpreload = preload("res://Entidades/player.tscn")
@onready var testWorld = preload("res://Cenarios/test world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(playerpreload.instantiate())
	var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")
	player.position = Vector3(2,5,5)
	add_child(testWorld.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
