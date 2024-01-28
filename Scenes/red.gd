extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0

var	player_is_talking = false
var is_on_floor = true
const GRAVITY = 1.5
const JUMP_STRENGTH = 20
var z_position = 0
var z_velocity = 0

const OBSTACLE_LAYER = 1
const OBSTACLE_MASK = 1
const CHARACTER_LAYER = 2
const CHARACTER_MASK = 2
@onready var sprite_2d = %AnimatedSprite2D
var surface_height = 0
var colliding_surfaces = []

var input = Vector2.ZERO

func get_input():
	if input.y == 0:
		input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if input.x == 0:
		input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

func _physics_process(delta):
	## Add the gravity.
	if player_is_talking:
		return
	input = get_input()
	if Input.is_action_just_pressed("jump") and is_on_floor == true:
		z_velocity += JUMP_STRENGTH
	z_velocity -= GRAVITY
	z_position += z_velocity
	if surface_height != 0 && z_position <= surface_height:
		z_position = surface_height
		z_velocity = 0
	if z_position <= 0:
		z_position = 0
		z_velocity = 0
		is_on_floor = true
	else:
		is_on_floor = false
	var offset = Vector2(0, -z_position)
	$AnimatedSprite2D.position = offset
	if z_position == surface_height:
		is_on_floor = true
	if not is_on_floor or surface_height != 0:
		collision_layer = CHARACTER_LAYER
		collision_mask = CHARACTER_LAYER
	else:
		collision_layer = OBSTACLE_LAYER
		collision_mask = OBSTACLE_MASK
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
	if input.x > 0:
		sprite_2d.animation = "right"
	elif Input.is_action_just_released("right"):
		sprite_2d.animation = "idle_right"
	if input.x < 0:
		sprite_2d.animation = "left"
	elif Input.is_action_just_released("left"):
		sprite_2d.animation = "idle_left"
	if input.y < 0:
		sprite_2d.animation = "up"
	elif Input.is_action_just_released("up"):
		sprite_2d.animation = "idle_up"
	if input.y > 0:
		sprite_2d.animation = "down"
	elif Input.is_action_just_released("down"):
		sprite_2d.animation = "idle_down"
	
	move_and_slide()

func calculate_max_height():
	var max_height = 0
	for surface in colliding_surfaces:
		if surface.get_meta("Height") > max_height:
			max_height = surface.get_meta("Height")
	return max_height

func _on_area_2d_mainchar_area_entered(area):
	var overl_bodies = area.get_overlapping_bodies()
	var	overl_body
	if overl_bodies.size() > 0:
		overl_body = overl_bodies.front()
	if (overl_body.has_method("init_dial")):
		sprite_2d.animation = "idle_down"
		player_is_talking = true
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		overl_body.init_dial()
	if area.is_in_group("surface"):
		colliding_surfaces.append(area)
		surface_height = calculate_max_height()

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	player_is_talking = false

func _on_area_2d_mainchar_area_exited(area):
	if area.is_in_group("surface"):
		colliding_surfaces.erase(area)
		surface_height = calculate_max_height()
