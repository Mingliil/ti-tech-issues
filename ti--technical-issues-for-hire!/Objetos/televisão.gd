extends RigidBody3D

@export var nome:String = "Tv"
@export var obj_vars: ObjectVariables

var canalAtual: int = 0
@export var ligado: bool = true
@onready var tela : SubViewport = $SubViewport
@onready var videoPlayer: VideoStreamPlayer = $SubViewport/Control/PanelContainer2/VideoStreamPlayer

@export var Canais: Array[VideoStreamTheora]
@export var entradaVideo: Array[String]

func trocarOuNao()->void:
	if videoPlayer.is_playing():
		videoPlayer.stop()
		videoPlayer.visible = false
		return
	else:
		videoPlayer.visible = true
		videoPlayer.set_stream(Canais[randi_range(0,Canais.size()-1)])
		videoPlayer.play()
		return
