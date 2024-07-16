class_name Player extends CharacterBody2D


const SPEED = 150.0
@onready var animated_sprite_2d = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = false 
var stop_move: bool = false
@onready var player_weapons: Node2D = $PlayerWeapons


func _ready():
	choose_player("player1")
func _physics_process(delta):
	# 获取按键输入向量
	# var transition: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

	# 获取鼠标位置
	var mouse_pos: Vector2 = get_global_mouse_position()
	var self_pos: Vector2 = position
	var move_direction: Vector2 = (mouse_pos - self_pos).normalized()
	
	# 更新位置
	if can_move and not stop_move:
		position += move_direction * delta * SPEED


	# 更改图像方向
	var flip: bool = false
	if move_direction[0] < 0:
		flip = true
	elif move_direction[0] > 0:
		flip = false
	
	animated_sprite_2d.flip_h = flip
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event:InputEventMouseButton = event
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_pressed():
			can_move = true
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and !mouse_event.is_pressed():
			can_move = false


func _on_area_2d_mouse_entered():
	stop_move = true

func _on_area_2d_mouse_exited():
	stop_move = false
	
func choose_player(type:String):
	animated_sprite_2d.sprite_frames.clear_all()
	var player_path:String = "res://sprites/"
	var sprite_frame_custom = SpriteFrames.new()
	# sprite_frame_custom.add_animation("default")
	sprite_frame_custom.set_animation_loop("default", true)
	var texture_size = Vector2(96, 24)
	var sprite_size = Vector2(24, 24)
	var full_texture: Texture = load(player_path + type + "/" + type +  ".png")
	var column_num:int = int(texture_size.x / sprite_size.x)
	var row_num:int = int(texture_size.y / sprite_size.y)
	for x in range(column_num):
		for y in range(row_num):
			var frame = AtlasTexture.new()
			frame.atlas = full_texture
			frame.region = Rect2(Vector2(x, y) * sprite_size, sprite_size)
			sprite_frame_custom.add_frame("default", frame)
	animated_sprite_2d.sprite_frames = sprite_frame_custom
	animated_sprite_2d.play("default")


func _on_choose_player_button_pressed():
	choose_player("player2")


func _on_choose_player_1_button_2_pressed():
	choose_player("player1")
