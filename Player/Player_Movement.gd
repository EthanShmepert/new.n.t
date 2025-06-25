extends CharacterBody2D

const maxSpeed = 500
const accelRate = 800
const deccelRate = 1000
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
var isJumping = false

var canWalk = true
var isWalking = false

var dashCount = 1
var isDashing = false
var dashLeft = 0 #variable to track dash distance measured in ms
var dashDir = Vector2(0, 0) #direction dash was started in
const dashTime = .2 #time dash takes
const dashVelocity = 1000


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func calculateYVelocity(delta: float) -> void:
	if not is_on_floor():	
		
		if velocity.y < 0:
			#hangtimeCoeffecient curves the jump velocity
			#making gravity slow down near the peak of the jump
			#does so by equaling one immediately after jump
			#and approaching zero as you reach the peak			
			hangtimeCoeffecient = 1 - velocity.y / jumpPower
			
			#if holding jump for longer add multiplier to jump
			if Input.is_action_pressed("ui_accept"):
				gravityCoeffecient = 1
			else:
				gravityCoeffecient = 1.75
				
			velocity.y += (gravity * delta) * hangtimeCoeffecient * gravityCoeffecient
				
		else:
			#if not jumping / have upward momentum
			#apply regular gravity
			#keep the multiplier >= 1.75 for smoother transition
			velocity.y += gravity * 1.75 * delta		
			
	else:
		if dashCount == 0:
			dashCount = 1
		if isJumping:
			isJumping = false
		if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
			isJumping = true
			velocity.y -= jumpPower

func calculateHorizontalVelocity(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept") and velocity.y > -(jumpPower - 50):
		if dashCount > 0:
			dashLeft = dashTime 
			
			var xDirection = Input.get_axis("ui_left", "ui_right")
			var yDirection = Input.get_axis("ui_up", "ui_down")
			
			if xDirection == 0:
				xDirection = prevDir
			dashDir = Vector2(xDirection, yDirection)
			dashCount -= 1
		
	if dashLeft > 0:
		dashLeft -= delta
		
		velocity = dashDir * dashVelocity
		
		if(dashLeft <= 0):
			if velocity.y != 0:
				velocity.y = 0
	
	else:
		var xDirection = Input.get_axis("ui_left", "ui_right")
		
		#velocity if moving on ground
		if xDirection != 0:
			#if changing directions in the air do it immediately
			if prevDir != 0 and prevDir != xDirection:
				if not is_on_floor():
					velocity.x *= -1
					
				else:
					velocity.x += xDirection * pivotOnGroundSpeed
			velocity.x += xDirection * accelRate
				
		else:
			var absSpeed = absf(velocity.x)
			absSpeed = clamp(absSpeed - deccelRate, 0, absSpeed)
			
			velocity.x = absSpeed * sign(velocity.x)
			
			
		velocity.x = clampf(velocity.x, -maxSpeed, maxSpeed)
		prevDir = xDirection
		
	

func _physics_process(delta: float) -> void:
	if canJump: 
		calculateYVelocity(delta)
	if canWalk:
		calculateHorizontalVelocity(delta)
			
	move_and_slide()
	
