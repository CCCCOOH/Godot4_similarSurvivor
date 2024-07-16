extends Node2D

@onready var time_label: Label = $CanvasLayer/TimeLabel
@onready var tile_map = $TileMap
@onready var player: Player = $Player
@onready var price_weapon = preload("res://scenes/price_weapon.tscn")
@onready var game_left_time: Timer = $GameLeftTime
@onready var game_over_screen: Control = $CanvasLayer/GameOverScreen
@onready var music: AudioStreamPlayer2D = $Music



var kill_num:int = 0

func _ready():
	music.play()
	reset_scene()
	game_left_time.start()
	# tile_map = get_tree().get_first_node_in_group("map")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalManager.killCount in GlobalManager.priceLevel:
		var ran = RandomNumberGenerator.new()
		var tile_map_len = len(tile_map.get_used_cells(6)) - 1
		var num = ran.randi_range(0, tile_map_len)
		var tile_map_pos = tile_map.get_used_cells(6)[num]
		var local_pos = tile_map.map_to_local(tile_map_pos)
		var new_price_box = price_weapon.instantiate()
		new_price_box.position = local_pos
		self.add_child(new_price_box)
		GlobalManager.killCount += 1	
	time_label.text = "剩余时间:" + str(int(game_left_time.time_left))

func reset_scene():
	tile_map.clear_layer(0)
	var generate_cells = tile_map.get_used_cells(1)
	var ran = RandomNumberGenerator.new()
	for cell_pos in generate_cells:
		var num = ran.randi_range(0, 100)
		if num <= 5:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(0, 5))
		elif num <= 10:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(0, 6))
		elif num <= 15:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(1, 5))
		elif num <= 20:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(1, 6))
		elif num <= 22:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(2, 5))
		elif num <= 24:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(2, 6))
		elif num <= 26:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(3, 5))
		elif num <= 28:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(3, 6))
		elif num <= 30:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(4, 5))
		elif num <= 32:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(4, 6))
		elif num <= 34:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(5, 5))
		elif num <= 36:
			tile_map.set_cell(0, cell_pos, 0, Vector2i(5, 6))
	
func _on_button_pressed():
	print("click!")
	reset_scene()

func _on_add_weapon_pressed() -> void:
	print("click")
	player.add_weapon1()



func _on_game_over_pressed() -> void:
	_on_game_left_time_timeout()	


func _on_game_left_time_timeout() -> void:
	game_over_screen.visible = true
	game_over_screen.set_over_score(GlobalManager.killCount)
	GlobalManager.run = false
	Engine.time_scale = 0



func _on_back_pressed() -> void:
	game_over_screen.reset()
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
