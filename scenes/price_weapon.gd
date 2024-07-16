extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalManager.weapon_count += 1
	print(GlobalManager.weapon_count)
	GlobalManager.enemyGenerationSpeed += 1
	animation_player.play("pickup")
