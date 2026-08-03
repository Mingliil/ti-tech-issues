extends Node

@onready var debugentry = $"Debug entry"
@export var DOORSINF: Array[OSDRE]
@export var DOORSSYSTEMINF: OSystemRes
@onready var LockScreen: PackedScene = preload("uid://dfm3ecw6drct2")
@export var locked: bool = false
@onready var protecScreen = $ProtectionScreen
var doorslkscName = "DoorsLockScreen"
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	debugentry.text += "DOORS iniciating \n"
	debugentry.text += "DOORS ready"
	
	if locked:
		add_child(LockScreen.instantiate())
		protecScreen.visible = true
		debugentry.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func on_unlock() -> void:
	locked = false
	protecScreen.visible = false
	print("DEBUG - desbloqueado")
	get_node(doorslkscName).queue_free()


func _on_doorsbutton_pressed() -> void:
	
	pass # Replace with function body.
