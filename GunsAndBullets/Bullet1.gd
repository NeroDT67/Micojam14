extends CharacterBody2D


const SPEED = 600.0
const Damage = 5

func start(_position, _direction):
	
	position = _position
	velocity = _direction * SPEED

func _physics_process(_delta):
	

	var collision = move_and_collide(velocity * _delta)

	if collision:
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit(Damage)
		queue_free()

		

	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
