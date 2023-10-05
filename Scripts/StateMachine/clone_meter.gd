extends TextureProgressBar
func _ready():
	self.scale = Vector2(0.8, 0.8)
	$AnimatedSprite2D.hide()

func _process(delta):
	value = stateMachine.current_clone_bar_value
	if stateMachine.current_clone_bar_value == 100 or (stateMachine.cloneBarReverse != null and stateMachine.cloneBarReverse.is_running()):
		$AnimatedSprite2D.show()
	else:
		$AnimatedSprite2D.hide()
