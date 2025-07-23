extends CharacterBody2D

class_name mainPlayer

const maxSpeed = 500
const accelRate = 75
const deccelRate = 60
#allows us to check if player wants to pivot
#add a boost so you don't lose all momentum
var prevDir = 0 
var pivotOnGroundSpeed = 600

const jumpPower = 800.0 #initial jump height
var hangtimeCoeffecient #curves jump to add hang time
var gravityCoeffecient #apply regular gravity or curbed for extended jump

#for all movement added variables so we can freeze movement
#if necessary in tutorial

var canJump = true
var jumpsLeft = 2
var maxJumps = jumpsLeft
var isJumping = false
var coyoteTime = .2

var canWalk = true
var isWalking = false

var spawnpoints

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	var spawnpoints = get_tree().get_nodes_in_group("spawnpoint")

func calculateYVelocity(delta: float) -> void:
	if not is_on_floor():	
		coyoteTime -= delta
		
		if velocity.y < 0: #is velocity moving upward
			#hangtimeCoeffecient curves the jump velocity
			#making gravity slow down near the peak of the jump
			#does so by equaling one immediately after jump
			#and approaching zero as you reach the peak			
			hangtimeCoeffecient = 1 - velocity.y / jumpPower
			
			#if holding jump for longer add multiplier to jump
			if Input.is_action_pressed("ui_accept"):
				gravityCoeffecient = 1.1
			else:
				gravityCoeffecient = 1.75
				
			velocity.y += (gravity * delta) * hangtimeCoeffecient * gravityCoeffecient
				
		else:
			#if not jumping / have upward momentum
			#apply regular gravity
			#keep the multiplier >= 1.75 for smoother transition
			velocity.y += gravity * 1.75 * delta		
			
	else:
		if isJumping:
			isJumping = false
		coyoteTime = .3
		jumpsLeft = 2
			
	if Input.is_action_just_pressed("ui_accept") and determineIfCanJump():
		isJumping = true
		coyoteTime = 0
		jumpsLeft -= 1
		velocity.y -= jumpPower

func determineIfCanJump() -> bool:
	if coyoteTime > 0 and jumpsLeft == 2:
		return true
	if jumpsLeft > 0:
		return true
	return false
	
func calculateHorizontalVelocity(delta: float) -> void:			
	if canWalk:
		var xDirection = Input.get_axis("ui_left", "ui_right")
		
		#velocity if moving on ground
		if xDirection != 0:
			#if changing directions in the air do it immediately
			if prevDir != 0 and prevDir != xDirection:
				if not is_on_floor():
					velocity.x *= -1
					
				else:
					velocity.x += xDirection * pivotOnGroundSpeed
			velocity.x = clampf(velocity.x + xDirection * accelRate, -maxSpeed, maxSpeed)
				
		else:
			var absSpeed = absf(velocity.x)
			absSpeed = clamp(absSpeed - deccelRate, 0, absSpeed)
			
			velocity.x = absSpeed * sign(velocity.x)
			
			
		prevDir = xDirection
		
	

func _process(delta: float) -> void:
	if canJump: 
		calculateYVelocity(delta)
	if canWalk:
		calculateHorizontalVelocity(delta)
	
	if is_on_floor() and velocity.x != 0:
		$Sprite2D/AnimationPlayer.play("Walk")
	if Input.is_action_just_pressed("ui_accept"):
		$Sprite2D/AnimationPlayer.play("Jump")
		
	if position.y > 800:
		position = get_parent().get_parent().get_node("spawnpoint").global_position
	move_and_slide()
	
