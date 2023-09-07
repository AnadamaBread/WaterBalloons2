extends CharacterBody2D


@export var speed = 200
@export var flight = false
@export var flight_speed = 100

@export var jump_height : float  
@export var jump_time_peak : float 
@export var jump_time_descent : float 

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height ) / (jump_time_peak * jump_time_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_descent * jump_time_descent)) * -1.0

# Left and right movement helper function
func get_input_movement() -> float:
	var horizontal = 0.0
	if Input.is_action_pressed("Left"):
		horizontal -= 1.0
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("Right"):
		horizontal += 1.0
		$Sprite2D.flip_h = false
		
	return horizontal

# Gravity helper function
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
# Jump action
func do_jump():
	velocity.y = jump_velocity

# Main physics action function
func _physics_process(delta):
	velocity.x = get_input_movement() * speed
	velocity.y += get_gravity() * delta
	if Input.is_action_just_pressed("Space"):
		do_jump()
	move_and_slide()
