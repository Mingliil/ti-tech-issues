extends RigidBody3D


@export var Canais: Array[VideoStreamTheora]
var canalAtual: int = 0
@export var Controle: Node3D = null
@export var ligado: bool = true
@onready var tela : SubViewport = $SubViewport
@onready var videoPlayer: VideoStreamPlayer = $"SubViewport/Televisão Tela/PanelContainer/VideoStreamPlayer"
func _ready() -> void:
	if Controle:
		pass

func _process(delta: float) -> void:
	pass
