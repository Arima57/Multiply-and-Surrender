extends Node2D

func _ready():
	stateMachine.spawn($".", Vector2(250, 0))



func _on_cs50_DUCK_entered(body):
	if "type" in body and body.type == "hero":
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property($Cs50Duck, "position", $Cs50Duck.position - Vector2(0, 100), 1)
		tween1.tween_property($Cs50Duck, "modulate", Color(0,0,0,0), 1)
		tween1.tween_callback(func(): 
			$Cs50Duck.queue_free()
			stateMachine.camera_target = null
			stateMachine.clone_list.clear()
			get_tree().change_scene_to_file("res://december.tscn"))

