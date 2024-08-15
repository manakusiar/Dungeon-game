extends StaticBody2D

var bodies = 0
@onready var animation_player = $AnimationPlayer

func _on_area_2d_body_entered(body):
	bodies += 1
	animation_player.play("open")


func _on_area_2d_body_exited(body):
	bodies -= 1
	if bodies <= 0:
		animation_player.play("close")
