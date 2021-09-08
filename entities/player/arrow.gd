extends RigidBody2D

const LIFETIME: float = 10.0
var lifetime_counter: float = 0.0

var speed: float = 1000.0

var initial_rotation: float = 0.0

var damage: float = 2.0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$Area2D.connect("body_entered", self, "_on_body_entered")
	
	global_rotation = initial_rotation
	apply_central_impulse(Vector2(speed, 0.0).rotated(initial_rotation))

func _physics_process(delta: float) -> void:
	lifetime_counter += delta
	if lifetime_counter > LIFETIME:
		queue_free()
		return
	
	global_rotation = atan2(linear_velocity.y, linear_velocity.x)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(GameManager.ENEMY_GROUP):
		queue_free()
		body.receive_damage(damage)
	elif body.is_in_group(GameManager.FLOOR_GROUP):
		queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


