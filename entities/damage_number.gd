extends Label

const LIFETIME: float = 2.0
var lifetime_counter: float = 0.0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	lifetime_counter += delta
	if lifetime_counter >= LIFETIME:
		queue_free()
	
	rect_global_position.y -= delta * 120

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

