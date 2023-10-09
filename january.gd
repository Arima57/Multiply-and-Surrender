extends Node2D

@onready var richtext := $ForestBG/ParallaxLayer8/Novelsys/VNsystem/RichTextLabel
@onready var novelsys := $ForestBG/ParallaxLayer8/Novelsys
var camera
var char_name:String
var time_to_end:bool = false
func _ready():
	$ForestBG/ParallaxLayer8/Novelsys.hide()
	stateMachine.spawn($".", Vector2(1763, 0))
	camera =  preload("res://Scenes/camera_2d.tscn").instantiate()
	if stateMachine.camera_target != null:
		stateMachine.camera_target.hide()
	$TileMap.hide()

func _process(delta):
	$ForestBG.scroll_offset.x -= 150 * delta
	if richtext != null and "your previous" in richtext.text:
		time_to_end = true

	if time_to_end and Input.is_action_just_pressed("ui_accept"):
		$ForestBG/ParallaxLayer8/Novelsys.queue_free()
		get_tree().paused = false
		stateMachine.camera_target.show()
		$TileMap.show()
		time_to_end = false

func _on_texture_button_button_up():
	var buttonTween := get_tree().create_tween()
	buttonTween.tween_property($TextureButton, "modulate", Color(1, 1, 1, 0), 0.2)
	buttonTween.tween_callback(func():
		$TextureButton.queue_free()
		add_child(camera)
		camera.camera.limit_bottom = 500
		get_tree().paused = true
		novelsys.playlist = ["res://dialogues/Intro"]
		novelsys.play()
		$ForestBG/ParallaxLayer8/Novelsys.show()
)


func _on_scene_changer_body_entered(body):
	if "type" in body:
		stateMachine.camera_target = null
		stateMachine.clone_list.clear()
		get_tree().change_scene_to_file("res://Scenes/Levels/Exclusion.tscn")
		print("True")
