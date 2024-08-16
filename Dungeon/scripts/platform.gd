extends AnimatableBody2D

var velocity = Vector2.ZERO
var old_position = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = global_position - old_position
	old_position = global_position
