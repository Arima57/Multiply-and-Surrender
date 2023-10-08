extends Node
##General Purpose throughout the game
#####################################
signal done
var camera_target:CharacterBody2D=null
###Very explanatory
var clone_list:Array = []
var clone_limit:int = 3
var current_hero:int= 0
var current_clone_bar_value:float = 0.0
var cloneBarTween:Tween
var cloneBarReverse:Tween
const max_clone_bar_value:float = 100
var dashAllowed:bool = true
@onready var clone_coolTime:int = 20
@onready var dash_coolTime:int = 1


#### Common Grounds, handoff
func handle(player):
	var state:String
	if player.type == "hero":
		state = handle_hero(player)
	return state





###############################################################################################
#								Here Lies the Hero Section		 							###
################################################################################################
################################################################################################

func handle_hero(player):
	if player.velocity.y > 200 and player.is_on_wall_only():
		return "wall"
	if not player.is_on_floor():
			if player.is_coyote:
				return "coyote"
			else:
				return "air"

	if player.is_on_floor():
		player.is_first_jump = true
		player.is_coyote = true
		player.coyote_start = true
		return "ground"



func spawn(parent_node:Node, spawn_position: Vector2 = Vector2(50, 50)):
	var character_scene := preload("res://Scenes/Characters/hero.tscn")
	var character_instance := character_scene.instantiate()
	character_instance.position = spawn_position
	character_instance.clone_serial =  current_hero + 1
	parent_node.add_child(character_instance)
	character_instance.modulate = Color(1,1,1)
	camera_target = character_instance
	current_hero += 1
	clone_list.append(camera_target)


func despawn():
	if current_hero > 1:
		current_hero -= 1;
		for child in clone_list:
			if child.clone_serial == current_hero:
				var previous := camera_target
				camera_target = child
				camera_target.modulate = Color(1,1,1)
				previous.hero_health = 0
				break




func _process(delta):
	if camera_target != null:
		if Input.is_action_just_released("clone"):
			if cloneBarReverse != null and cloneBarReverse.is_running():
				cloneBarReverse.kill()
				get_tree().paused = false
		if Input.is_action_just_pressed("clone"):
			if len(clone_list) < clone_limit:
				if current_clone_bar_value == 100.0:
					mc_clone_call()
					

		if not get_tree().paused:
			for child in clone_list:
				if child.is_on_wall():
					if child.tween != null and child.tween.is_running():
						child.tween.kill()
			
			if Input.is_action_just_pressed("jump") or \
			Input.is_action_just_pressed("attack") or \
			camera_target.is_on_wall():
			#############  FILLING IS THIS VOID ###################
				if camera_target.tween != null and camera_target.tween.is_running():
					camera_target.tween.kill()
				if camera_target.is_on_wall_only():
					camera_target.hero_state[0] = "wall"
			if Input.is_action_just_pressed("dash"):
				if dashAllowed:
					camera_target.hero_state[1] = "dash"
					dashAllowed = false
					$dash_cooldown.start(dash_coolTime)
			if cloneBarTween == null and current_clone_bar_value != max_clone_bar_value:
				cloneBarTween = create_tween()
				cloneBarTween.tween_property(self, "current_clone_bar_value", 100.0, ((max_clone_bar_value - current_clone_bar_value) / 100) * clone_coolTime)
				cloneBarTween.tween_callback(func(): cloneBarTween = null)




func _on_dash_cooled_down():
	dashAllowed = true

func mc_clone_call():
	if Input.is_action_pressed("clone"):
		get_tree().paused = true
		cloneBarReverse = create_tween()
		cloneBarReverse.tween_property(self, "current_clone_bar_value", 0, 1)
		cloneBarReverse.tween_callback(func():
			camera_target.modulate = Color(0.38, 0.247, 0.247)
			spawn(camera_target.get_parent(), camera_target.pos_fix(camera_target.position))
			if len(clone_list) > 1:
				camera_target.animation_player.flip_h = clone_list[-2].animation_player.flip_h
			cloneBarReverse = null
			get_tree().paused = false)






###############################################################################################
#								UnderNeath Lies the Enemy Section 							###
################################################################################################
################################################################################################


func attack(body:CharacterBody2D , host:CharacterBody2D):
	if host.type == "hero":
		host.hero_health -= 10
		host.knockback((host.global_position - body.global_position).x)
	if host.type == "low_grade":
		host.HP = 0
		body.velocity.y = -400
		
