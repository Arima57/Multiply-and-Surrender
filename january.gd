extends Node2D

@onready var novelsys = $ForestBG/ParallaxLayer8/Novelsys
var camera
func _ready():
	stateMachine.spawn($".", Vector2(1763, 0))
	camera =  preload("res://Scenes/camera_2d.tscn").instantiate()
func _process(delta):
	$ForestBG.scroll_offset.x -= 150 * delta


func _on_texture_button_button_up():
	var buttonTween := get_tree().create_tween()
	buttonTween.tween_property($TextureButton, "modulate", Color(1, 1, 1, 0), 0.2)
	buttonTween.tween_callback(func():
		$TextureButton.queue_free()
		add_child(camera)
		camera.camera.limit_bottom = 500
		novelsys.playlist = ["res://dialogues/TEST"]
		novelsys.play()
)


func _on_scene_changer_body_entered(body):
	if "type" in body:
		stateMachine.camera_target = null
		stateMachine.clone_list.clear()
		get_tree().change_scene_to_file("res://Scenes/Levels/Exclusion.tscn")
		print("True")
