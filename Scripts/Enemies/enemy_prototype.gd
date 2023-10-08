extends CharacterBody2D

@onready var SPEED:int = 100
@onready var gravity:int = 1000 
const type = "low_grade"
var HP = 1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	if HP < 1:
		$AnimatedSprite2D.play("death")
		for i in range(1, 6):
			set_collision_layer_value(i, false)
		await $AnimatedSprite2D.animation_finished
		self.queue_free()


