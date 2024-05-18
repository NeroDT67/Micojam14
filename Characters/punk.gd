extends CharacterBody2D




const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var AnimFlip : bool = false
var moving : bool = false

@onready var MoveLine : Line2D = $Lines/MoveLine
var MoveLineIndex : int = 0
var delay : int = 0

@onready var targetPosition : Vector2 = position
@onready var startPosition : Vector2 = position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var anim : AnimatedSprite2D = $AnimatedSprite2D


	 

func _physics_process(delta):
	
	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	

	if moving :
		
		var direction = clampi(targetPosition.x - position.x, -1, 1)
		
		velocity.x = direction * SPEED
		
		#print("Position")
		#print(position.x)
		#print(position.y)
		#print("target")
		#print(targetPosition.x)
		#print(targetPosition.y)
		
		if (position.x - targetPosition.x) < 5 and (position.x - targetPosition.x) > -5:
			MoveLineIndex += 1
			calcutateTargetPosition()
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	print(targetPosition.y - startPosition.y)
	if is_on_floor() and (targetPosition.y - startPosition.y) < -10 and moving:
		velocity.y = JUMP_VELOCITY

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
	MoveLine.visible = false
	MoveLineIndex = 0
	startPosition = position
	calcutateTargetPosition()
	moving = true

	
func calcutateTargetPosition():
	if MoveLine.points.size() > MoveLineIndex:
		targetPosition = startPosition + MoveLine.points[MoveLineIndex] * 2
	else:
		moving = false
