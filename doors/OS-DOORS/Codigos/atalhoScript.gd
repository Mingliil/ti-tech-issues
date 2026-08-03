extends PanelContainer




@export var AtalhoContend: OSAtalhoRex
@onready var Icon: TextureButton = $VBoxContainer/Icon
@onready var AppLabel: LineEdit=$VBoxContainer/AppName
# Called when the node enters the scene tree for the first time.
var OnFocused = false
func _ready() -> void:
	AppLabel.text = AtalhoContend.AppName
	Icon.texture_normal = AtalhoContend.AppImg

func _input(e):
	if e is InputEventMouseButton and e.button_index == MOUSE_BUTTON_LEFT and e.double_click:
		if OnFocused:
			print("DOUBLE CLICK")
			get_node("../../../..").add_child(AtalhoContend.ScenePack.instantiate())
func _on_mouse_entered() -> void:
	OnFocused = true


func _on_mouse_exited() -> void:
	OnFocused = false
