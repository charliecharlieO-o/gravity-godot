extends KinematicBody2D


export var mass: float = 1
var velocity: Vector2
var acceleration: Vector2

func _ready():
	# Set initial velocity and acceleration
	velocity = Vector2(0, 0)
	acceleration = Vector2(0, 0)

func _applyForce(force: Vector2):
	# Newton's law: Net Force equals mass times acceleration.
	# Receive a force, divide by mass and add to acceleration
	var f := force/mass
	# force accumulation
	acceleration = acceleration + f

func _updateForces():
	# Motion 101
	velocity = velocity + acceleration
	# clear acceleration
	acceleration = Vector2.ZERO

func _physics_process(delta):
	# Try to make an orbit
	if velocity.y != 0:
		var perp = velocity.x / velocity.y
		var pForce = Vector2(velocity.x, perp)
		pForce = pForce.normalized()
		_applyForce(pForce * 0.001)
	_updateForces()
	move_and_collide(velocity)
