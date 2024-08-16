extends Camera2D

@export var randomStrength: float = 30.0
@export var strengthFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0
var speed = 10

func _process(delta: float) -> void:
	# Movement
	var window_size = get_viewport().size
	var player = get_tree().get_nodes_in_group("player")[0]
	position.x = lerp(position.x, player.position.x, speed * delta)
	var go_y = (floor(player.position.y / window_size.y * 2) + 0.5) * window_size.y / 2
	position.y = lerp(position.y, go_y, speed * delta)
	
	# Screenshake
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, strengthFade * delta)
		
		offset = randomOffset()


func apply_shake():
	shake_strength = randomStrength
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
