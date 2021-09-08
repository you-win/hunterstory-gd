extends HBoxContainer

enum Stats { NONE = 0, STRENGTH, DEXTERITY, AGILITY, INTELLIGENCE, LUCK }

signal added(stat)
signal subtracted(stat)

export(Stats) var stat
var stat_name: String

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	match stat:
		Stats.STRENGTH:
			stat_name = GameManager.Stats.STRENGTH
		Stats.DEXTERITY:
			stat_name = GameManager.Stats.DEXTERITY
		Stats.AGILITY:
			stat_name = GameManager.Stats.AGILITY
		Stats.INTELLIGENCE:
			stat_name = GameManager.Stats.INTELLIGENCE
		Stats.LUCK:
			stat_name = GameManager.Stats.LUCK
		_:
			print_debug("unhandled stat name")
	
	$Add.connect("pressed", self, "_on_add")
	$Subtract.connect("pressed", self, "_on_sub")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_add() -> void:
	emit_signal("added", stat_name)

func _on_sub() -> void:
	emit_signal("subtracted", stat_name)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


