extends Control

@export var MissionInf: MissoesData
@onready var Vbox: VBoxContainer = $AreaApp/AreaNucleo/VBoxContainer
func _ready() -> void:
	Vbox.get_node("MissaoTit").text = MissionInf.nomeMissao
	Vbox.get_node("MissaoDesc").text = MissionInf.descricao
	Vbox.get_node("MissaoRec").text = MissionInf.recompensaTexto

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
