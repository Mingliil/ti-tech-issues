extends Node3D
@onready var player: CharacterBody3D
@onready var preloadPcSetup = preload("res://Entidades/PC/PcSetup.tscn")
@export var infoSetup: Array[PCE] #1 PC - 2 monitor
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _on_area_entered(area: Area3D) -> void:
	player.interact.connect(acesso_setup)
func _on_area_exited(area: Area3D) -> void:
	player.interact.disconnect(acesso_setup)

func acesso_setup(Interact: Variant) -> void:
	var pc = preloadPcSetup.instantiate()
	add_to_group("CurrentPC")
	player.add_child(pc)
	player.PlayerStats[0].podeInteragir = false
	player.PlayerStats[0].podeMover = false
