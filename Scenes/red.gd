extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0

var is_on_floor = true
const GRAVITY = 1.5
const JUMP_STRENGTH = 20
var z_position = 0
var z_velocity = 0

const OBSTACLE_LAYER = 1
const OBSTACLE_MASK = 1
const CHARACTER_LAYER = 2
const CHARACTER_MASK = 2

func _physics_process(delta):
	## Add the gravity.
	if Input.is_action_just_pressed("jump") and is_on_floor == true:
		z_velocity -= JUMP_STRENGTH
	z_velocity += GRAVITY
	z_position += z_velocity
	if z_position >= 0:
		z_position = 0
		z_velocity = 0
		is_on_floor = true
	else:
		is_on_floor = false
	var offset = Vector2(0, z_position)
	$AnimatedSprite2D.position = offset
	if is_on_floor:
		collision_layer = OBSTACLE_LAYER
		collision_mask = OBSTACLE_MASK
	else:
		collision_layer = CHARACTER_LAYER
		collision_mask = CHARACTER_LAYER
	# Handle jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx = Input.get_axis("left", "right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var directiony = Input.get_axis("up", "down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
