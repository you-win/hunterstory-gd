class_name ShopContainer
extends PanelContainer

onready var previous: Button = $VBoxContainer/ShopNav/HBoxContainer/Previous
onready var next: Button = $VBoxContainer/ShopNav/HBoxContainer/Next
var current_page: int = 1



###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	previous.connect("pressed", self, "_on_previous")
	next.connect("pressed", self, "_on_next")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_previous() -> void:
	if current_page > 2:
		current_page -= 1
	pass

func _on_next() -> void:
	# TODO placeholder
	if current_page < 10:
		current_page += 1

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################
