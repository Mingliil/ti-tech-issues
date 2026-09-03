extends RigidBody3D

@export var nome:String = "Tv"
@export var obj_vars: ObjectVariables
@export var volume: float = 1
@export var ligado: bool = true
@export var Canais: Array[TvChannels]
@export var canalAtual:int
@export var curVideo:int = 0
enum EntradaVideo{TvAberta,PC} 
var entradaAtual = EntradaVideo.TvAberta
@onready var cont: PanelContainer = $SubViewport/PanelContainer
@onready var tela : SubViewport = $SubViewport
@onready var videoPlayer: VideoStreamPlayer = $SubViewport/PanelContainer/VideoStreamPlayer
@onready var animPlayer: AnimationPlayer =$SubViewport/PanelContainer/VideoStreamPlayer/ChannelDisplayer/AnimationPlayer
@onready var volanim: AnimationPlayer = $SubViewport/PanelContainer/VolNum/AnimationPlayer
@onready var channelCurNum: Label = $SubViewport/PanelContainer/VideoStreamPlayer/ChannelDisplayer
@onready var VolNum: Label = $SubViewport/PanelContainer/VolNum
@onready var SistemaOperacional = $SubViewport/OsDoors

var mouse: Vector2
var player: CharacterBody3D

func _ready() -> void:
	
	if !videoPlayer.get_stream():
		TrocarCanal()
	player = get_tree().get_first_node_in_group("PLAYER")
	if entradaAtual == EntradaVideo.TvAberta:
		SistemaOperacional.visible = false
	elif entradaAtual == EntradaVideo.PC:
		cont.visible = false
		videoPlayer.set_volume(0)
		ligado = false
		


func _process(delta: float) -> void:
	if player.interagindo:
		if Input.is_action_just_pressed("escape"):
			player.interagindo = false
			$Camera3D.current = false
			return
		print(mouse)
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and player.interagindo:
		mouse = event.position
		if mouse:
			$SubViewport/OsDoors.updateMouse(mouse)



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

func trocarEntradaVid() -> void:
	if entradaAtual == EntradaVideo.TvAberta:
		Desligar()
		SistemaOperacional.visible = true
		entradaAtual = EntradaVideo.PC
	elif entradaAtual == EntradaVideo.PC:
		Desligar()
		SistemaOperacional.visible = false
		entradaAtual = EntradaVideo.TvAberta

func _on_video_stream_player_finished() -> void:
	curVideo+=1
	if Canais[canalAtual].videos.size()-1<curVideo:
		curVideo = 0
	SetVideo()
	pass # Replace with function body.




func camLock()-> void:
	player.interagindo = true
	$Camera3D.current = true
	InteractHdlr.show_interact_options()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
