extends CharacterBody2D
### Constants
#############
const type:= "hero"
const SPEED = 300.0
const coyote_TIME:float = 0.4
#### Mostly constants fttb, but may change who knows
####################################################
@export var hero_health:int = 100
var gravity = 2500
var JUMP_VELOCITY = -700.0
###Values at start
##################
@onready var hero_state:= ["air", "idle"]
@onready var direction:int = 1
@onready var animation_player:= $AnimatedSprite2D
### Unitialozed strong values, usually very important
#####################################################
var coyote_timer:Timer
var clone_serial:int
var tween:Tween
##Extremely specific purpose
###########################
var is_coyote:bool=true
var is_first_jump:bool=true
var coyote_start:bool = true
###Different states of player. dont mistake, there are more states outside of these as well
###########################################################################################
var air_states:= [["air", "attack"], ["air", "idle"], ["coyote", "idle"]]
var jumpable_states:= [["ground", "idle"], ["ground", "dash"], ["coyote", "idle"]]
var movables:= [["ground", "idle"], ["air", "idle"], ["air", "attack"], ["coyote", "idle"], ["wall", "idle"]]
var bounceable:= [["wall", "idle"]]


func _process(delta):
	if position.x < 5:
		position.x = 5

func _physics_process(delta):
	#### Checking whether the plyer is dead yet
	if hero_health == 0:
		stateMachine.clone_list.erase(self)  ## Deleting the dead from the 
		if self != stateMachine.camera_target:
			self.queue_free() 
	# Check the current state
	hero_state[0] = stateMachine.handle($".")
	
	if hero_state[1] ==  "dash":
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(dir_fix() * -20, 20), 0.15)
		tween.tween_property(self, "position", position + Vector2(dir_fix() * -400, -20), 0.2).set_ease(Tween.EASE_OUT)
		hero_state[1] = "idle"
		
	if hero_state in bounceable:
		position.y += (gravity / 40) * delta
		
	#Handle coyote jump timer
	if hero_state[0] == "coyote" and coyote_start == true:
		$coyote_timer.start(coyote_TIME)
		coyote_start = false
	if hero_state in air_states:
		velocity.y += gravity * delta
	if clone_serial == stateMachine.current_hero:
	
	
	# Handle Jump
		if (hero_state in jumpable_states or is_first_jump == true)  and Input.is_action_just_pressed("jump") and hero_state not in bounceable:
			is_coyote = false
			if hero_state not in jumpable_states:
				is_first_jump = false
			velocity.y = JUMP_VELOCITY
	
		movement_machine()
	
	
		############################
		##Handle the cloning and decloning process
		############################
		if Input.is_action_just_released("declone"):
			stateMachine.despawn()
	else:
		if hero_state in movables:
			velocity.x = 0
	move_and_slide()



func movement_machine():
	if hero_state in movables:
		direction = Input.get_axis("ui_left", "ui_right")
		if direction == 1:
			animation_player.flip_h = false
		elif direction == -1:
			animation_player.flip_h = true
	velocity.x = direction * SPEED	


func _on_coyote_timer_timeout():
	if hero_state[0] == "coyote":
		is_coyote = false
		is_first_jump = false


func get_type():
	return type

func pos_fix(spawn_position:Vector2):
	spawn_position.x += 200 * dir_fix()
	if spawn_position.x < 5:
		return Vector2(5,spawn_position.y)
	else:
		return spawn_position
	


func _on_wall_collider(node):
	pass


func dir_fix():
	if animation_player.flip_h:
		return 1
	else:
		return -1

