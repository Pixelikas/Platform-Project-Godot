extends Sprite

var direction = 'Right'

func init(d):
	direction = d

func _physics_process(delta):
	if direction == 'Right':
		position.x += 15
	else:
		position.x -= 15
	

