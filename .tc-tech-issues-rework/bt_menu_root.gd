extends Sprite3D

@export var nomeBt: String = ""
@export var action: int = -1

@onready var control: MarginContainer = $Graf/Control/Contain
@onready var Txt: Label = $Graf/Control/Contain/Texto
@onready var Interact:Area3D = $Interact
@onready var SubVP: SubViewport = $Graf

@onready var JanelaSairPreLoad = preload("res://Cenas/MainMenu/Janelas/janela_sair.tscn")
@onready var ConfigPreload = preload("res://Cenas/MainMenu/Janelas/BaseJanela.tscn")
var resized: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Txt.text = nomeBt
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if !resized:
		if Vector2(SubVP.size) != Txt.size:
			resize()
		else:
			Interact.get_child(0).shape.size = Vector3(SubVP.size.x, SubVP.size.y, 1)
			resized = true

func resize() -> void:
	SubVP.size = control.size
	Interact.get_child(0).shape.size = Vector3(control.size.x/100, control.size.y/100, 0.5)

func _on_interact_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			if $"../../..".consegueInteragir:
				action_option()
	pass # Replace with function body.

func action_option() -> void:
	if !$"..".get_node("Janelas").get_children():
		match action:
			-1: #debug 1, para fazer testes com a acão selecionada
				print("welp")
			0: #abre a janela para sair do jogo
				$"../../..".consegueInteragir = false
				var janelaInstancia = JanelaSairPreLoad.instantiate()
				$"..".get_node("Janelas").add_child(JanelaSairPreLoad.instantiate())
			1: #NOVO JOGO
				pass
			2: #CONTINUAR JOGO
				pass
			3: #CONFIGURAÇÕES
				$"..".get_node("Janelas").add_child(ConfigPreload.instantiate())
				pass
			4: #APOIA-ME/PATREON???
				pass
			5: # EASTER-EGG????????????
				pass
