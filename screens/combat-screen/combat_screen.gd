extends Node2D

export var player_path: NodePath
export var arrows_path: NodePath
export var enemies_path: NodePath
export var enemy_spawn_path: NodePath
export var damage_numbers_path: NodePath

onready var player: Node2D = get_node(player_path)
onready var arrows: Node2D = get_node(arrows_path)
onready var enemies: Node2D = get_node(enemies_path)
onready var enemy_spawn: Node2D = get_node(enemy_spawn_path)
onready var damage_numbers: Node2D = get_node(damage_numbers_path)

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	player.arrows_node = arrows
	player.damage_numbers_node = damage_numbers
	
	# TODO debug
	_spawn_enemy()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _spawn_enemy() -> void:
	# TODO debug
	var blue_snail = load("res://entities/enemies/blue_snail.tscn").instance()
	blue_snail.damage_numbers_node = damage_numbers
	enemies.call_deferred("add_child", blue_snail)
	yield(blue_snail, "ready")
	blue_snail.global_position = enemy_spawn.global_position

###############################################################################
# Public functions                                                            #
###############################################################################


