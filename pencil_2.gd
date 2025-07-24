extends CharacterBody2D

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.LEFT

func _ready():
	velocity = direction.normalized() * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		on_hit(collision)

func on_hit(collision: KinematicCollision2D):
	var collider = collision.get_collider()
	if collider.is_in_group("enemies"):
		# Call a damage method if available
		if collider.has_method("take_damage"):
			collider.take_damage()
	queue_free()
