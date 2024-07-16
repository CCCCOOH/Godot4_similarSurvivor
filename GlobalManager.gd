extends Node
var run:bool = true
var killCount = 0
var priceLevel = []
var enemyGenerationSpeed = 2
var weapon_count:int = 1
func  _ready() -> void:
	for i in range(1, 100, 10):
		priceLevel.append(i)
	for i in range(110, 1000, 50):
		priceLevel.append(i)
	for i in range(1000, 10000, 100):
		priceLevel.append(i)

func add_kill(n:int = 1):
	killCount += 1
