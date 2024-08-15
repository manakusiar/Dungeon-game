extends Area2D

@onready var audio = $AudioStreamPlayer2D
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _on_body_entered(body):
	audio.play()
	sprite.visible = false
	collision.disabled = true
	if body.has_method("add_coin"):
		body.add_coin(1)


func _on_audio_stream_player_2d_finished():
	queue_free()
