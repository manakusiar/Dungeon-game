extends Node2D

@onready var rand = RandomNumberGenerator.new()

func _ready() -> void:
	rand.randomize()
