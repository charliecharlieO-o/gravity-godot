extends StaticBody2D


export var G: float = 0.4
export var mass: float = 1
export var volume: float = 1


func _ready():
	$Matter.scale = Vector2.ONE * volume
	$GravField/CollisionShape2D/.scale = Vector2.ONE * (mass * 10)

func attract(mover):
	# Distance between this and the object we want to pull
	var force: Vector2 = self.position - mover.position
	var distance: float = force.length()
	# Constraint distance
	distance = distance if distance > 5 else 5
	# We only want the right direction we will scale after
	force = force.normalized()
	# Gravity formula
	var strength: float = (G * mass * mover.mass) / (distance * distance)
	force = force * strength
	return force

func _physics_process(delta):
	var bodies = $GravField.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("_applyForce"):
			body._applyForce(self.attract(body))
