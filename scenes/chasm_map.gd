extends TileMap


onready var pressure_button = $pressure_button
onready var exit_button_1 = $exit_button_1
onready var exit_button_2 = $exit_button_2
onready var exit_button_3 = $exit_button_3
onready var exit = $exit

var active = false

func _process(delta):
	if !active:
		if pressure_button.is_pressed:
			set_cell(12, 5, get_cell(12, 5)-9)
			set_cell(13, 5, get_cell(13, 5)-9)
			set_cell(14, 5, get_cell(14, 5)-9)
			set_cell(15, 5, get_cell(15, 5)-9)
			active = true
	else:
		if !pressure_button.is_pressed:
			set_cell(12, 5, get_cell(12, 5)+9)
			set_cell(13, 5, get_cell(13, 5)+9)
			set_cell(14, 5, get_cell(14, 5)+9)
			set_cell(15, 5, get_cell(15, 5)+9)
			active = false
	
	if exit_button_1.is_pressed and exit_button_2.is_pressed \
			and exit_button_3.is_pressed and exit.get_overlapping_bodies():
		get_tree().change_scene("res://scenes/level2.tscn")
