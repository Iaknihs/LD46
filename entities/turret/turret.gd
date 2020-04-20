extends StaticBody2D

const ROTATION_SPEED = 0.03

onready var hp_bar = $hp_bar
onready var target_coll = $target_collider
onready var shoot_timer = $shoot_timer
onready var tween = $tween

const MAX_HP = 30
var hitpoints = 30

var shoot_target

func _ready():
	hp_bar.init(0, MAX_HP, hitpoints)


func _physics_process(delta):
	var bodies = target_coll.get_overlapping_bodies()
	if bodies:
		var nearest
		var n_dist
		for body in bodies:
			var dist = position.distance_to(body.position)
			if n_dist == null or dist < n_dist:
				nearest = body
				n_dist = dist
		
		shoot_target = weakref(nearest)
		
		if shoot_timer.is_stopped():
			shoot_timer.start()
			shoot()


func shoot():
	if shoot_target.get_ref():
		var target_object = shoot_target.get_ref()
		var bullet = preload("res://entities/bullet/bullet.tscn").instance()
		bullet.position = position
		bullet.velocity = global_position.direction_to(
			target_object.global_position) * 400
		get_parent().add_child(bullet)


func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference


func _on_damaged(damage):
	hitpoints -= damage
	hp_bar.hitpoints_changed(hitpoints)
	if hitpoints <= 0:
		queue_free()

