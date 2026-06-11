extends Node

var root
var cfg = ConfigFile.new()
var err = cfg.load("res://Cenas/MainMenu/Scripts/Recursos/config.cfg")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if err != OK:
		print("erro carregando config" + str(err))
	else:
		print("config normal")
	
	root = get_tree().root
	
