extends Area2D


var velocity = Vector2.ZERO
var damage = 10


func _physics_process(delta):
	position += velocity * delta
	
	var bodies = get_overlapping_bodies()
	if bodies:
		for body in get_overlapping_bodies():
			if body.has_method("_on_damaged"):
				body._on_damaged(damage)
		queue_free()


func _on_self_destroy_timer_timeout():
	queue_free()
