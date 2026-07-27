extends Window




@onready var FilesDisplay: ItemList = $PanelContainer/VBoxContainer/HBoxContainer/FilesDisplay
@onready var FilePath: LineEdit = $PanelContainer/VBoxContainer/HBoxContainer2/FilePath
## - EXPORTS
@export var FilesSprites: Array[CompressedTexture2D]
@export var FileOnlySprites: Array[CompressedTexture2D]
var OSUserName
var OldFilePath: String
var choosedDir: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var startPath: String
	if OS.has_environment("USERNAME"):
		OSUserName = OS.get_environment("USERNAME")
		startPath = "C:/Users/%s" %OSUserName
	else:
		startPath = "C:/Users"
	searchDirectoryndFile(startPath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func searchDirectoryndFile(path: String) -> void:
	if path == "":
		FilePath.text = OldFilePath
		return
	var directories
	var files
	directories = DirAccess.get_directories_at(path)
	files = DirAccess.get_files_at(path)
	FilePath.text = path
	print(path)
	FilesDisplay.clear()
	for i in directories.size():
		#print("DEBUG FILEEXPLORER -pasta:",directories.get(i))
		FilesDisplay.add_item(directories.get(i),FilesSprites[0],true)
	for i in files.size():
		FilesDisplay.add_item(files.get(i),FilesSprites[1],true)
	OldFilePath = path

func _on_filePath_submitted(new_text: String) -> void:
	searchDirectoryndFile(new_text)
	pass # Replace with function body.


func _on_fileDisplay_activated(index: int) -> void:
	if OldFilePath.ends_with("/"):
		searchDirectoryndFile(OldFilePath + FilesDisplay.get_item_text(index))
	else:
		searchDirectoryndFile(OldFilePath +"/"+ FilesDisplay.get_item_text(index))
	choosedDir =FilesDisplay.get_item_text(index)
	pass # Replace with function body.


func _on_return() -> void:
	var dirs = OldFilePath.split("/",false)
	var ReturnPath
	for i in dirs.size():
		if i == 0:
			ReturnPath = dirs[i]
		elif i == dirs.size()-1:
			break
		else:
			ReturnPath += "/" + dirs[i]
	searchDirectoryndFile(ReturnPath)
	pass # Replace with function body.
