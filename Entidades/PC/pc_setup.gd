extends Node2D
var dentro: int
@export var InfoMonitor:Array[MonitorRes]
@onready var player: CharacterBody3D
@onready var subview: SubViewport = $SubJanela/SubViewport
@onready var janelaInsp = preload("uid://decafil0jcorv")
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
func _process(delta: float) -> void:
	match dentro:
		1:#pc
			if Input.is_action_just_released("ClickPrim"):
				if subview.get_node("JanelaBase"):
					pass
				else:
					_abrir_janela("Pc")
					dentro = false
		2:#monitor
			if Input.is_action_just_released("ClickPrim"):
				if subview.get_node("JanelaBase"):
					pass
				else:
					_abrir_janela("Monitor")
					dentro = false
		0:
			if Input.is_action_just_released("ClickPrim"):
				pass

func _on_computador_mouse_entered() -> void:
	dentro = 1
func _on_computador_mouse_exited() -> void:
	dentro = 0
func _on_monitor_mouse_entered() -> void:
	dentro = 2
func _on_monitor_mouse_exited() -> void:
	dentro = 0
	
func _abrir_janela(equipamento: String) -> void:
	var cena = janelaInsp.instantiate()
	subview.add_child(cena)
	print(equipamento)
