extends ItemExport
class_name ItemFunction
enum ActionType {Right,Left,Scroll, F}
@export var FunctionType:ActionType
@export var alternativeFunction: bool
@export var FunctionName: String
@export var FunctionVars: Array
@export var FunctionSound: AudioStream
