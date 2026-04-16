extends Control

@export var MissionInf: MissoesData
@onready var preloadRecBotao = preload("res://GUIandHUDS/Celular/Aplicativos/MissioHub/requisito_missao.tscn")
@onready var Vbox: VBoxContainer = $AreaApp/VBoxContainer
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
	if MissionInf.missoesRequisitosInfo[i].RequisitoMax is not bool:
		recBotao.text = MissionInf.missoesRequisitosNome[i] + "(%x/%s)" %[MissionInf.missoesRequisitosInfo[i].RequisitoAtual,MissionInf.missoesRequisitosInfo[i].RequisitoMax]
	else:
		var recAtual = 0
		var recMax = 0
		if MissionInf.missoesRequisitosInfo[i].RequisitoAtual:
			recAtual = 1
		if MissionInf.missoesRequisitosInfo[i].RequisitoMax:
			recMax = 1
		recBotao.text = MissionInf.missoesRequisitosNome[i] + "(%d/%s)" %[recAtual,recMax]
	Vbox.get_node("Requisitos").add_child(recBotao)
