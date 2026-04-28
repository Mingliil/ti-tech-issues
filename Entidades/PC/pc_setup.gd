extends Node2D
var dentro
@onready var player: CharacterBody3D
@onready var cenatest = preload("uid://decafil0jcorv")
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
func _process(delta: float) -> void:
	if dentro:
		if Input.is_action_just_released("ClickPrim"):
			_abrir_janela(cenatest)
			print("pc entrou")
			dentro = false

func _on_computador_mouse_entered() -> void:
	dentro = true
	pass # Replace with function body.


func _on_computador_mouse_exited() -> void:
	print("pc saiu")


func _on_monitor_mouse_entered() -> void:
	print("monitor entrou")
	pass # Replace with function body.


func _on_monitor_mouse_exited() -> void:
	print("monitor saiu")
	
func _abrir_janela(Cenapreload: PackedScene) -> void:
	var cena = Cenapreload.instantiate()
	add_child(cena)
