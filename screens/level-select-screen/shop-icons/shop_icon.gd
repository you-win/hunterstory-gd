class_name ShopIcon
extends TextureRect

onready var tooltip: PanelContainer = $CanvasLayer/Tooltip
onready var title: Label = $CanvasLayer/Tooltip/VBoxContainer/Title
onready var description: Label = $CanvasLayer/Tooltip/VBoxContainer/Description

export var shop_item_name: String = ""
export var shop_description: String = ""

var has_mouse := false

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	
	title.text = shop_item_name
	description.text = shop_description

func _process(delta: float) -> void:
	if has_mouse:
		if Input.is_action_pressed("left_click"):
			
			pass
		tooltip.rect_global_position = get_global_mouse_position()
		tooltip.rect_global_position.x += 10
		tooltip.rect_global_position.y += 10
	else:
		pass

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_mouse_entered() -> void:
	has_mouse = true
	_toggle_tooltip()

func _on_mouse_exited() -> void:
	has_mouse = false
	_toggle_tooltip()

###############################################################################
# Private functions                                                           #
###############################################################################

func _toggle_tooltip() -> void:
	tooltip.visible = not tooltip.visible

###############################################################################
# Public functions                                                            #
###############################################################################
