extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.frame_coords.x = randi_range(0,6)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_method("die") and body.dead == false:
			body.die()
