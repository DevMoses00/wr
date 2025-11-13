extends Node2D

@export_category("Assets")
@export var bowl : StaticBody2D
@export var bowl_color : AnimatedSprite2D
@export var background : AnimatedSprite2D
@export var floor: AnimatedSprite2D
@export var mback : AnimatedSprite2D
@export var mfront : AnimatedSprite2D
@export var circles : AnimatedSprite2D
@export var dial : AnimatedSprite2D
@export var dial_shadow : AnimatedSprite2D
@export var gumballA: RigidBody2D
@export var gumballB: RigidBody2D
@export var whitescreen : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signals_connect()
	DialogueManager.readJSON("res://dialogue/within_rotation_dialogue.json")
	#SoundManager.play_sfx(start_noise)
	
	await get_tree().create_timer(2.0).timeout
	
	#start Dialogue opening
	dialogue_go("Intro")
	
	#when dialogue is complete, show the marker and allow it to be clickable
	pass # Replace with function body.


func signals_connect():
	DialogueManager.intro_over.connect(start_gumball_sequence)
	$DialManager.rotation_complete.connect(_dispense_balls)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_gumball_sequence():
	#SoundManager.play_sfx(initial start sound)
	#SoundManager.play_sfx(picking up the ball sound) 
	var tween = create_tween()
	tween.tween_property(bowl,"position:y",-200,1).set_trans(Tween.TRANS_BACK).as_relative()
	tween.tween_property($Camera2D,"position:y",-100,1).set_trans(Tween.TRANS_BACK).as_relative()
	await get_tree().create_timer(1).timeout
	action_marker_right()
	action_marker_left()
	action_marker_top()




# HELPER FUNCTIONS
func dialogue_go(dialogue_key):
	DialogueManager.dialogue_player(dialogue_key)

func fade_tween_in(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)

func fade_tween_out(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 0.0), 2)

func action_marker_right():
	$ActionMarkerRight.position = Vector2(500,-1100)
	$ActionMarkerRight.show()
	#SoundManager.play_sfx(some_blip)
	$ActionMarkerRight.disabled = false

func action_marker_left():
	$ActionMarkerLeft.position = Vector2(-700,-1100)
	$ActionMarkerLeft.show()
	#SoundManager.play_sfx(some_blip)
	$ActionMarkerLeft.disabled = false

func action_marker_top():
	$ActionMarkerTop.show()
	#SoundManager.play_sfx(some_blip)
	$ActionMarkerTop.disabled = false

func _on_action_marker_right_pressed() -> void:
	$ActionMarkerRight.hide()
	$ActionMarkerLeft.hide()
	$ActionMarkerTop.hide()
	#SoundManager.play_sfx(accept_sound)
	$ActionMarkerRight.disabled = true
	bowl_color.play("play")
	background.play("play")
	mfront.play("play")
	var tween = create_tween()
	tween.tween_property(bowl,"position:x",200,0.5).set_trans(Tween.TRANS_BACK).as_relative()
	tween.parallel().tween_property($Camera2D,"position:x",150,0.2).as_relative()
	tween.parallel().tween_property(bowl,"rotation_degrees",10,0.5).as_relative()
	tween.tween_interval(0.1)
	tween.tween_property(bowl,"position:x",-200,0.5).set_trans(Tween.TRANS_BACK).as_relative()
	tween.parallel().tween_property($Camera2D,"position:x",-150,0.2).as_relative()
	tween.parallel().tween_property(bowl,"rotation_degrees",-10,0.5).as_relative()
	await tween.finished
	$ActionMarkerRight.show()
	$ActionMarkerLeft.show()
	$ActionMarkerTop.show()
	$ActionMarkerRight.disabled = false




