extends CharacterBody2D


const SPEED = 600.0


func start(_position, _direction):
	
	position = _position
	velocity = _direction * SPEED

func _physics_process(_delta):
	

	var collision = move_and_collide(velocity * _delta)

	if collision:
		pass

		

	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
