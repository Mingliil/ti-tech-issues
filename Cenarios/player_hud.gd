extends Control

@onready var PLAYER
var PlayerIntArea
@onready var velText
@onready var statsText
func _ready() -> void:
	PLAYER = get_tree().get_first_node_in_group("Player")
	velText = get_node("velocidade")
	statsText = get_node("Stats")
	print(PLAYER.PlayerStats[0].sanidade)
	PlayerIntArea = PLAYER.find_child("Area3D")

func _process(delta: float) -> void:
	statsText.text = "sanidade: %s" %PLAYER.PlayerStats[0].sanidade
	velText.text = "velocidade: %s" %PLAYER.PlayerStats[0].velocidadeAtual
	pass
