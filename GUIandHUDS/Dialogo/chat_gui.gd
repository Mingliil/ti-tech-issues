extends Control

const ButtonDiag = preload("res://GUIandHUDS/dialogue_button.tscn")

@onready var DialogueLabel: RichTextLabel = $HBoxContainer/VBoxContainer/RichTextLabel
@onready var SpeakerSprite: Sprite2D = $HBoxContainer/FalaParente/FalaSprite
@onready var ButtaoContainer: HBoxContainer = $HBoxContainer/VBoxContainer/ButtonCont
@onready var FalaNome: RichTextLabel = $FalaNome
@onready var playerHUD: CanvasLayer

var dialogue: Array[DE]
var current_dialogue_item: int = 0
var next_item: bool = true
var PLAYER: CharacterBody3D
var originalDial: Array[DE]
var reset: bool = false

func _ready() -> void:
	playerHUD = get_tree().get_first_node_in_group("HUD")
	visible = false
	playerHUD.visible = true
	ButtaoContainer.visible = false
	PLAYER = get_tree().get_first_node_in_group("Player")
	if !is_in_group("Dialogue"):
		add_to_group("Dialogue")

func _process(delta: float) -> void:
	if current_dialogue_item >= dialogue.size():
		if !PLAYER:
			for i in get_tree().get_nodes_in_group("Player"):
				PLAYER = i
			return
		#PLAYER.Speed = true
		queue_free()
		playerHUD.visible = true
		return

	if next_item:
		next_item = false
		playerHUD.visible = true
		var i = dialogue[current_dialogue_item]
		if i.speaker_name:
			FalaNome.text = i.speaker_name
			print(i.speaker_name)
		else:
			FalaNome.visible = false
		if i is DialogueFunction:
			if i.hide_dialogue_box:
				visible = false
				playerHUD.visible = true
			else:
				visible = true
				playerHUD.visible = false
			_function_resource(i)
		elif i is DialogueChoice:
			visible = true
			playerHUD.visible = false
			_choice_resource(i)
		elif i is DialogueText:
			visible = true
			playerHUD.visible = false
			_text_resource(i)
		else:
			printerr("tu fez algo errado aqui com a DE")
			current_dialogue_item += 1
			next_item = true
		

func _function_resource(i:DialogueFunction) -> void:
	var target_node = get_node(i.target_path)
	if target_node.has_method(i.function_name):
		if i.function_arguments.size() == 0:
			target_node.call(i.function_name)
		else:
			target_node.callv(i.function_name, i.function_arguments)
	
	if i.wait_for_signal_to_continue:
		var signal_name = i.wait_for_signal_to_continue
		if target_node.has_signal(signal_name):
			var signal_state = {"done": false}
			var callable = func(_args): signal_state.done = true
			target_node.connect(signal_name, callable, CONNECT_ONE_SHOT)
			while  not signal_state.done:
				await get_tree().process_frame
	
	current_dialogue_item +=1
	next_item = true

func _choice_resource(i:DialogueChoice	) -> void:
	#speaker
	DialogueLabel.text = i.text
	DialogueLabel.visible_characters = -1
	if i.speaker_img:
		$HBoxContainer/FalaParente.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = min(i.speaker_img_select_frame, i.speaker_img_Hframes -1)
	else:
		$HBoxContainer/FalaParente.visible = false
	$HBoxContainer/VBoxContainer/ButtonCont.visible = true
	for item in i.choice_text.size():
		var DialogueButtonVar = ButtonDiag.instantiate()
		DialogueButtonVar.text = i.choice_text[item]
		
		var function_resource: DialogueFunction = i.choice_function_call[item]
		if function_resource:
			DialogueButtonVar.connect("pressed",
			Callable(get_node(function_resource.target_path),function_resource.function_name).bindv(function_resource.function_arguments),
			CONNECT_ONE_SHOT)
			if function_resource.hide_dialogue_box:
				DialogueButtonVar.connect("pressed", hide, CONNECT_ONE_SHOT)
			DialogueButtonVar.connect("pressed",
			_choice_button_pressed.bind(get_node(function_resource.target_path), function_resource.wait_for_signal_to_continue),
			CONNECT_ONE_SHOT)
		else:
			DialogueButtonVar.connect("pressed", _choice_button_pressed.bind(null, ""), CONNECT_ONE_SHOT)
		ButtaoContainer.add_child(DialogueButtonVar)
	ButtaoContainer.get_child(0).grab_focus()
	

func _choice_button_pressed(target_node: Node, wait_for_signal_to_continue: String):
	ButtaoContainer.visible = false
	for i in ButtaoContainer.get_children():
		i.queue_free()
	#adicionar aqui audio de botao se precisar
	if wait_for_signal_to_continue:
		var signal_name = wait_for_signal_to_continue
		if target_node.has_signal(signal_name):
			var signal_state = {"done": false}
			var callable = func(_args): signal_state.done = true
			target_node.connect(signal_name, callable, CONNECT_ONE_SHOT)
			while not signal_state.done:
				await get_tree().process_frame
	
	current_dialogue_item +=1
	next_item = true

func _text_resource(i:DialogueText) -> void:
	#nome do falante
	$FalaAudio.stream = i.text_sound
	$FalaAudio.volume_db = i.text_volume_db
	
	var camera: Camera3D = get_viewport().get_camera_3d()
	if camera and i.camera_position != Vector3(999.999,999.999,999.999):
		var camera_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		camera_tween.tween_property(camera, "global_position", i.camera_position, i.camera_tansition_time)
	
	if !i.speaker_img:
		$HBoxContainer/FalaParente.visible = false
	else:
		$HBoxContainer/FalaParente.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = 0
	
	DialogueLabel.visible_characters = 0
	DialogueLabel.text = i.text
	var text_without_square_brackets: String = _text_without_square_brackets(i.text)
	var total_characters: int = text_without_square_brackets.length()
	var character_timer: float = 0.0
	while DialogueLabel.visible_characters < total_characters:
		if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("pulo"):
			DialogueLabel.visible_characters = total_characters
			break
		
		character_timer += get_process_delta_time()
		if character_timer >= (1.0/i.text_speed) or text_without_square_brackets[DialogueLabel.visible_characters] == " ":
			var character: String = text_without_square_brackets[DialogueLabel.visible_characters]
			DialogueLabel.visible_characters +=1
			if character != " ":
				$FalaAudio.pitch_scale = randf_range(i.text_volume_pithc_min, i.text_volume_pithc_max)
				$FalaAudio.play()
				if i.speaker_img_Hframes !=1:
					if SpeakerSprite.frame < i.speaker_img_Hframes - 1:
						SpeakerSprite.frame += 1
					else:
						SpeakerSprite.frame = 0
			character_timer = 0.0
		await  get_tree().process_frame
	SpeakerSprite.frame = min(i.speaker_img_rest_frame, i.speaker_img_Hframes-1)
	
	while  true:
		await  get_tree().process_frame
		if DialogueLabel.visible_characters == total_characters:
			if Input. is_action_just_pressed("Interact"):
				current_dialogue_item +=1
				next_item = true

func _text_without_square_brackets(text: String) -> String:
	var result: String = ""
	var inside_bracket: bool = false
	
	for i in text:
		if i =="[":
			inside_bracket = true
			continue
		
		if i == "]":
			inside_bracket = false
			continue
		
		if !inside_bracket:
			result += i
	
	return result
