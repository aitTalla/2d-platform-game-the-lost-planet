extends Area2D 

@onready var audio_stream_player = $AudioStreamPlayer
@onready var cpu_particles_2d = $CPUParticles2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name != "CharacterBodyPlayer":
		return 0
	body.add_coin()
	if animated_sprite_2d != null:
		animated_sprite_2d.queue_free()
	
	cpu_particles_2d.emitting = true;
	audio_stream_player.play()
	await audio_stream_player.finished
	get_node(".").queue_free();
