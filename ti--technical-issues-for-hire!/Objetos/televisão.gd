extends RigidBody3D

@export var nome:String = "Tv"
@export var obj_vars: ObjectVariables
@export var volume: float = 1
@export var ligado: bool = true
@export var Canais: Array[TvChannels]
@export var canalAtual:int
@export var curVideo:int = 0
@export_enum("TvAberta","PC") var EntradaVideo

@onready var cont: PanelContainer = $SubViewport/PanelContainer
@onready var tela : SubViewport = $SubViewport
@onready var videoPlayer: VideoStreamPlayer = $SubViewport/PanelContainer/VideoStreamPlayer
@onready var animPlayer: AnimationPlayer = $SubViewport/PanelContainer/ChannelDisplayer/AnimationPlayer
@onready var volanim: AnimationPlayer = $SubViewport/PanelContainer/VolNum/AnimationPlayer
@onready var channelCurNum: Label = $SubViewport/PanelContainer/ChannelDisplayer
@onready var VolNum: Label = $SubViewport/PanelContainer/VolNum

func _ready() -> void:
	if !videoPlayer.get_stream():
		TrocarCanal()


func TrocarCanal()->void:
	if !ligado:
		return
	Canais[canalAtual].currentVideo = curVideo
	Canais[canalAtual].currentVideoPos = videoPlayer.get_stream_position()
	canalAtual += 1
	if Canais.size()-1<canalAtual:
		canalAtual = 0
	SetVideo()


func SetVideo()-> void:
	#var audio: AudioStream = 
	#Canais[canalAtual].videos[Canais[canalAtual].currentVideo]
	videoPlayer.set_stream(Canais[canalAtual].videos[Canais[canalAtual].currentVideo])
	videoPlayer.play()
	videoPlayer.set_stream_position(Canais[canalAtual].currentVideoPos)
	videoPlayer.set_volume(volume)
	channelCurNum.text = "%s" %Canais[canalAtual].canalNum
	animPlayer.play("RESET")
	animPlayer.play("LabelFade")

func changeVol(positive: bool)->void:
	if !ligado:
		return
	if positive:
		volume+=0.1
	else:
		volume-=0.1
	if volume <0:
		volume=0
	if volume >1:
		volume=1
	videoPlayer.set_volume(volume)
	var i = volume*100
	VolNum.text = "%s" %i
	volanim.play("RESET")
	volanim.play("volanim")
	pass



func Desligar()->void:
	if cont.visible:
		cont.visible = false
		videoPlayer.set_volume(0)
		ligado = false
		return
	else:
		cont.visible = true
		videoPlayer.set_volume(volume)
		ligado = true
		return


func _on_video_stream_player_finished() -> void:
	curVideo+=1
	if Canais[canalAtual].videos.size()-1<curVideo:
		curVideo = 0
	SetVideo()
	pass # Replace with function body.
