extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var AnimFlip : bool = false
@export var PonitOne : Vector2
@export var PonitTwo : Vector2
var PonitSwich : bool = true 
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D  # Character's animation sprite


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	var direction
	if PonitSwich:
		direction = clampi(PonitTwo.x - position.x, -1, 1)
	else:
		direction = clampi(PonitOne.x - position.x, -1, 1)
	
	
	
	
	velocity.x = direction * SPEED
	print(PonitTwo.distance_to(position))
	if PonitSwich:
		if PonitTwo.distance_to(position) < 75:
			PonitSwich = false
	else:
		if PonitOne.distance_to(position) < 75:
			PonitSwich = true
			
	
	
	
	
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if velocity.x != 0:
		if velocity.x > 0:
			AnimFlip = false
		else :
			AnimFlip = true
		
		anim.flip_h = AnimFlip
		
		anim.play("run")
	else:
		anim.play("idle")

	if sqrt(velocity.y * velocity.y) > 5:
		anim.play("jump")

	move_and_slide()

func hit(damage :int):
	queue_free()
