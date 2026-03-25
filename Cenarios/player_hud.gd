extends Control

var PLAYER
var PlayerIntArea
var speedText
var IntText
func _ready() -> void:
	PLAYER = get_tree().get_first_node_in_group("Player")
	speedText = get_node("sped")
	IntText = get_node("Interact")
	print(PLAYER)
	PLAYER.PlSpeed.connect(_on_pl_speed)
	PlayerIntArea = PLAYER.find_child("Area3D")
	PlayerIntArea.area_entered.connect(_on_area_Player_entered)
	PlayerIntArea.area_exited.connect(_on_area_Player_exited)

func _process(delta: float) -> void:
	pass

func _on_pl_speed(Plspeed: Variant) -> void:
	speedText.text = "Speed: %s treste" %Plspeed.z + "VelX = %x" %Plspeed.x
func _on_area_Player_entered() -> void:
	IntText.text = "Interagivel?: SIM"
func _on_area_Player_exited() -> void:
	IntText.text = "Interagivel?: NÃO"
