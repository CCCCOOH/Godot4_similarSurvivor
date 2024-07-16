extends Control
@onready var score_label: Label = $ScoreLabel

func set_over_score(score:int):
	score_label.text = "YourScore:" + str(score)


func _on_restart_pressed() -> void:
	reset()
	get_tree().reload_current_scene()
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_to_title_pressed() -> void:
	reset()
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	
func reset():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
	Engine.time_scale = 1
	GlobalManager.killCount = 0
	GlobalManager.enemyGenerationSpeed = 1
	GlobalManager.run = true
	GlobalManager.weapon_count = 1
