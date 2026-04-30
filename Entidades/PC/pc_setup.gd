extends Window
var dentro: int
@onready var player: CharacterBody3D
@onready var subview: SubViewport = $SubJanela/SubViewport
@onready var janelaInsp = preload("uid://decafil0jcorv")
@onready var currentPc 
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	currentPc = get_tree().get_first_node_in_group("CurrentPC")
	print(currentPc)
func _process(delta: float) -> void:
	match dentro:
		1:#pc
			if Input.is_action_just_released("ClickPrim"):
				_check_n_create_window(1)
		2:#monitor
			if Input.is_action_just_released("ClickPrim"):
				_check_n_create_window(2)
		0:
			if Input.is_action_just_released("ClickPrim"):
				pass

func _check_n_create_window(type: int) -> void:
	var typeExist: bool = false
	for i in subview.get_child_count():
		if subview.get_child(i) is Window:
			if subview.get_child(i).typeWindow == type:
				typeExist = true
	if !typeExist:
		_abrir_janela(type)


func _on_computador_mouse_entered() -> void:
	dentro = 1
func _on_computador_mouse_exited() -> void:
	dentro = 0
func _on_monitor_mouse_entered() -> void:
	dentro = 2
func _on_monitor_mouse_exited() -> void:
	dentro = 0
	
func _abrir_janela(i: int) -> void:
	var cena = janelaInsp.instantiate()
	cena._load_component(i)
	subview.add_child(cena)



func _on_close_requested() -> void:
	player.PlayerStats[0].podeInteragir = true
	queue_free()
	pass # Replace with function body.
