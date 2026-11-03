extends Control


# Called when the node enters the scene tree for the first time.
@onready var userImg: TextureRect = $Sprite2D/UserImg
@onready var userName: Label = $UserName
@onready var pssWd: LineEdit = $UserName/Psswd
@export var doorsRootLoginInfo: OSLoginInfRes
var failedPsswdSubmits: int = 0
func _ready() -> void:
	doorsRootLoginInfo = get_parent().DOORSINF[0]
	userImg.texture = doorsRootLoginInfo.UserImg
	userName.text = doorsRootLoginInfo.UserName


func _on_psswd_submitted(new_text: String) -> void:
	if pssWd.text == doorsRootLoginInfo.UserPsswd:
		get_parent().on_unlock()
	else:
		failedPsswdSubmits+=1
	if failedPsswdSubmits >= 3:
		pass
