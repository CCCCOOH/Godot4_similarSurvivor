extends Node2D
@onready var marker_2d = $Marker2D
@onready var timer = $Timer
@onready var Bullet = preload("res://scenes/bullet.tscn")
var speed:float = 1e5
var attack_enemies = []
var hurt:int = 1

func _process(delta):
	if attack_enemies.size() != 0:
		self.look_at(attack_enemies[0].global_position)
	else:
		rotation_degrees = 0
func _on_timer_timeout():
	if attack_enemies.size() > 0:
		var now_bullet = Bullet.instantiate()
		now_bullet.speed = speed
		now_bullet.position = marker_2d.global_position
		now_bullet.hurt = hurt
		now_bullet.dir = (attack_enemies[0].global_position - now_bullet.position).normalized()
		get_tree().root.add_child(now_bullet)
		

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy") and !attack_enemies.has(body):
		attack_enemies.append(body)

func _on_area_2d_body_exited(body):
	if body.is_in_group("enemy") and attack_enemies.has(body):
		attack_enemies.remove_at(attack_enemies.find(body))
