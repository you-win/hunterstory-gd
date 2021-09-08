extends Reference

var coins: int
var experience: float

# Stats
var stat_points: int = 0
var strength: int = 0
var dexterity: int = 0
var agility: int = 0
var intelligence: int = 0
var luck: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _init() -> void:
	SB.connect("stat_modified", self, "_on_stat_modified")
	SB.connect("stat_points_modified", self, "_on_stat_points_modified")

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
		SB.broadcast_stat_points_modified(-value)

func _on_stat_points_modified(value: int) -> void:
	var initial_value: int = stat_points
	stat_points += value
	
	if (initial_value == 0 and stat_points > 0):
		SB.broadcast_stat_points_availability_changed(true)
	elif (initial_value != 0 and stat_points == 0):
		SB.broadcast_stat_points_availability_changed(false)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


