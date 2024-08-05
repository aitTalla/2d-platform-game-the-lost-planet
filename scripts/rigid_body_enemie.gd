extends Area2D


@onready var path_follow_2d_2 = $".."
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer

@export var speed = 20; 
# Called when the node enters the scene tree for the first time.
func _ready():
	path_follow_2d_2.progress = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow_2d_2.progress += delta * speed
	
	if path_follow_2d_2.progress_ratio < 0.1 && speed < 0:
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		speed = speed * -1;
		
	if path_follow_2d_2.progress_ratio > 0.9:
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		speed = speed * -1;
	

func _on_body_entered(body):
	if body.name != "CharacterBodyPlayer":
		return 0
	animated_sprite_2d.play("attack")
	audio_stream_player.stream = load("res://resource/Audio/bong_001.ogg")
	audio_stream_player.play()
	await audio_stream_player.finished


func _on_body_exited(body):
	await get_tree().create_timer(1).timeout
	animated_sprite_2d.play("default")
