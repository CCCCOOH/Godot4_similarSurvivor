extends Node2D

var weapon_radius:int = 30
var weapon_num = 1
@onready var weapon1 = preload("res://scenes/weapon_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_num = self.get_child_count()
	var unit = TAU / weapon_num	# 单位O周长 / 数量 -> 得到每个单位O分到的周长 = 单位O的弧度
	var weapon_list = self.get_children()
	var i:int = 0
	for weapon in weapon_list:
		var weapon_rad = unit * i
		var weapon_position = Vector2(weapon_radius, 0).rotated(weapon_rad)
		weapon.position = weapon_position
		i += 1
	
	
func _process(delta: float) -> void:
	if GlobalManager.weapon_count > self.get_child_count():
		weapon_radius += 1
		var new_weapon = weapon1.instantiate()
		new_weapon.position = Vector2.ZERO
		get_tree().get_first_node_in_group("player_weapons").add_child(new_weapon)
		weapon_num = self.get_child_count()
		var unit = TAU / weapon_num	# 单位O周长 / 数量 -> 得到每个单位O分到的周长 = 单位O的弧度
		var weapon_list = self.get_children()
		var i:int = 0
		for weapon in weapon_list:
			var weapon_rad = unit * i
			var weapon_position = Vector2(weapon_radius, 0).rotated(weapon_rad)
			weapon.position = weapon_position
			i += 1 
	
