extends RigidBody2D

export var speed = 500
export var jump_force = 450

var touch_ground = true

onready var position2D = $Position2D
onready var bullet = preload('res://Scenes/Bullet.tscn')
var sceneB = load("res://Scenes/Bullet.tscn")

onready var jumpSfx = $jumpSound

var playerDirection = 'Right'


func _physics_process(delta):
	move()
	shoot(playerDirection)
	
func shoot(playerDirection):
	if Input.is_action_just_pressed('Shoot'):
		var bullet_instance = bullet.instance()
		
		bullet_instance.init(playerDirection)
		bullet_instance.global_position = $BulletSpawnPoint.global_position
		
		get_parent().add_child(bullet_instance)
	
func move():
	var my_vert_vel = get_linear_velocity().y
	
	if Input.is_key_pressed(KEY_C):
		get_tree().change_scene_to(sceneB)
	
	if Input.is_key_pressed(KEY_RIGHT):
		set_linear_velocity(Vector2(1 * speed, my_vert_vel))
		playerDirection = 'Right'
		$BulletSpawnPoint.position.x = 130
		
	elif Input.is_key_pressed(KEY_LEFT):
		set_linear_velocity(Vector2(-1 * speed, my_vert_vel))
		playerDirection = "Left"
		$BulletSpawnPoint.position.x = 20
	else: 
		set_linear_velocity(Vector2(0, my_vert_vel))
		
	if Input.is_key_pressed(KEY_Z):
		if touch_ground == true:
			apply_impulse(Vector2(), Vector2(0, -1 * jump_force))
			jumpSfx.play()
			
	if playerDirection == 'Left':
		position2D.scale.x = -1
	
	if playerDirection == 'Right':
		position2D.scale.x = 1

func _on_Area2D_body_entered(touched):
	if touched.get_name() == 'Tilemap':
		touch_ground = true

func _on_Area2D_body_exited(touched):
	if touched.get_name() == 'Tilemap':
		touch_ground = false
