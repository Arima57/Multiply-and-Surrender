extends AnimatedSprite2D
@onready var player := $".."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$sword_flash.hide()

func _physics_process(_delta):
	if player.velocity.x > 0:
		flip_h = false
	elif player.velocity.x < 0:
		flip_h = true

	if player.velocity.y < 0:
		play("Jump")
	
	if player.velocity.y > 0 and not player.is_on_wall():
		play("Fall")
	
	if player.is_on_wall() and player.velocity.y > 0:
		play("wall")


	if player.hero_state[1] == "attack":
		play("Attack")
		$sword_flash.show()
		$sword_flash.play("flash")
		await animation_finished
		$sword_flash.hide()
		player.hero_state[1] = "idle"
		
	if player.hero_state == ["ground", "idle"]:
		if player.velocity.x == 0:
			play("Idle")
		else:
			play("Run")
			
