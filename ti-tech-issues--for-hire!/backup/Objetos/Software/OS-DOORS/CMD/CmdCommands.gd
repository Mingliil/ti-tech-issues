extends Node



var generalComand:String = "Lista de todos os comandos disponiveis no Prompt de comando
------------------------------------------------------------------------------
cmd			Inicia uma nova instância do interpretador de comandos de Doors
cd			Exibe o nome do diretório atual ou faz alterações nele.
date			Exibe ou ajusta a data.
copy			Copia um ou mais arquivos para outro local.
chDir			Exibe o nome do diretório atual ou faz alterações nele.
cls			Limpa a tela.
dir			Exibe uma lista de arquivos e subdiretórios em um diretório
del			Exclui um ou mais arquivos.
echo			Exibe mensagens ou ativa/desativa o eco de comandos.
hostName			Fornece informações de ajuda sobre comandos de Doors.
logOff			Desloga o usuário de Doors
md			Cria um diretório.
move			Move um ou mais arquivos de um diretório para outro diretório
mkDir			Cria um diretório.
ping			Testa uma conexão 
run			Executa uma aplicação
ren			Altera o nome de um ou mais arquivos.
rename			Altera o nome de um ou mais arquivos.
rd			Remove um diretório.
systemInfo			Exibe a configuração e propriedades específicas da máquina.
time			Exibe ou ajusta a hora do sistema.
tree	 		Exibe graficamente a estrutura de diretórios de uma unidade ou caminho.
xCopy			Copia arquivos e árvores de diretórios.
Todos os comandos são \"Case Sensitive\", para saber mais de um comando faça \"help [Comando]\""

var helpCMD:String= "Inicia uma nova instância do interpretador de comando do Doors

CMD [/A | /U] [/Q] [/D] [/E:ON | /E:OFF] [/F:ON | /F:OFF] [/V:ON | /V:OFF]
    [[/S] [/C | /K] cadeia_de_caracteres]

/C      Executa o comando especificado pela cadeia_de_caracteres e é encerrado
/K      Executa o comando especificado pela cadeia_de_caracteres mas
        permanece
/S      Modifica o tratamento da cadeia_de_caracteres após /C ou /K (ver
        abaixo)
/Q      Desativa o comando echo
/D      Desativa a execução de comandos AutoRun do Registro (ver abaixo)
/A      Faz com que a saída de comandos internos para um pipe ou arquivo seja em ANSI
/U      Faz com que a saída de comandos internos para um pipe ou arquivo seja em Unicode
/T:fg   Define as cores em primeiro/segundo plano (consulte COLOR /? para obter mais informações)
/E:ON   Ativa extensões de comando (ver abaixo)
/E:OFF  Desativa extensões de comando (ver abaixo)
/F:ON   Ativa caracteres de conclusão de nome de arquivo e de pasta(ver abaixo)
/F:OFF  Desativa caracteres de conclusão de nome de arquivo e de pasta
        (ver abaixo)
/V:ON   Ativa a expansão de variáveis de ambiente atrasada usando ! como
        delimitador. Por exemplo, /V:ON permite que !var! expanda a variável
        var no tempo de execução. A sintaxe var expande variáveis no
        momento da entrada, que é um procedimento bem diferente quando
        está dentro de um loop de FOR.
/V:OFF  Desativa a expansão de ambiente atrasada.

Observe que vários comandos separados pelo separador de comando '&&'
são aceitos para cadeia de caracteres se estiverem entre aspas. Além disso,
por razões de compatibilidade, /X é o mesmo que /E:ON, /Y é o mesmo que /E:OFF e /R é o mesmo que /C. Qualquer outra opção é ignorada.

