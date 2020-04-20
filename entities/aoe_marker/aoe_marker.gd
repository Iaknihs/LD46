extends Sprite

onready var corpse_coll = $corpse_collider
onready var call_coll = $call_collider

func use_skill(skill):
	if skill == 1:
		var lvl = get_tree().get_current_scene().get_name()
		if lvl != "level5":
			# raise the dead
			var bodies = corpse_coll.get_overlapping_bodies()
			for body in bodies:
				body.raise()
			# spawn particle effect
			var effect = preload("res://effects/necromancy_effect.tscn").instance()
			effect.global_position = global_position
			get_tree().get_root().add_child(effect)
			
			match lvl:
				"level1":
					Audio._play_sound(Audio.sounds.stage_1)
				"level2":
					Audio._play_sound(Audio.sounds.stage_2)
				"level3":
					Audio._play_sound(Audio.sounds.stage_3)
				"level4":
					Audio._play_sound(Audio.sounds.stage_4)
		else:
			Audio._play_sound(Audio.sounds.stage_5)
		
	elif skill == 2:
		if get_tree().get_current_scene().get_name() != "level5":
			# call the undead
			var bodies = call_coll.get_overlapping_bodies()
			for body in bodies:
				body.call(global_position)
			var effect = preload("res://effects/call_effect.tscn").instance()
			effect.global_position = global_position
			get_tree().get_root().add_child(effect)
			Audio._play_sound(Audio.sounds.call)
