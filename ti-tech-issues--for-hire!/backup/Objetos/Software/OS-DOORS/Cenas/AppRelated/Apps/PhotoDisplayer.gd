extends Window


@onready var ImgDisplay: TextureRect = $Panel/ImgDisplay
@onready var VidDisplay: VideoStreamPlayer = $Panel/VidDisplay
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !ImgDisplay:
		ImgDisplay = get_node("Panel/ImgDisplay")
	if !VidDisplay:
		VidDisplay = get_node("Panel/VidDisplay")
	pass # Replace with function body.

func ShowFile(filePath: String, fileType: String) -> void:
	#for i in $Panel.get_children().size():
		#$Panel.get_child(i-1).visible = false
	match fileType:
		"Foto":
			ImgDisplay.visible = true
			ImgDisplay.texture = load_external_tex(filePath)
			
			
		"Video":
			VidDisplay.visible = true
			
		"Audio":
			pass
		_:
			pass

func load_external_tex(path):
	var File: FileAccess = FileAccess.open(path, FileAccess.READ)
	var bytes = File.get_buffer(File.get_length())
	var img = Image.new()
	var data = img.load_png_from_buffer(bytes)
	
	var imgtex = ImageTexture.new()
	imgtex.create_from_image(img)
	print(data)
	File.close()
	return imgtex
