extends Node





# Called when the node enters the scene tree for the first time.
var PlayerRoot
var player

@onready var ImgFala = $TextureRect
@onready var nomefalante: Label = $VBoxContainer/NomeFalante
@onready var falaTexto: RichTextLabel = $VBoxContainer/PanelContainer/MarginContainer/FalaTexto
@onready var buttonBox = $VBoxContainer/PanelContainer/ButtonBox
@export var DialogueData: diagData
@onready var OptButtonPreload = preload("res://Interação/Chatting/option_button.tscn")
var current_dialogue: int = 0
var current_dialogue_item: int = 0
var proxima_Etapa = true
func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER").get_child(0)
	player.interagindo = true
	if DialogueData.primeiroDialogo != 0:
		current_dialogue = DialogueData.primeiroDialogo
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if current_dialogue >= DialogueData.size():
		if !player:
			for i in get_tree().get_nodes_in_group("Player"):
				player = i
			return
		player.interagindo = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#PLAYER.Speed = true
		queue_free()
		return

	if proxima_Etapa:
		proxima_Etapa = false
		var i = DialogueData.Conversas[current_dialogue].falas[current_dialogue_item]
		if i is not FuncaoDiagData:
			if i.speaker_name:
		#		FalaNome.text = i.speaker_name
				print(i.speaker_name)
		#	else:
				#FalaNome.visible = false
		#if i is FuncaoDiagData:
			#if i.hide_dialogue_box:
				#visible = false
			#else:
				#visible = true
#
			#_function_resource(i)
		#elif i is EscolhaDiagSize:
			#visible = true
			#_choice_resource(i)
		#elif i is TextData:
			#visible = true
			#_text_resource(i)
		else:
			printerr("tu fez algo errado aqui com a DE")
			current_dialogue_item += 1
			proxima_Etapa = true

func Funcao() -> void:
	pass

func Escolha(data) -> void:
	var buttonInst = OptButtonPreload.instantiate()
	falaTexto.get_parent().visible = false
	for i in data.Opcoes.size():
		buttonInst.text = data.Opcoes[i].ButtaoTexto
		buttonInst.connect("pressed",Callable(self, "botao_apertado").bind(data.Opcoes[i].DialogoSeguinte),CONNECT_ONE_SHOT)
		if data.Opcoes[i].Funcao:
			buttonInst.connect("pressed", Callable(get_node(data.Opcoes[i].Funcao.caminhoNode),data.Opcoes[i].Funcao.FuncNome).bindv(data.Opcoes[i].Funcao.Argumentos), CONNECT_ONE_SHOT)
		buttonBox.add_child(buttonInst)

func botao_apertado(next_diag) -> void:
	for i in buttonBox.get_children():
		i.queue_free()
	if next_diag != 0:
		current_dialogue = next_diag
		current_dialogue_item = 0
	else:
		current_dialogue_item += 1
	proxima_Etapa = true
	

func Dialogo() -> void:
	falaTexto.get_parent().visible = true
	#if DialogueData.Conversas[conversa].falas[ItemAtual].FalanteImg:
		#ImgFala.texture =DialogueData.Conversas[conversa].falas[ItemAtual].FalanteImg
		#ImgFala.offset.y = DialogueData.Conversas[0].falas[ItemAtual].FalanteImg.get_size().y
	#falaTexto.text = DialogueData.Conversas[conversa].falas[ItemAtual].texto
	#nomefalante.text =DialogueData.Conversas[conversa].falas[ItemAtual].FalanteNome
	while  true:
		await  get_tree().process_frame
		if Input.is_action_just_pressed("interagir"):
			current_dialogue_item += 1
			proxima_Etapa = true
