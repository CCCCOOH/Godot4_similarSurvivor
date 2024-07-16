extends CharacterBody2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dir = null
var speed = 30
var target = null
var hp:int = 1
var main_score_label:Label = null
func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")	
	main_score_label = get_tree().get_first_node_in_group("main_score_label")
func _process(delta: float) -> void:
	if target and GlobalManager.run:
		dir = (target.global_position - self.global_position).normalized()
		velocity = dir * speed
		move_and_slide()
	if hp <= 0:
		self.kill()
		
		

func kill():
	animation_player.play("hurt")
	
func add_kill():
	GlobalManager.add_kill(1)
func set_text():
	main_score_label.text = "Score:" + str(GlobalManager.killCount)
