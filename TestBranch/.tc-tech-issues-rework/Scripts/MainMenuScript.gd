extends Node3D

@onready var Cam: Camera3D = $MINCOBuild/MenuCam
@onready var MinCoBuild = $MainPart
@onready var cam
@export var mouse: Vector2
@export var consegueInteragir: bool = true
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	load("res://Animations/MainMenuAnimsHandler.gd")
	
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_rotate_Build()
	
func _rotate_Build() -> void:
	MinCoBuild.rotate_y(0.00001)
