extends KinematicBody2D


const MOVE_SPEED = 25
onready var target = global_position
var moving = false

const MAX_HP = 100
var hitpoints = 30

onready var hp_bar = $hp_bar
onready var attack_collider = $attack_collider
onready var attack_timer = $attack_timer
onready var sprite_anim = $sprite_anim

var attack_target = null

func _ready():
	hp_bar.init(0, MAX_HP, hitpoints)
	sprite_anim.modulate = Color.from_hsv(randf(), randf(), 1.0)

func _on_damaged(damage):
	hitpoints -= damage
	hp_bar.hitpoints_changed(hitpoints)
	if hitpoints <= 0:
		die()

func die():
	var corpse = load("res://entities/corpse/corpse.tscn").instance()
	corpse.position = position
	add_collision_exception_with(corpse)
	get_parent().add_child(corpse)
	queue_free()

func call(pos):
	target = pos
	moving = true
	
func _physics_process(delta):
	if moving:
		var velocity = (target - position).normalized() * MOVE_SPEED
		move_and_slide(velocity)
		if velocity.x > 0:
			sprite_anim.scale.x = 1
		elif velocity.x != 0:
			sprite_anim.scale.x = -1
		if position.distance_to(target) < 1:
			moving = false
	
	# look for enemy to attack
	var bodies = attack_collider.get_overlapping_bodies()
	if bodies:
		attack_target = bodies[0]
		# look_at(attack_target.position)
		if attack_timer.is_stopped() \
				and global_position.distance_to(
					attack_target.global_position) < 20:
			attack_timer.start()
		if !moving:
			moving = true
			target = attack_target.position
			
	else: attack_target = null
	
	if moving:
		sprite_anim.play("walk")
	else:
		sprite_anim.play("idle")


func attack():
	if attack_target != null:
		if attack_target.has_method("_on_damaged"):
			attack_target._on_damaged(1)


func _on_attack_timer_timeout():
	attack()


func _on_pit_collider_body_entered(body):
	die()
