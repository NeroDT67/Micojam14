extends CharacterBody2D




const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var AnimFlip : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var anim = $AnimatedSprite2D



func _physics_process(delta):
	
	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	



	# animations
	
	if velocity.x != 0:
		if velocity.x > 0:
			AnimFlip = false
		else :
			AnimFlip = true
		
		anim.flip_v = AnimFlip
		anim.play("Run")

	if sqrt(velocity.y * velocity.y) > 5:
		anim.play("Jump")
	
	if velocity.x == 0:
		anim.play("Idle")

	
	move_and_slide()



