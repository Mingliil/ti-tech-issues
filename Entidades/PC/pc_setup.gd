extends Node2D

@onready var player: CharacterBody3D
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
func _process(delta: float) -> void:
	pass

func _on_computador_mouse_entered() -> void:
	print("pc entrou")
	pass # Replace with function body.


func _on_computador_mouse_exited() -> void:
	print("pc saiu")


func _on_monitor_mouse_entered() -> void:
	print("monitor entrou")
	pass # Replace with function body.


func _on_monitor_mouse_exited() -> void:
	print("monitor saiu")
