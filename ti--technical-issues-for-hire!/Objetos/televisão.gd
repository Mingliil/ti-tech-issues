extends RigidBody3D

@export var nome:String = "Tv"
@export var obj_vars: ObjectVariables
@export var Canais: Array[VideoStreamTheora]
var canalAtual: int = 0
@export var ligado: bool = true
@onready var tela : SubViewport = $SubViewport
@onready var videoPlayer: VideoStreamPlayer = $"SubViewport/Televisão Tela/PanelContainer/VideoStreamPlayer"

func _process(delta: float) -> void:
	pass
