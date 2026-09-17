extends Node

signal proguess_changed(progresss)
signal load_finished

var loading_screen: PackedScene = preload("uid://cr3xfj4qb61cd")
var loaded_resource: PackedScene
var scene_path: String
var proguess: Array = []
var use_sub_threads: bool = true
var SpawnPos: Vector3
var player: PackedScene

func _ready() -> void:
	set_process(false)
	
func load_scene(_scene_path: String, Pos: Vector3) -> void:
	InteractHdlr.loading = true
	scene_path = _scene_path
	player = PackedScene.new()
	player.pack(get_tree().get_first_node_in_group("PLAYER"))
	
	var new_load_screen = loading_screen.instantiate()
	add_child(new_load_screen)
	proguess_changed.connect(new_load_screen._on_proguess_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	
	await new_load_screen.loading_screen_ready
	SpawnPos = Pos
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, proguess)
	proguess_changed.emit(proguess[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_resource)
			
			print(get_tree().get_first_node_in_group("PLAYER"))
			get_tree().root.add_child(player.instantiate())
			
			load_finished.emit()
