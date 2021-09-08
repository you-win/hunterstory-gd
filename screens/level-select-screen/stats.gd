extends VBoxContainer

export var strength_path: NodePath
export var strength_add_sub_path: NodePath

export var dexterity_path: NodePath
export var dexterity_add_sub_path: NodePath

export var agility_path: NodePath
export var agility_add_sub_path: NodePath

export var intelligence_path: NodePath
export var intelligence_add_sub_path: NodePath

export var luck_path: NodePath
export var luck_add_sub_path: NodePath

onready var strength: Label = get_node(strength_path)
onready var str_add_sub: Control = get_node(strength_add_sub_path)

onready var dexterity: Label = get_node(dexterity_path)
onready var dex_add_sub: Control = get_node(dexterity_add_sub_path)

onready var agility: Label = get_node(agility_path)
onready var agi_add_sub: Control = get_node(agility_add_sub_path)

onready var intelligence: Label = get_node(intelligence_path)
onready var int_add_sub: Control = get_node(intelligence_add_sub_path)

onready var luck: Label = get_node(luck_path)
onready var luc_add_sub: Control = get_node(luck_add_sub_path)

var add_sub_buttons: Array

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	SB.connect("stat_modified", self, "_on_stat_modified")
	SB.connect("stat_points_availability_changed", self, "_on_stat_points_availability_changed")
	
	str_add_sub.connect("added", self, "_on_added")
	str_add_sub.connect("subtracted", self, "_on_subtracted")
	
	dex_add_sub.connect("added", self, "_on_added")
	dex_add_sub.connect("subtracted", self, "_on_subtracted")
	
	agi_add_sub.connect("added", self, "_on_added")
	agi_add_sub.connect("subtracted", self, "_on_subtracted")
	
	int_add_sub.connect("added", self, "_on_added")
	int_add_sub.connect("subtracted", self, "_on_subtracted")
	
	luc_add_sub.connect("added", self, "_on_added")
	luc_add_sub.connect("subtracted", self, "_on_subtracted")
	
	add_sub_buttons = [
		str_add_sub,
		dex_add_sub,
		agi_add_sub,
		int_add_sub,
		luc_add_sub
	]

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_added(stat: String) -> void:
	SB.broadcast_stat_modified(stat, 1)

func _on_subtracted(stat: String) -> void:
	SB.broadcast_stat_modified(stat, -1)

func _on_stat_modified(stat: String, value: int) -> void:
	# Wait a little bit to let game_data update first
	yield(get_tree(), "idle_frame")
	get(stat).text = str(GameManager.game_data.get(stat))

func _on_stat_points_availability_changed(value: bool) -> void:
	if value:
		for i in add_sub_buttons:
			i.visible = true
	else:
		for i in add_sub_buttons:
			i.visible = false

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


