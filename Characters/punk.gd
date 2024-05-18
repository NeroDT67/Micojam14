extends CharacterBody2D




const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var AnimFlip : bool = false
var moving : bool = false

@onready var MoveLine : Line2D = $Lines/MoveLine
var MoveLineIndex : int = 0
var delay : int = 0

var targetPosition : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var anim : AnimatedSprite2D = $AnimatedSprite2D


	 

func _physics_process(delta):
	
	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	

	if moving and MoveLine.points.size() > MoveLineIndex+1:
		
		var direction = clampi( targetPosition.x - position.x, -1, 1)
		#print_debug(direction)
		velocity.x = direction * SPEED
		
		if (position.x - targetPosition.x) < 1 and (position.x - targetPosition.x) > -1:
			MoveLineIndex += 1
			calcutateTargetPosition()
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		


	# animations
	
	if velocity.x != 0:
		if velocity.x > 0:
			AnimFlip = false
		else :
			AnimFlip = true
		
		anim.flip_h = AnimFlip
		
		anim.play("Run")

	if sqrt(velocity.y * velocity.y) > 5:
		anim.play("Jump")
	
	if velocity.x == 0:
		anim.play("Idle")

	
	move_and_slide()




func startMoving():
	#MoveLine.visible = false
	MoveLineIndex = 0
	calcutateTargetPosition()
	moving = true

	
func calcutateTargetPosition():
	
	targetPosition = position + (MoveLine.points[MoveLineIndex+1] - MoveLine.points[MoveLineIndex])