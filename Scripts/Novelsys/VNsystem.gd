extends Node
@onready var novelsys = $".."
var choice_mode = false
var bbcode = ""
var button_list = []
##var button_scene = preload("res://ButtonScene.tscn") ## Not required for the CS50 project
var colon = 0
var titulus = ""
# Reference to the RichTextLabel node
var dialogueLabel: RichTextLabel
var index = 0
# Array to store lines of text
var textLines := []
var entCode = ""
var endCode = ""
# Index to keep track of the current line being displayed
var currentLineIndex = 0
# Timer to control the waiting time
var waitTimer: Timer
var scroll_timer : Timer
@export var scroll_speed = 8
var waitTime = 1.0 / (scroll_speed*10.0)
var diag = ""
func _ready():
	dialogueLabel = $RichTextLabel
	scroll_timer = $scrolltimer
	scroll_timer.wait_time = 1.0 / (scroll_speed*10.0)

	
func load_text_file(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var file_contents = file.get_as_text()
	textLines = file_contents.split("\n")
	file.close()
		
func display_next_line():
	dialogueLabel.text = ""
	scroll_timer.start(waitTime)

func _on_scroll_timer_timeout():
	print("timeout")
	if currentLineIndex < textLines.size() - 1 :
		diag = textLines[currentLineIndex]
		if diag == "":
			print("Dialogue Ended")
		color_hex()
		richtext(diag)
		define_narrator(diag)
		if diag[0] == "+":
			choice_display(diag)
			index = 0
			scroll_timer.stop()
			currentLineIndex = 0
			display_next_line()
			return
		if not currentLineIndex < textLines.size() - 1 :
			next_script()
			choice_mode = true
		if choice_mode == false:
			$Name.text = titulus
			if diag == "":
				currentLineIndex += 1
				diag = textLines[currentLineIndex]
			if diag == "End_Signal":
				$RichTextLabel.hide()
				$"..".playlist = []
				print("Got here")
				get_tree().paused = false
			dialogueLabel.text += entCode + textLines[currentLineIndex][index] + endCode
			index += 1
			scroll_timer.start()
			end_bugfix(diag)
		if button_list == []:
			choice_mode = false
func color_hex():
	if "/" in bbcode:
		bbcode = ""
		entCode = "[color=#000000]"
		endCode = "[/color]"

func richtext(diag):
	end_bugfix(diag)
	if diag[index] == "[":
		var endIndex = diag.find("]" , index)
		bbcode = diag.substr(index, endIndex - index + 1)
		if "/" in bbcode:
			endCode = bbcode
		else:
			entCode = bbcode
		index = endIndex + 1
		end_bugfix(diag)
		return

func define_narrator(diag):
	if diag[index] == "~":
		colon = diag.find(":" , index)
		colon = diag.find(":" , index)
		index = colon + 1
		titulus = diag.substr(1 , colon - 1)

func end_bugfix(diag):
	if index >= diag.length():
		scroll_timer.stop()
		currentLineIndex += 1
		index = 0
		

func choice_display(diag):
	pass
#	print(diag)
#	for i in range(int(diag[1])):
#		currentLineIndex += 1
#		var button_instance = button_scene.instantiate()
#		var x_position = 960  
#		var y_position = 200 + (i*100)
##		# Add the button to the scene
#		add_child(button_instance)
#		button_list.append(button_instance)
#		button_instance.choice.text = "[center]" +textLines[currentLineIndex]+"[/center]"
#	choice_mode = true
#	$Name.text = "" 
#	next_script()

func next_script():
	if novelsys.index + 1 != novelsys.playlist.size():
		novelsys.index += 1
		novelsys.play()
	else:
		pass
