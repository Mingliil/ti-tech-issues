extends PcResEXPT
class_name PCComponents


@export_group("Do Gabinete")
@export var Usb: NodePath


@export_group("Perifericos")
@export var Monitor: NodePath
@export var Teclado: NodePath
@export var Mouse: NodePath

@export_group("Dentro do Gabinete")
@export var placaMae: NodePath
@export var Fonte: NodePath
@export var Armazenamento: Array[NodePath]
