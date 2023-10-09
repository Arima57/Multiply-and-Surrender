extends Node2D

var playlist = []
var index = 0
var scroll_speed = 4  # Adjust the scroll speed as needed
var scroll_timer: Timer
var VN_mode = false
@onready var VN = $VNsystem


func play():
	VN.load_text_file(playlist[index])
	VN.currentLineIndex = 0
	VN.index = 0
	VN_mode = true
	VN.button_list= []
	

func _process(delta):
	if VN.button_list == []:
		VN.choice_mode = false
	else:
		VN.choice_mode = true

	if VN_mode == false:
		$NinePatchRect.hide()
		$VNsystem/Name.text = ""
		$VNsystem/RichTextLabel.text = ""
	elif VN_mode == true and VN.choice_mode == false:
		$NinePatchRect.show()

func _unhandled_input(event):
	if VN_mode == true and VN.choice_mode == false:
		if Input.is_action_just_pressed("ui_accept"):
			if VN.index == 0:
				VN.display_next_line()
			else:
				VN.scroll_timer.stop()
				VN.index = 0
				if ":" in VN.textLines[VN.currentLineIndex]:
					var text_length = VN.textLines[VN.currentLineIndex].length()
					var display_text = VN.textLines[VN.currentLineIndex].substr(VN.colon + 1, text_length)
					VN.dialogueLabel.text = display_text
				else:
					VN.dialogueLabel.text = VN.textLines[VN.currentLineIndex]
				VN.currentLineIndex += 1
				VN.endCode = ""
				VN.entCode = ""
			if VN.diag == "End_Signal":
				VN_mode = false
				$VNsystem/RichTextLabel.hide()
				print("Got here")
				get_tree().paused = false



