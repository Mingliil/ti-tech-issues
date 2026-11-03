extends Window




@onready var FilesDisplay: ItemList = $PanelContainer/VBoxContainer/HBoxContainer/FilesDisplay
@onready var FilePath: LineEdit = $PanelContainer/VBoxContainer/HBoxContainer2/FilePath
@onready var PhotoDisplayer = preload("uid://cjmt3sctfsyan")
## - EXPORTS
@export var FilesSprites: Array[CompressedTexture2D]
@export var FileOnlySprites: Array[CompressedTexture2D]
var OSUserName
var OldFilePath: String
var choosedDir: String
var INGAMEONLY:bool =  true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var startPath: String
	if OS.has_environment("USERNAME"):
		OSUserName = OS.get_environment("USERNAME")
		startPath = "C:/Users/%s" %OSUserName
	else:
		startPath = "C:/Users"
	if INGAMEONLY:
		startPath = get_tree().root.get_node("DOORS").DOORSSYSTEMINF.DriveRootPath
	searchDirectoryndFile(startPath)

	
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
	var typeFile = FilesDisplay.get_item_text(index).split(".", false)
	
	print(typeFile)
	if typeFile.size() > 1:
		match typeFile[typeFile.size()-1]:
			"png", "jpeg", "gif", "webm","tiff","bmp":
				
				var photo = PhotoDisplayer.instantiate()
				var areaTrabalho = get_tree().root.get_node("DOORS/AreaDeTrabalho")
				var nome: String = ""
				for i in typeFile.size():
					if nome == "":
						nome = typeFile[i]
					else:
						nome = nome + "." + typeFile[i]
					print(nome)
				var path = OldFilePath +"/"+ nome
				areaTrabalho.add_child(photo)
				areaTrabalho.get_node("PhotoShock").ShowFile(path, "Foto")
				print(areaTrabalho.get_children())
			_:
				return
	elif OldFilePath.ends_with("/"):
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
