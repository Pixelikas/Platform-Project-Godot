extends Area2D

onready var collectSfx = $collectibleSound

func _on_Area2D_body_entered(body):
	
	if body.name == "RigidBody2D":
		collectSfx.play()
		$delaysound.start()

func _on_delaysound_timeout():
	queue_free()
