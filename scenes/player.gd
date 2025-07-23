class_name Player extends CharacterBody2D
@export var move_speed : float = 100.0

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"

@onready var animation_player = $AnimationPlayer
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	pass

func _process(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	if SetState() == true || SetDirection() == true:
		UpdateAnimation()
	
func _physics_process( delta: ):
	move_and_slide()

func SetDirection() -> bool: 
	var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if direction == cardinal_direction:
		return false
	else: 
		cardinal_direction = new_direction
	
	return true
	
func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

func AnimDirection () -> String:
	if cardinal_direction == Vector2.DOWN:
		return "front"
	elif cardinal_direction == Vector2.UP:
		return "back"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	else:
		return "right"
