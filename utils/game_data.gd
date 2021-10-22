class_name GameData
extends Reference

const EXP_TO_LEVEL_FACTOR: float = 3.0
const STAT_POINTS_ON_LEVEL_UP: int = 4

var coins: int = 0 setget _set_coins
var experience: float = 0.0 setget _set_experience

var level: int = 1

# Stats
var stat_points: int = STAT_POINTS_ON_LEVEL_UP
var strength: int = 4
var dexterity: int = 4
var agility: int = 4
var intelligence: int = 4
var luck: int = 4

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _init() -> void:
	SB.connect("stat_modified", self, "_on_stat_modified")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_stat_modified(stat: String, value: int) -> void:
	if value <= stat_points:
		match stat:
			GameManager.Stats.STRENGTH:
				strength += value
			GameManager.Stats.DEXTERITY:
				dexterity += value
			GameManager.Stats.AGILITY:
				agility += value
			GameManager.Stats.INTELLIGENCE:
				intelligence += value
			GameManager.Stats.LUCK:
				luck += value
		
		_modify_stat_points(-value)

###############################################################################
# Private functions                                                           #
###############################################################################

func _set_coins(value: int) -> void:
	coins = value
	SB.broadcast_coins_modified(coins)

func _set_experience(value: float) -> void:
	experience = value
	var exp_to_next_level: float = get_experience_to_next_level()
	if experience >= exp_to_next_level:
		experience = experience - exp_to_next_level
		level += 1
		_modify_stat_points(STAT_POINTS_ON_LEVEL_UP)
		
		SB.broadcast_level_modified(level)
	SB.broadcast_experience_modified(experience)

func _modify_stat_points(value: int) -> void:
	var initial_value: int = stat_points
	stat_points += value

	if (initial_value == 0 and stat_points > 0):
		SB.broadcast_stat_points_availability_changed(true)
	elif (initial_value != 0 and stat_points == 0):
		SB.broadcast_stat_points_availability_changed(false)

	SB.broadcast_stat_points_modified(stat_points)

###############################################################################
# Public functions                                                            #
###############################################################################

func get_experience_to_next_level() -> float:
	return round(exp(level) * EXP_TO_LEVEL_FACTOR)
