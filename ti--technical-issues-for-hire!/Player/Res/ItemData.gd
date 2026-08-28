extends ItemExport
class_name ItemData




@export_group("Geral Info")
@export var ItemName: String
@export var ItemSprite: CompressedTexture2D
@export var ItemNode: PackedScene
@export_multiline() var ItemDesc: String
@export var itemWeight: float = 1.0


@export_group("Functions")
@export var Itemfunction: Script
@export var Funtions: Array[ItemFunction]
@export_subgroup("Left")
@export var LeftClickFunction: String
@export var LeftClickFunctionVars: Array
@export var LeftClickSound: AudioStream
@export_subgroup("Right")
@export var RightClickFunction: String
@export var RightClickFunctionVars: Array
@export var RightClickSound: AudioStream
@export_subgroup("Scroll")
@export var ScrollClickFunction: String
@export var ScrollClickFunctionVars: Array
@export var ScrollClickSound: AudioStream