func _on_action_marker_left_pressed() -> void:
	$ActionMarkerLeft.hide()
	$ActionMarkerRight.hide()
	$ActionMarkerTop.hide()
	#SoundManager.play_sfx(accept_sound)
	$ActionMarkerLeft.disabled = true
	bowl_color.play("play")
	background.play("play")
	mfront.play("play")
	circles.play()
	var tween = create_tween()
	tween.tween_property(bowl,"position:x",-200,0.5).set_trans(Tween.TRANS_BACK).as_relative()
	tween.parallel().tween_property($Camera2D,"position:x",-150,0.2).as_relative()
	tween.parallel().tween_property(bowl,"rotation_degrees",-10,0.5).as_relative()
	tween.tween_interval(0.1)
	tween.tween_property(bowl,"position:x",200,0.5).set_trans(Tween.TRANS_BACK).as_relative()
	tween.parallel().tween_property($Camera2D,"position:x",150,0.2).as_relative()
	tween.parallel().tween_property(bowl,"rotation_degrees",10,0.5).as_relative()
	await tween.finished
	$ActionMarkerLeft.show()
	$ActionMarkerRight.show()
	$ActionMarkerTop.show()
	$ActionMarkerLeft.disabled = false


func _on_action_marker_top_pressed() -> void:
	$ActionMarkerLeft.hide()
	$ActionMarkerRight.hide()
	$ActionMarkerTop.hide()
	#SoundManager.play_sfx(accept_sound)
	$ActionMarkerLeft.disabled = true
	bowl_color.play("play",2.0)
	background.play("play",2.0)
	mfront.play("play",2.0)
	var tween = create_tween()
	tween.tween_property(bowl,"position:y",-150,0.3).set_trans(Tween.TRANS_BACK).as_relative()
	tween.parallel().tween_property($Camera2D,"position:y",-100,0.2).as_relative()
	#tween.parallel().tween_property(bowl,"rotation_degrees",-10,0.5).as_relative()
	#tween.tween_interval(0.05)
	tween.tween_property(bowl,"position:y",150,0.3).set_trans(Tween.TRANS_BACK).as_relative()
	tween.parallel().tween_property($Camera2D,"position:y",100,0.2).as_relative()
	#tween.parallel().tween_property(bowl,"rotation_degrees",10,0.5).as_relative()
	await tween.finished
	$ActionMarkerLeft.show()
	$ActionMarkerRight.show()
	$ActionMarkerTop.show()
	$ActionMarkerLeft.disabled = false



func _on_arrow_marker_pressed() -> void:
	# Onto the next sequence
	$ActionMarkerLeft.hide()
	$ActionMarkerRight.hide()
	$ActionMarkerTop.hide()
	$Camera2D/ArrowMarker.hide()
	await get_tree().create_timer(1).timeout
	var tween = create_tween()
	tween.tween_property(bowl,"position:y",200,2).as_relative()
	tween.parallel().tween_property($Camera2D,"position:y",300,2).as_relative()
	tween.tween_interval(1)
	tween.tween_property($Camera2D,"position:y",780,4).set_trans(Tween.TRANS_BACK).as_relative()
	pass # Replace with function body.

func _dispense_balls():
	await get_tree().create_timer(2).timeout
	bowl_color.play("play",0.4)
	background.play("play",0.4)
	mfront.play("play",0.4)
	floor.play("play",0.4)
	dial.play("play",0.4)
	dial_shadow.play("play",0.4)
	circles.play("play",0.4)
	#SoundManager.play_sfx(onto next sequence)
	
	#SoundManager.play_sfx(dispense_sound)
	
	#tween camera down to the final layer
	var tween = create_tween()
	tween.tween_property($Camera2D,"position:y",880,4).set_trans(Tween.TRANS_BACK).as_relative()
	await tween.finished
	
	await get_tree().create_timer(2).timeout
	
	#SoundManager.play_sfx(roll_ball_sound)
	
	gumballA.freeze = false
	gumballB.freeze = false
	#SoundManager.play_sfx(roll_balls_out_sound)
	await get_tree().create_timer(3).timeout
	var tween2 = create_tween()
	tween2.tween_property($Camera2D,"position:y",300,2).as_relative()
	tween2.parallel().tween_callback(fade_tween_in.bind(whitescreen))
	await tween2.finished
	#fade_tween_in(whitescreen)
	await get_tree().create_timer(4).timeout
	# function to set up the dialogue sequence
	
	await get_tree().create_timer(4).timeout
	fade_tween_out(whitescreen)
	
	pass
