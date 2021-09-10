extends Node2D

const ENEMY_FOLDER: String = "res://entities/enemies/"

export var player_path: NodePath
export var arrows_path: NodePath
export var enemies_path: NodePath
export var enemy_spawn_path: NodePath
export var spawn_timer_path: NodePath
export var spawn_delay_timer_path: NodePath
export var damage_numbers_path: NodePath

onready var player: Node2D = get_node(player_path)
onready var arrows: Node2D = get_node(arrows_path)
onready var enemies: Node2D = get_node(enemies_path)
onready var enemy_spawn: Node2D = get_node(enemy_spawn_path)
onready var spawn_timer: Timer = get_node(spawn_timer_path)
onready var spawn_delay_timer: Timer = get_node(spawn_delay_timer_path)
onready var damage_numbers: Node2D = get_node(damage_numbers_path)

var data: CombatScreenData

export var spawn_rates: Dictionary = {
	"slow": 2.0,
	"normal": 1.0,
	"fast": 0.5,
	"instant": 0.01
}

var spawn_rate: float
var spawn_type: String
var enemy_data: Dictionary
var enemy_list: Array # Generated from enemy_data keys
var enemy_paths: Dictionary = {} # Enemy name to file path

var rng: RandomNumberGenerator

var is_batched := false
export var max_batch_spawn: int = 5
var spawn_count: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	enemies.global_position = enemy_spawn.global_position

	player.arrows_node = arrows
	player.damage_numbers_node = damage_numbers

	spawn_rate = spawn_rates[data.spawn_rate]
	spawn_type = data.spawn_type
	enemy_data = data.enemies
	enemy_list = enemy_data.keys()

	# Dynamically generate a list of all enemy tscn paths
	var dir := Directory.new()
	if dir.open(ENEMY_FOLDER) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			var trimmed_name: String = file_name.get_file().get_basename()
			if not "base_enemy" in trimmed_name:
				enemy_paths[trimmed_name] = "%s%s" % [ENEMY_FOLDER, file_name]
			file_name = dir.get_next()

	spawn_timer.connect("timeout", self, "_on_spawn_timer")

	if (spawn_type == CombatScreenData.SpawnType.BATCH and
				spawn_rate != CombatScreenData.SpawnRate.INSTANT):
		is_batched = true
		spawn_delay_timer.connect("timeout", self, "_on_spawn_delay_timer")
		spawn_delay_timer.start(spawn_rate)
	else:
		spawn_timer.start(spawn_rate)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_spawn_timer() -> void:
	if is_batched:
		if spawn_count < max_batch_spawn:
			spawn_count += 1
			if _spawn_enemy():
				spawn_timer.start(spawn_rates.instant)
		else:
			spawn_count = 0
			spawn_delay_timer.start(spawn_rate)
	else:
		if _spawn_enemy():
			spawn_timer.start(spawn_rate)

func _on_spawn_delay_timer() -> void:
	spawn_timer.start(spawn_rates.instant)

###############################################################################
# Private functions                                                           #
###############################################################################

func _spawn_blue_snail() -> void:
	# TODO debug
	var blue_snail = load("res://entities/enemies/blue_snail.tscn").instance()
	blue_snail.damage_numbers_node = damage_numbers
	enemies.call_deferred("add_child", blue_snail)
	yield(blue_snail, "ready")
	blue_snail.global_position = enemy_spawn.global_position

func _spawn_enemy() -> bool:
	if enemy_list.size() <= 0:
		return false
	
	var random_enemy_int: int = rng.randi_range(0, enemy_list.size() - 1)
	var enemy_name: String = enemy_list[random_enemy_int]

	enemy_data[enemy_name] -= 1
	if enemy_data[enemy_name] <= 0:
		enemy_list.erase(enemy_name)
	
	var enemy: Node2D = load(enemy_paths[enemy_name]).instance()
	enemy.damage_numbers_node = damage_numbers
	enemy.initial_position = enemy_spawn.global_position

	enemies.call_deferred("add_child", enemy)
	
	return true

###############################################################################
# Public functions                                                            #
###############################################################################


