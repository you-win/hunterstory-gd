extends Node2D

const ENEMY_FOLDER: String = "res://entities/enemies/"

onready var player: Player = $Player
onready var arrows: Node2D = $Arrows
onready var enemies: Node2D = $Enemies
onready var enemy_spawn: Node2D = $EnemySpawn
onready var spawn_timer: Timer = $SpawnTimer
onready var spawn_delay_timer: Timer = $SpawnDelayTimer
onready var damage_numbers: Node2D = $DamageNumbers
onready var ui_layer: UILayer = $UILayer

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

var done_spawning := false

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	ui_layer.setup_player(player)
	
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
			if (not "base_enemy" in trimmed_name and not file_name.get_extension() == "gd"):
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

func _process(_delta: float) -> void:
	if done_spawning:
		if enemies.get_child_count() == 0:
			# TODO show stats first
			var screen = load("res://screens/level-select-screen/level_select_screen.tscn").instance()
			GameManager.main.change_screen(screen)

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

func _spawn_enemy() -> bool:
	if enemy_list.size() <= 0:
		done_spawning = true
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


