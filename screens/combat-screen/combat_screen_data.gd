class_name CombatScreenData
extends Reference

var level_name: String = "changeme"

const SpawnRate: Dictionary = {
	"NONE": "none",
	"SLOW": "slow",
	"NORMAL": "normal",
	"FAST": "fast",
	"INSTANT": "instant"
}
var spawn_rate: String = SpawnRate.NONE

const SpawnType: Dictionary = {
	"NONE": "none",
	"LINEAR": "linear",
	"BATCH": "batch"
}
var spawn_type: String = SpawnType.NONE

const Enemy: Dictionary = {
	"NONE": "none",
	"BLUE_SNAIL": "blue_snail"
}
# Enemy enum to int amount
var enemies: Dictionary = {}

var special_instructions: Dictionary = {}

###############################################################################
# Builtin functions                                                           #
###############################################################################

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################
