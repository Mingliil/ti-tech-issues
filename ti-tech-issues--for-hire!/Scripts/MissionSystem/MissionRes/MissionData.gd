extends MissionResExpt
class_name MissionData

@export var missionId : int
@export var missionName : String

@export var missionClient: String
@export var clientId: int

@export_multiline() var missionDesc : String
@export var missionReq : Array[MissionRequirements]
