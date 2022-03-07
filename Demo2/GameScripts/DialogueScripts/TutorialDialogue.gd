extends CanvasLayer

export(String, FILE, "*.json")var nuwa_file
export(String, FILE, "*.json")var instruction_file

var nuwa_dialogues = []
var instructions_dialogues = []
var current_dialogue_id = 0
var dialogue_len = 0
var current_dialogue = true

signal end_dialogue

func _ready():
	nuwa_dialogues = load_nuwa_dialogue()
	instructions_dialogues = load_instructions_dialogue()
	current_dialogue_id = -1
	current_dialogue = true
	dialogue_len = len(nuwa_dialogues)
	#$Nuwa.visible = true
	next_line()

func _input(event):
	if event.is_action_pressed("dialogue"):
		next_line()
		
func next_line():
	if current_dialogue_id <3:
		 current_dialogue_id += 1
		 $Nuwa.visible = true
		 $Instructions.visible = false
		 $Nuwa/Name.text = nuwa_dialogues[current_dialogue_id]['name']
		 $Nuwa/Message.text = nuwa_dialogues[current_dialogue_id]['text']
		 return
	if current_dialogue:
		current_dialogue_id += 1
	if current_dialogue_id >= dialogue_len:
		$Nuwa.visible = false
		$Instructions.visible = false
		emit_signal("end_dialogue")
		return 
	if current_dialogue:
		# Nuwa
		$Nuwa.visible = true
		$Instructions.visible = false
		$Nuwa/Name.text = nuwa_dialogues[current_dialogue_id]['name']
		$Nuwa/Message.text = nuwa_dialogues[current_dialogue_id]['text']
		current_dialogue = false
	else:
		print("current_dialogue_id", current_dialogue_id)
		$Instructions.visible = true
		$Nuwa.visible = false
		$Instructions/Message.text = instructions_dialogues[current_dialogue_id]['text']
		current_dialogue = true
		
func load_nuwa_dialogue():
	var file = File.new()
	if file.file_exists(nuwa_file):
		file.open(nuwa_file, file.READ)
		return parse_json(file.get_as_text())
		
func load_instructions_dialogue():
	var file = File.new()
	if file.file_exists(instruction_file):
		file.open(instruction_file, file.READ)
		return parse_json(file.get_as_text())
		
