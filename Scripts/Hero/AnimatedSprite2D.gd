extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"..".velocity.x > 0:
		flip_h = false
	elif $"..".velocity.x < 0:
		flip_h = true
