extends CanvasLayer

@onready var coins = $PlayerInfoBox/CoinTexture/Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func reload_coins(ammount):
	coins.text = "x" + str(ammount)
