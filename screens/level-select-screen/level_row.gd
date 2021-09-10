extends PanelContainer

signal pressed_with_data(data)

var data: CombatScreenData

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	$HBoxContainer/HBoxContainer/Button.connect("pressed", self, "_on_pressed")
	
	$HBoxContainer/LevelName.text = data.level_name
	
	# TODO store and pull clear rating from somewhere

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_pressed() -> void:
	emit_signal("pressed_with_data", data)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


