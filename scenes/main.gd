extends Node2D

@export_category("Assets")
@export var bowl : StaticBody2D
@export var background : AnimatedSprite2D
@export var mback : AnimatedSprite2D
@export var mfront : AnimatedSprite2D
@export var circles : AnimatedSprite2D
@export var dial : AnimatedSprite2D
@export var dial_shadow : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SoundManager.play_sfx(start_noise)
	
	#await get_tree().create_timer(2.0).timeout
	
	#start Dialogue opening
	
	#when dialogue is complete, show the marker and allow it to be clickable
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
