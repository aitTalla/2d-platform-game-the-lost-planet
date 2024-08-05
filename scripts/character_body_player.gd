extends CharacterBody2D

@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var ui_player = $"../Control/ui_Player"

@export var streamsWalk = [];
@export var streamsjumps = [];

var healthPlayer = 5
var coins = 0
var direction = 0;

const SPEED = 80.0
const JUMP_VELOCITY = -380.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	audio_stream_player.stop();
		
func _physics_process(delta):
	# Add the gravity.300
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite_2d.play("jump")
	
	var direction = Input.get_axis("movLeft", "movRight")
	if direction:
		velocity.x = direction * SPEED
		if direction < 1:
			animated_sprite_2d.flip_h = true;
		else:
			animated_sprite_2d.flip_h = false;
	else:
		velocity.x = move_toward(velocity.x, 0,12)
	
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump();
	
	if(velocity.x > 0 || velocity.x < 0):
		if is_on_floor():
			animated_sprite_2d.play("run")
			if !audio_stream_player.playing:
				audio_stream_player.stream = load("res://resource/Audio/player/walk/"+streamsWalk[randi_range(0,len(streamsWalk)-1)])
				audio_stream_player.play()
			cpu_particles_2d.emitting = true;
	else:
		if is_on_floor():
			animated_sprite_2d.play("idel")
		cpu_particles_2d.emitting = false;
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()

	
func jump():
	if is_on_floor():
		audio_stream_player.stop()
		audio_stream_player.stream = load("res://resource/Audio/player/jump/"+streamsjumps[randi_range(0,len(streamsjumps)-1)])
		audio_stream_player.play()
		velocity.y = JUMP_VELOCITY

func damage(numDamage):
	print("damaging player")
	if(healthPlayer <= 1):
		get_tree().quit()
		
	healthPlayer -= numDamage
	ui_player.setHealth(coins);
	
	
func add_coin():
	print("add new coin")
	coins += 1;
	ui_player.setCoins(coins);
