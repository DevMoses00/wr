extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

@export var dialogue : NinePatchRect

var MAX_WIDTH = 550

var text = ""
var letter_index = 0

# how many seconds will pass between each letter character displayed
var letter_time = 0.00000000001
var space_time = 0.0000000001
var punctuation_time = 0.00000001

signal finished_displaying()

func display_text(text_to_display: String):
	
	# dialogue tags
	# for Left Side Narration
	if text_to_display.begins_with("JF: "):
		text_to_display = text_to_display.trim_prefix("JF: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("SF: "):
		text_to_display = text_to_display.trim_prefix("SF: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("K: "):
		text_to_display = text_to_display.trim_prefix("K: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("TF: "):
		text_to_display = text_to_display.trim_prefix("TF: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	# Do one for all the other characters too
	
	
	text = text_to_display
	label.text = text_to_display # label expands to the full width of the text
	
	if text.length() > 3:
		await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	# resizing all the other character text boxes
	dialogue.custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # wait for x resize
		await resized # wait for y resize
		custom_minimum_size.y = size.y
		
		# resizing all the other character text boxes
		dialogue.custom_minimum_size.y = size.y
		
	# POSITIONING - NOT SURE I NEED THIS
	global_position.x -= (size.x / 2) 
	global_position.y -= (size.y + 24) 
	
	label.text = ""
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	# if there are still letter characters to display
	match text[letter_index]:
		"!", ".", ",", "?","-":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
			# play a sound every time there is a space
			var sfx_standard = ["Write1","Write2","Write3","Write4","Write5","Write6","Write7"].pick_random()
			#SoundManager.play_sfx(sfx_standard,0,-15)
		_:
			timer.start(letter_time)

func _on_letter_display_timer_timeout() -> void:
	_display_letter()
