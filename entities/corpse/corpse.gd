extends StaticBody2D

var zombie_scene = preload("res://entities/zombie/zombie.tscn")

func raise():
	# spawn zombie, destroy self
	var zombie = zombie_scene.instance()
	get_parent().add_child(zombie)
	zombie.position = position
	add_collision_exception_with(zombie)
	queue_free()
	pass
