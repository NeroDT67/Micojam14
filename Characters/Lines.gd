extends Node2D


var Drawing : bool = true
var drawMoveLine : bool = false

@onready var MoveLine : Line2D = $MoveLine


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(_delta):
	
	if Input.is_action_pressed("MouseLeft"):
		if drawMoveLine:
			MoveLine.add_point(get_local_mouse_position())

	if Input.is_action_just_released("MouseLeft"):
		if drawMoveLine:
			MoveLine.add_point(get_local_mouse_position())
			drawMoveLine = false


func DrawMoveLine():
	MoveLine.clear_points()
	MoveLine.add_point(position)
	drawMoveLine = true
	MoveLine.visible = true
