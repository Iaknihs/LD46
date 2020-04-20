extends KinematicBody2D

const AOE_RANGE = 100

const MAX_HP = 50
var hitpoints = 50

var MAX_SPEED = 100
var ACCELERATION = 2000
var motion = Vector2.ZERO

onready var aoe_marker = $aoe_marker
onready var hp_bar = $hp_bar
onready var sprite_anim = $sprite_anim
onready var pit_collider = $pit_collider

onready var call_timer = $ui_canvas/call_timer
onready var revive_timer = $ui_canvas/revive_timer

func _ready():
	hp_bar.init(0, MAX_HP, hitpoints)
	pass


func _input(event):
	if event.is_action_pressed("skill_1"):
		if revive_timer.get_remaining_time() == 0:
			aoe_marker.use_skill(1)
			revive_timer._on_skill_used()
	if event.is_action_pressed("skill_2"):
		if call_timer.get_remaining_time() == 0:
			aoe_marker.use_skill(2)
			call_timer._on_skill_used()


func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
		sprite_anim.play("idle")
	else:
		apply_movement(axis * ACCELERATION * delta)
		sprite_anim.play("walk")
	motion = move_and_slide(motion)
	
	var target = global_position + (get_global_mouse_position() \
			- global_position).clamped(AOE_RANGE)
			
	var space_state = get_world_2d().direct_space_state
	var collision = space_state.intersect_ray(global_position, 
				target, [self], 1)
	
	if collision:
		aoe_marker.global_position = collision.position
	else:
		aoe_marker.global_position = target
			

func _on_damaged(damage):
	if hitpoints == 0:
		die()
	else:
		hitpoints = max(0, hitpoints-damage)
		hp_bar.hitpoints_changed(hitpoints)

func die():
	get_tree().change_scene("res://menus/death_scene.tscn")

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("mv_right")) \
			- int(Input.is_action_pressed("mv_left"))
	axis.y = int(Input.is_action_pressed("mv_down")) \
			- int(Input.is_action_pressed("mv_up"))
	return axis

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
	if abs(motion.x) < 0.01:
		motion.x = 0
	if abs(motion.y) < 0.01:
		motion.y = 0
	
	if motion.x > 0:
		sprite_anim.scale.x = 1
	elif motion.x != 0:
		sprite_anim.scale.x = -1


func _on_pit_collider_body_entered(body):
	die()
