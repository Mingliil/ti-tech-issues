extends Node





# Called when the node enters the scene tree for the first time.
var PlayerRoot
var player
var ItemAtual: int = 0
@onready var ImgFala = $TextureRect
@onready var nomefalante: Label = $VBoxContainer/NomeFalante
@onready var falaTexto: RichTextLabel = $VBoxContainer/PanelContainer/MarginContainer/FalaTexto
@onready var buttonBox = $VBoxContainer/PanelContainer/ButtonBox
@export var DialogueData: diagData
@onready var OptButtonPreload = preload("res://Interação/Chatting/option_button.tscn")
var conversa: int = 0
var proxima_Etapa = true
func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER").get_child(0)
	player.interagindo = true
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	if ItemAtual >=  DialogueData.Conversas[conversa].falas.size():
		player.interagindo = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		queue_free()
	
	elif proxima_Etapa:
		print(ItemAtual)
		proxima_Etapa = false
		var item
		if DialogueData.DialogoRng:
			item = DialogueData.Conversas[randi_range(DialogueData.diagRandomStart,DialogueData.diagRandomEnd)]
			print(item)
		elif conversa != 0:
			item = DialogueData.Conversas[DialogueData.primeiroDialogo]
		else:
			item = DialogueData.Conversas[conversa]
		if item.falas[ItemAtual] is TextData:
			Dialogo()
		elif item.falas[ItemAtual] is EscolhaDiagSize:
			Escolha(item.falas[ItemAtual])
	pass

func Funcao() -> void:
	pass

func Escolha(data) -> void:
	var buttonInst = OptButtonPreload.instantiate()
	falaTexto.get_parent().visible = false
	for i in data.Opcoes.size():
		buttonInst.text = data.Opcoes[i].ButtaoTexto
		buttonInst.connect("pressed",Callable(self, "botao_apertado").bind(data.Opcoes[i].DialogoSeguinte),CONNECT_ONE_SHOT)
		buttonBox.add_child(buttonInst)

func botao_apertado(next_diag) -> void:
	for i in buttonBox.get_children():
		i.queue_free()
	if next_diag != 0:
		conversa = next_diag
		ItemAtual = 0
	else:
		ItemAtual += 1
	proxima_Etapa = true
	print(conversa)

func Dialogo() -> void:
	falaTexto.get_parent().visible = true
	if DialogueData.Conversas[0].falas[ItemAtual].FalanteImg:
		ImgFala.texture =DialogueData.Conversas[0].falas[ItemAtual].FalanteImg
		#ImgFala.offset.y = DialogueData.Conversas[0].falas[ItemAtual].FalanteImg.get_size().y
	falaTexto.text = DialogueData.Conversas[0].falas[ItemAtual].texto
	nomefalante.text =DialogueData.Conversas[0].falas[ItemAtual].FalanteNome
	while  true:
		await  get_tree().process_frame
		if Input.is_action_just_pressed("interagir"):
			ItemAtual += 1
			proxima_Etapa = true
