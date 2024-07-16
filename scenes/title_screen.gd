extends Control
@onready var music: AudioStreamPlayer2D = $Music
@onready var main_world = preload("res://scenes/main_world.tscn")
@onready var click: AudioStreamPlayer2D = $click


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()

func _on_quit_pressed() -> void:
	get_tree().quit()
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_world.tscn")
