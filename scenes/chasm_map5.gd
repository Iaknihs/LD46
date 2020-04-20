extends TileMap

onready var exit = $exit

func _physics_process(delta):
	if exit.get_overlapping_bodies():
		get_tree().change_scene("res://scenes/end_scene.tscn")
