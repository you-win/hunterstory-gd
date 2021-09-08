extends Node

signal message_logged(text)

const ENEMY_GROUP: String = "Enemy"
const FLOOR_GROUP: String = "Floor"

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
