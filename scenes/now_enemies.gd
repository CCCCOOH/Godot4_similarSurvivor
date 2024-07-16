extends Node2D
@onready var enemy = preload("res://scenes/enemy.tscn")
var tilemap = null

func _ready() -> void:
	tilemap = get_tree().get_first_node_in_group("map")

func _on_timer_timeout() -> void:
	add_chicken(GlobalManager.enemyGenerationSpeed)
	
func add_chicken(n:int):
	for i in range(n):
		var ran = RandomNumberGenerator.new()
		var num = ran.randi_range(0, len(tilemap.get_used_cells(6)) - 1)
		var enemyTemp = enemy.instantiate()
		var local_pos = tilemap.map_to_local(tilemap.get_used_cells(6)[num])
		enemyTemp.position = local_pos
		get_tree().root.add_child(enemyTemp)
