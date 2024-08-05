extends CanvasLayer

@onready var health_num = $player_infoBox/healthPanel/HealthNum
@onready var coin_num = $player_infoBox/coinsPanel/CoinNum

func setHealth(healthPlayer):
	health_num.text = str(healthPlayer);

func setCoins(coins):
	coin_num.text = str(coins)
