extends Area2D

var is_pressed = false

func _physics_process(delta):
	if get_overlapping_bodies():
		is_pressed = true
	else:
		is_pressed = false