Se /C ou /K for especificado, o restante da linha de comando após a opção será processado como uma linha de comando, onde a seguinte lógica é usada para processar caracteres de aspas (\"):

    1.  Se todas as condições a seguir forem atendidas, as aspas na linha de comando serão preservadas:
        - nenhuma opção /S
        - exatamente duas aspas
        - nenhum caractere especial entre as duas aspas,
          onde o especial é um dos seguintes: &<>()@^|
        - há um ou mais caracteres de espaço entre as
          duas aspas
        - a cadeia de caracteres entre as duas aspas é o nome
          de um arquivo executável.

    2.  Caso contrário, o costume é ver se o primeiro caractere é um caractere de aspas e, se for, retirar o primeiro caractere e remover o último caractere de aspas na linha de comando, preservando qualquer texto após as últimas aspas.

Se /D NÃO estiver especificado na linha de comando, quando o CMD.EXE for
iniciado, ele procurará  as variáveis de Registro REG_SZ/REG_EXPAND_SZ
a seguir e, se nenhuma ou ambas estiverem presentes, serão executadas primeiro.
    HKEY_LOCAL_MACHINE/Software/Microsoft/Command Processor/AutoRun

        e/ou

    HKEY_CURRENT_USER/Software/Microsoft/Command Processor/AutoRun

As Extensões de Comando estão ativadas por padrão.  Você também pode
desabilitar as extensões de uma determinada invocação usando a opção /E:OFF.
Para habilitar ou desabilitar as extensões de todas as
invocações do CMD.EXE
em uma máquina e/ou sessão de logon de usuário, configure um dos valores
REG_DWORD a seguir, ou ambos os valores, no Registro usando o REGEDIT.EXE:

    HKEY_LOCAL_MACHINE/Software/Microsoft/Command Processor/EnableExtensions

        e/ou

    HKEY_CURRENT_USER/Software/Microsoft/Command Processor/EnableExtensions

para 0x1 ou 0x0.  A configuração específica do usuário tem precedência sobre
a configuração do computador.  As opções da linha de comando têm precedência
sobre as configurações do Registro.

Em um arquivo em lotes, os argumentos SETLOCAL ENABLEEXTENSIONS ou
DISABLEEXTENSIONS têm precedência sobre a opção /E:ON ou /E:OFF. Consulte
SETLOCAL /? para obter detalhes.

As extensões de comando envolvem alterações e/ou adições nos comandos
a seguir:

    DEL ou ERASE
    COLOR
    CD ou CHDIR
    MD ou MKDIR
    PROMPT
    PUSHD
    POPD
    SET
    SETLOCAL
    ENDLOCAL
    IF
    FOR
    CALL
    SHIFT
    GOTO
    START (também inclui as alterações feitas na invocação de comando externo)
    ASSOC
    FTYPE

Para obter detalhes específicos, digite commandname /? para exibir os
detalhes.

A expansão de variáveis de ambiente atrasada NÃO é ativada por padrão.  É
possível habilitar ou desabilitar a expansão de variáveis de ambiente atrasada
para uma determinada invocação do CMD.EXE com a opção /V:ON ou /V:OFF.
Para habilitar ou desabilitar as extensões atrasadas de todas as invocações
do CMD.EXE em uma máquina e/ou sessão de logon de usuário, configure um dos
valores REG_DWORD a seguir, ou ambos os valores, no Registro usando o
REGEDIT.EXE:

    HKEY_LOCAL_MACHINE/Software/Microsoft/Command Processor/DelayedExpansion

        e/ou

    HKEY_CURRENT_USER/Software/Microsoft/Command Processor/DelayedExpansion

para 0x1 ou 0x0.  A configuração específica do usuário tem precedência
sobre a configuração do computador.  As opções da linha de comando têm
precedência sobre as configurações do Registro.

Em um arquivo em lotes, os argumentos ENABLEDELAYEDEXPANSION ou
DISABLEDELAYEDEXPANSION têm precedência sobre a opção /V:ON ou /V:OFF.
Consulte SETLOCAL /? para obter detalhes.

Se a expansão de variáveis de ambiente atrasada estiver habilitada, o caractere
de exclamação poderá ser usado para substituir o valor de uma variável
de ambiente no tempo de execução.

Você pode ativar ou desativar a conclusão de nome de arquivo para uma chamada específica
do CMD.EXE com a opção /F:ON ou /F:OFF. Você pode ativar ou desativa
a conclusão para todas as chamadas do CMD.EXE em um computador e/ou
sessão de logon de usuário definindo qualquer um dos valores REG_DWORD a
seguir (ou ambos) no Registro usando REGEDIT.EXE:

 HKEY_LOCAL_MACHINE//Software//Microsoft//Command Processor//CompletionChar
 HKEY_LOCAL_MACHINE//Software//Microsoft//Command Processor//PathCompletionChar

 e/ou

 HKEY_CURRENT_USER//Software//Microsoft//Command Processor//CompletionChar
 HKEY_CURRENT_USER//Software//Microsoft//Command Processor//PathCompletionChar

com o valor hexadecimal de um caractere de controle a ser usado para
determinada função (ex.: 0x4 é Ctrl-D e 0x6 é Ctrl-F). As configurações
específicas do usuário têm precedência sobre as configurações do computador.
As opções da linha de comando têm precedência sobre as configurações do
Registro.

Se a conclusão for ativada com a opção /F:ON, os dois caracteres de controle
usados serão Ctrl-D para a conclusão de nome de pasta e Ctrl-F para a
conclusão de nome de arquivo. Para desativar um determinado caractere de
conclusão no Registro, use o valor do espaço (0x20), que não é um caractere
de controle válido.
A conclusão é chamada quando você digita um dos dois caracteres de controle.
A função de conclusão usa a cadeia de caracteres do caminho à esquerda do
cursor, acrescenta um caractere curinga a ela, se já não existir um, e cria
uma lista de caminhos correspondentes. Em seguida, exibe o primeiro caminho
correspondente. Se nenhum caminho corresponder, ela emite um aviso e não
altera nada. Depois, o pressionamento repetido do mesmo caractere de controle
percorrerá a lista de caminhos correspondentes. O pressionamento da tecla
Shift com o caractere de controle permite percorrer a lista de trás para a
frente. Se você fizer qualquer edição na linha e pressionar o caractere de
controle novamente, a lista salva de caminhos correspondentes é descartada e
uma nova é gerada. O mesmo ocorre se você alternar entre a conclusão de nome
de arquivo e de pasta. A única diferença entre os dois caracteres de controle
é que o caractere de conclusão de arquivo corresponde a ambos os nomes de
arquivo e de pasta, enquanto que o caractere de conclusão de pasta somente
corresponde a nomes de pastas. Se a conclusão de arquivo for usada em qualquer
um dos comandos de pasta internos (CD, MD ou RD), a conclusão de pasta será
usada.

O código de conclusão trata corretamente de nomes de arquivos que contêm
espaços ou outros caracteres especiais colocando aspas em volta do caminho
correspondente. Além disso, se você retornar com o cursor e chamar a conclusão
a partir de uma linha, o texto à direita do cursor no ponto em que a conclusão
foi chamada será descartado.

Os caracteres especiais que exigem aspas são:
     <espaço>
     &()[]{}^=;!'+,`~"

var helpColor:String = "Configura as cores padrão de primeiro plano e tela de fundo do console.

COLOR [attr]

  attr        Especifica os atributos de cor da saída do console

Atributos de cor são especificados por DOIS dígitos hexadecimais. O primeiro
corresponde à cor de tela de fundo; o segundo à cor de primeiro plano. Cada
dígito pode ter apenas um dos seguintes valores:

    0 = Preto        8 = Cinza
    1 = Azul         9 = Azul claro
    2 = Verde        A = Verde claro
    3 = Verde-água   B = Verde-água claro
    4 = Vermelho     C = Vermelho claro
    5 = Roxo         D = Violeta
    6 = Amarelo      E = Amarelo claro
    7 = Branco       F = Dourado

Caso nenhum argumento seja passado, este comando restaurará a cor de
antes do CMD.EXE ser executado. Este valor vem ou da janela atual do
console, ou da opção /T da linha de comando, ou do valor de DefaultColor
no Registro.

O comando COLOR altera ERRORLEVEL para 1 se for tentado se executar o
comando COLOR com as mesmas cores de primeiro plano e de tela de
fundo.

Exemplo: \"COLOR fc\" gera o vermelho claro na tela de fundo branca brilhante"




@export var doors:Node
@export var commandPrompt:Node

func help(comando: String)-> String:
	match comando:
		"teste":
			return "oh hi"
		"cmd":
			return helpCMD + "\n nada disso realmente funciona no DOORS, mas num sistema operacional real, dependendo de qual seja, funciona sim"
		"cd":
			return "oh hi"
		"date":
			return "oh hi"
		"copy":
			return "oh hi"
		"dir":
			return "oh hi"
		"dism":
			return "oh hi"
		"color":
			return helpColor
		"teste":
			return "oh hi"
		"teste":
			return "oh hi"
		"teste":
			return "oh hi"
		null:
			return generalComand
		_:
			return generalComand

func echo(texto)->String:
	return "@ "+texto
func cmd()->String:
	var cmd = preload("uid://bcsu1i803gyh1")
	doors.add_child(cmd.instantiate())
	return "Nova instância criada"

func color(cores: String)->String:
	var lineEditor: LineEdit = commandPrompt.get_node("PanelContainer/ScrollContainer/VBoxContainer/LineEdit")
	var CodeViewer: CodeEdit = commandPrompt.get_node("PanelContainer/ScrollContainer/VBoxContainer/CodeEdit")
	var fundo:PanelContainer = commandPrompt.get_child(0)
	var corfinal: Array[String]
	if cores.length()>2 or cores.length()<2:
		return "ERRO: mais de 2 digitos ou apenas 1 digito inserido"
	
	var colors: Array[String]
	colors.assign(cores.split("",false))
	
	if colors[0] == colors[1]:
		return "ERRO: Cores iguais, tente usar cores diferentes para isso"
	
	for i in colors.size():
		var setColor: Color
		var corTemp:String
		match colors[i]:
			"0":
				setColor = Color.BLACK
				corTemp = "Preto"
			"1":
				setColor = Color.BLUE
				corTemp = "Azul"
			"2":
				setColor = Color.GREEN
				corTemp = "Verde"
			"3":
				setColor = Color.SEA_GREEN
				corTemp = "Verde-água"
			"4":
				setColor = Color.RED
				corTemp = "Vermelho"
			"5":
				setColor = Color.PURPLE
				corTemp = "Roxo"
			"6":
				setColor = Color.YELLOW
				corTemp = "Amarelo"
			"7":
				setColor = Color.WHITE
				corTemp = "Branco"
			"8":
				setColor = Color.GRAY
				corTemp = "Cinza"
			"9":
				setColor = Color.LIGHT_BLUE
				corTemp = "Azul Claro"
			"A":
				setColor = Color.LIGHT_GREEN
				corTemp = "Verde claro"
			"B":
				setColor = Color.LIGHT_SEA_GREEN
				corTemp = "Verde-água claro"
			"C":
				setColor = Color.LIGHT_CORAL
				corTemp = "Vermelho claro"
			"D":
				setColor = Color.VIOLET
				corTemp = "Violeta"
			"E":
				setColor = Color.LIGHT_YELLOW
				corTemp = "Amarelo claro"
			"F":
				setColor = Color.GOLD
				corTemp = "Dourado"
			_:
				return "ERRO: Um valor não consta na lista disponivel"
		if i == 0:
			corfinal.append(corTemp)
			var style:StyleBoxFlat = StyleBoxFlat.new()
			style.bg_color =  setColor
			fundo.add_theme_stylebox_override("panel", style)
		elif i == 1:
			CodeViewer.add_theme_color_override("font_readonly_color", setColor)
			lineEditor.add_theme_color_override("font_color", setColor)
			corfinal.append(corTemp)
	return "Cor de fundo e Frente trocados para " + corfinal[0] + " e " + corfinal[1] + "."
