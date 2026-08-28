extends RigidBody3D

@export var nome:String = "Tv"
@export var obj_vars: ObjectVariables

var canalAtual: int = 0
@export var ligado: bool = true
@onready var tela : SubViewport = $SubViewport
@onready var videoPlayer: VideoStreamPlayer = $"SubViewport/Televisão Tela/PanelContainer/VideoStreamPlayer"
@export var Canais: Array[VideoStreamTheora]
@export var entradaVideo: Array[String]
