extends Window

@onready var CodeEditor: CodeEdit = $PanelContainer/ScrollContainer/VBoxContainer/CodeEdit
@onready var LineEditor: LineEdit = $PanelContainer/ScrollContainer/VBoxContainer/LineEdit
@export var CMDScriptExp: Script
@onready var CMDScript:Node = CMDScriptExp.new()
@onready var system:AspectRatioContainer = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	InsertText("Mincon Doors [versão 763.711.593.4]
(c) Mincon Company. Todos os direitos reservados.")
	if CMDScript.has_method("help"):
		var test = CMDScript.call("help", "nullafas")
		print(test)
func InsertText(texto: String)->void:
	var linha = CodeEditor.get_line_count()-1
	CodeEditor.insert_text(texto+ "\n", linha, 0)

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		return
	var comando = new_text.get_slice(" ",0)
	if CMDScript.has_method(comando):
		var comandArgCount :int = CMDScript.get_method_argument_count(comando)
		var comandArgs: Array[String]
		comandArgs.assign(new_text.split(" ",false,comandArgCount))
		CMDScript.doors = get_parent()
		CMDScript.commandPrompt = self
		var output
		if comandArgCount == 0:
			InsertText(system.userInfo.UserName+ ">" + new_text)
			output = CMDScript.call(comando)
		elif comandArgCount < comandArgs.size()-1:
			InsertText("muitos argumentos para o comando '" + comando +"'")
			LineEditor.text = ""
			return
		elif comandArgCount > comandArgs.size()-1:
			if comando == "help":
				InsertText(system.userInfo.UserName+ ">" + new_text)
				output = CMDScript.call(comando, "")
			elif comando == "color":
				InsertText(system.userInfo.UserName+ ">" + new_text)
				output = CMDScript.call(comando, "07")
			else:
				InsertText("pouco argumentos para o comando '" + comando +"'")
				LineEditor.text = ""
				return
		else:
			InsertText(system.userInfo.UserName+ ">" + new_text)
			comandArgs.erase(comando)
			output = CMDScript.callv(comando,comandArgs)
		if output:
			InsertText(output)
	else:
		InsertText(system.userInfo.UserName+ ">'"+new_text.get_slice(" ",0)+"' não é reconhecido como um comando interno ou externo, um programa operável ou \n um arquivo em lotes. Tente 'help' para saber mais")
	LineEditor.text = ""








func _on_close_requested() -> void:
	queue_free()
