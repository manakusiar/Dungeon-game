extends AnimatedSprite2D

var player_in = false
var opened = false
@onready var chest_open = $ChestOpen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("move_down") and player_in and opened == false:
		open()

func open():
	opened = true
	play("open")
	chest_open.play()

func closed():
	opened = false
	play("closed")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in = true
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in = false
