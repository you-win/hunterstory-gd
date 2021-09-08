extends KinematicBody2D

const DamageNumber: PackedScene = preload("res://entities/damage_number.tscn")

const GRAVITY: float = 198.0

const Anim: Dictionary = {
	"MOVE": "Move",
	"HURT": "Hurt",
	"KILLED": "Killed"
}

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var collision_extents: Vector2 = collision_shape.shape.extents

export var health: float = 10.0
export var speed: float = 50.0

var knockback: float = 0.0

var damage_numbers_node: Node2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	add_to_group(GameManager.ENEMY_GROUP)
	
	anim_player.connect("animation_finished", self, "_on_animation_finished")
	anim_player.play(Anim.MOVE)

func _physics_process(_delta: float) -> void:
	if health > 0.0:
		if anim_player.current_animation != Anim.HURT:
			move_and_slide(Vector2(-speed, GRAVITY))
		else:
			move_and_slide(Vector2(knockback, GRAVITY))
	elif health <= 0.0 and anim_player.current_animation != Anim.KILLED:
		anim_player.play(Anim.KILLED)
		$CollisionShape2D.set_deferred("disabled", true)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == Anim.HURT:
		anim_player.play(Anim.MOVE)
	elif anim_name == Anim.KILLED:
		queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func receive_damage(damage: float, data: Dictionary = {}) -> void:
	var rounded_damage: int = int(round(damage))
	health -= rounded_damage
	
	if not data.empty():
		for data_key in data.keys():
			match data_key:
				"knockback":
					knockback = data[data_key]
	
	var dmg_num: Label = DamageNumber.instance()
	dmg_num.text = str(rounded_damage)
	dmg_num.rect_global_position = global_position - (dmg_num.rect_size / 2) - Vector2(0.0, collision_extents.y)
	damage_numbers_node.call_deferred("add_child", dmg_num)
	
	if anim_player.current_animation == Anim.HURT:
		anim_player.seek(0)
	else:
		anim_player.play(Anim.HURT)
