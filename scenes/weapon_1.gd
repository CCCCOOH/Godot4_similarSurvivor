extends Node2D

var bullet_shot_time: float = 0.5
var bullet_speed = 1e5
var bullet_hurt = 1
@onready var Bullet = preload("res://scenes/bullet.tscn")
@onready var shoot_pos = $shoot_pos
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var attack_enemies = []

func _process(delta):
	if attack_enemies.size() != 0:
		self.look_at(attack_enemies[0].global_position)
	else:
		rotation_degrees = 0
	
func _on_timer_timeout():
	if attack_enemies.size() > 0:
		audio_stream_player.play()
		var now_bullet = Bullet.instantiate()
		now_bullet.speed = bullet_speed
		now_bullet.hurt = bullet_hurt
		now_bullet.position = shoot_pos.global_position	# 全局位置
		var min_dis = attack_enemies[0].global_position - now_bullet.position
		var min_enemy = attack_enemies[0]
		for enemy in attack_enemies:
			var tem_dis = enemy.global_position - now_bullet.position
			if tem_dis < min_dis:
				min_dis = tem_dis
				min_enemy = enemy
		now_bullet.dir = (min_enemy.global_position - now_bullet.position).normalized()
		get_tree().root.add_child(now_bullet)


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy") and !attack_enemies.has(body):
		attack_enemies.append(body)

func _on_area_2d_body_exited(body):
	if body.is_in_group("enemy") and attack_enemies.has(body):
		attack_enemies.remove_at(attack_enemies.find(body))
