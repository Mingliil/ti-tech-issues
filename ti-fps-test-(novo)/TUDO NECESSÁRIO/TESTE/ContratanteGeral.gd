extends Node3D


@onready var camPoint: Node3D = $Mesa/CamPoint
@onready var contratante = $NPCContratante
@onready var mesa = $Papeis
@onready var contratoPapelPreload = preload("uid://pk11td747jl6")
var player: Node3D
var LookMode:bool = false
var contratos: Array[ContractInfo]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER")
	contratos = contratante.Contracts
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
func ContratosLook() -> void:
	for i in contratos.size():
		var papel = contratoPapelPreload.instantiate()
		mesa.add_child(papel)
		print(mesa.get_child(i))
		mesa.get_child(i).InsertContractInfo(contratos[i])
	player.get_node("CharacterBody3D/Neck").position = camPoint.position
	player.get_node("CharacterBody3D/Modelo").visible = false
	player.get_node("CharacterBody3D").interagindo = true
	LookMode = true
