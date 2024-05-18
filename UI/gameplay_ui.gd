extends Control


signal end_turn_pressed
signal move_pressed
signal shoot_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_end_turn_button_pressed():
	emit_signal("end_turn_pressed")


func _on_move_button_up():
	await get_tree().create_timer(0.5).timeout
	emit_signal("move_pressed")


func _on_shoot_button_up():
	await get_tree().create_timer(0.5).timeout
	emit_signal("shoot_pressed")
