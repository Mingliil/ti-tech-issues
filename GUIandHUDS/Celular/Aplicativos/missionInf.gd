extends Control

@export var MissionInf: MissoesData
@onready var preloadRecBotao = preload("res://GUIandHUDS/Celular/Aplicativos/MissioHub/requisito_missao.tscn")
@onready var Vbox: VBoxContainer = $AreaApp/AreaNucleo/VBoxContainer
func _ready() -> void:
	Vbox.get_node("MissaoTit").text = MissionInf.nomeMissao
	Vbox.get_node("MissaoDesc").text = MissionInf.descricao
	Vbox.get_node("MissaoRec").text = MissionInf.recompensaTexto
	for i in MissionInf.missoesRequisitosNome.size():
		_missao_requis(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _missao_requis(i: int) -> void:
	var recBotao = preloadRecBotao.instantiate()
	recBotao.text = MissionInf.missoesRequisitosNome[i]
	get_node("AreaApp/AreaNucleo/VBoxContainer/Requisitos").add_child(recBotao)
