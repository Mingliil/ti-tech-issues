extends Control


# Called when the node enters the scene tree for the first time.
@onready var userImg: TextureRect = $Sprite2D/UserImg
@onready var userName: Label = $UserName
@onready var pssWd: LineEdit = $UserName/Psswd
var doorsRootLoginInfo
func _ready() -> void:
	doorsRootLoginInfo = get_parent().DOORSINF[0]
	userImg.texture = doorsRootLoginInfo.UserImg
	userName.text = doorsRootLoginInfo.UserName
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_psswd_submitted(new_text: String) -> void:
	if pssWd.text == doorsRootLoginInfo.UserPsswd:
		get_parent().on_unlock()
	pass # Replace with function body.
