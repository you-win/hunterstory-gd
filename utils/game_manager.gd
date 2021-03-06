extends Node

signal message_logged(text)

const GameData: Resource = preload("res://utils/game_data.gd")

const ENEMY_GROUP: String = "Enemy"
const FLOOR_GROUP: String = "Floor"

const Stats: Dictionary = {
	"STRENGTH": "strength",
	"DEXTERITY": "dexterity",
	"AGILITY": "agility",
	"INTELLIGENCE": "intelligence",
	"LUCK": "luck"
}

var main: CanvasLayer

var game_data: GameData

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func log_message(text: String, is_error: bool = false) -> void:
	if is_error:
		text = "[ERROR] %s" % text
		assert(false, text)
	
	print(text)
	emit_signal("message_logged", text)

func new_game_data() -> void:
	game_data = GameData.new()
