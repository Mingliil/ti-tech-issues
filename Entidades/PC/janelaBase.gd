extends Window


@export var typeWindow: int
@onready var subView:SubViewport = $SubViewportContainer/JanelaMundo

func _load_component(type:int) -> void:
	print(type)
	
	match type:
		1: #Pc
			title = "Gabinete"
			typeWindow = type
			get_child(0).get_child(0).add_child(preload("res://Entidades/PC/Gabinete.tscn").instantiate())
		2: #Monitor
			title = "Monitor"
			typeWindow = type
		0:
			queue_free()

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	queue_free()
	pass # Replace with function body.
