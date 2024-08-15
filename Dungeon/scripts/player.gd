extends CharacterBody2D

# Constant Values
const SPEED = 1500
const JUMP_VELOCITY = -400.0

# Base Variables
var coins = 0
var acceleration = Vector2.ZERO
var last_haxis = 0
var dead = false
var jumping = false

# Onready
@onready var animations = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cayote_timer = $CayoteTimer
@onready var death_timer = $DeathTimer
@onready var jump_audio = $JumpAudio
@onready var death_audio = $DeathAudio
@onready var revive_audio = $ReviveAudio
@onready var gui = %Gui


func _physics_process(delta):
	# Move player
	var haxis = Input.get_axis("move_left", "move_right")
	if not dead:
		velocity.x += haxis * delta * SPEED

	# Gravity
	acceleration.y += 9.8 / 2
	if is_on_floor():
		acceleration.y = 0
	if is_on_ceiling():
		acceleration.y = 1
	if is_on_floor() and Input.is_action_pressed("move_down"):
		position.y += 1
	
	
	# Jump
	var was_on_floor = is_on_floor()
	if not dead and Input.is_action_just_pressed("jump") and (was_on_floor or not cayote_timer.is_stopped()):
		acceleration.y -= 100
		cayote_timer.stop()
		jump_audio.play()
		jumping = true
		
	if jumping == true:
		if Input.is_action_just_released("jump"):
			jumping = false
			acceleration.y = 0
		if velocity.y > 0:
			jumping = false 


	# Acceleration and velocity
	velocity += acceleration
	velocity *= 0.9
	acceleration *= 0.9
	
	
	# Death
	if Input.is_action_just_pressed("self_kill"):
		die()

	# Movement
	move_and_slide()

	if not is_on_floor() and was_on_floor:
		cayote_timer.start()
	
	# Animations
	if not dead:
		if velocity.x != 0:
				sprite.flip_h = (velocity.x < 0)
		if is_on_floor():
			if haxis:
				animations.play("run")
			else:
				if animations.current_animation == "run" and velocity.x > 3000:
					animations.play("stop")
				elif animations.current_animation != "stop":
					animations.play("idle")
		else:
			if velocity.y < 0:
				animations.play("jump")
			else:
				animations.play("fall")

func die():
	dead = true
	death_timer.start()
	animations.play("die")
	death_audio.play()
	

func respawn_player():
	# get spawn nodes
	var spawn_points = get_tree().get_nodes_in_group("respawn")

	# assume the first spawn node is closest
	var nearest_spawn_point = spawn_points[0]

	# look through spawn nodes to see if any are closer
	for spawn_point in spawn_points:
		if spawn_point.global_position.distance_to(global_position) < nearest_spawn_point.global_position.distance_to(global_position):
			nearest_spawn_point = spawn_point

	# reposition player
	global_position = nearest_spawn_point.global_position


func _on_death_timer_timeout():
	animations.play("revive")
	
	respawn_player()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "revive":
		dead = false
		
func add_coin(ammount):
	coins += ammount
	gui.reload_coins(coins)
