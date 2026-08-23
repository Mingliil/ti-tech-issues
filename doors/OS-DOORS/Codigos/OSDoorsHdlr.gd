extends AspectRatioContainer

@export_group("general System Information")
@export var userInfo: OSLoginInfRes
@export var DOORSSYSTEMINF: OSystemRes

@export_group("others")
@onready var debugentry = $"Debug entry"
@export var DOORSINF: Array[OSDRE]
@onready var LockScreen: PackedScene = preload("uid://dfm3ecw6drct2")
@export var locked: bool = false
@onready var protecScreen = $ProtectionScreen
@onready var commandprompt: Window = $CommandPrompt
var doorslkscName = "DoorsLockScreen"

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	commandprompt.InsertText("DOORS iniciating")
	update_Ratio()
	get_tree().get_root().size_changed.connect(update_Ratio)
	commandprompt.InsertText("DOORS ready")
	if locked:
		add_child(LockScreen.instantiate())
		protecScreen.visible = true
		debugentry.queue_free()
	
func update_Ratio()-> void:
	var viewportSize:Vector2 = get_viewport().get_visible_rect().size
	var viewportRatio = viewportSize.x / viewportSize.y
	set_ratio(viewportRatio)
	commandprompt.InsertText("Ratio Updated to %s" %viewportRatio)

func on_unlock() -> void:
	locked = false
	protecScreen.visible = false
	print("DEBUG - desbloqueado")
	get_node(doorslkscName).queue_free()
