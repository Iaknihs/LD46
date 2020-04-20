extends TileMap


onready var exit_button_0 = $exit_button_0
onready var exit_button_1 = $exit_button_1
onready var exit_button_2 = $exit_button_2
onready var exit_button_3 = $exit_button_3
onready var exit = $exit

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if exit_button_0.is_pressed and exit_button_1.is_pressed and exit_button_2.is_pressed \
			and exit_button_3.is_pressed and exit.get_overlapping_bodies():
		get_tree().change_scene("res://scenes/level3.tscn")
