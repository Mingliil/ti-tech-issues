extends PRE
class_name MissoesData

@export var Id_missao: int
@export var concluido: bool
@export var missaoDada: bool
#parte base, fala o nome/titulo e então uma descrição
@export var nomeMissao: String
@export_multiline() var descricao: String
#requisitos para concluir a missão
@export var missoesRequisitosNome: Array[String]
@export var missoesRequisitosInfo: Array[MissaoRequis]

@export var recompensaTexto: String
@export var recompensaVar: Array
