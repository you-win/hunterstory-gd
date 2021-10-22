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

onready var strength: Label = get_node(strength_path) as Label
onready var str_add_sub: Control = get_node(strength_add_sub_path)

onready var dexterity: Label = get_node(dexterity_path) as Label
onready var dex_add_sub: Control = get_node(dexterity_add_sub_path)

onready var agility: Label = get_node(agility_path) as Label
onready var agi_add_sub: Control = get_node(agility_add_sub_path)

onready var intelligence: Label = get_node(intelligence_path) as Label
onready var int_add_sub: Control = get_node(intelligence_add_sub_path)

onready var luck: Label = get_node(luck_path) as Label
onready var luc_add_sub: Control = get_node(luck_add_sub_path)

onready var remaining_label: Label = $RemainingStatPoints/Value

onready var apply: Button = $ApplyReset/Apply
onready var reset: Button = $ApplyReset/Reset

var add_sub_buttons: Array

var initial_stat_points: int
var remaining_stat_points: int

var modified_stats: Dictionary = {
	GameManager.Stats.STRENGTH: 0,
	GameManager.Stats.DEXTERITY: 0,
	GameManager.Stats.AGILITY: 0,
	GameManager.Stats.INTELLIGENCE: 0,
	GameManager.Stats.LUCK: 0,
}

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
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
	
	apply.connect("pressed", self, "_on_apply")
	reset.connect("pressed", self, "_on_reset")
	
	_setup_stats()
	initial_stat_points = GameManager.game_data.stat_points
	remaining_stat_points = initial_stat_points
	remaining_label.text = str(remaining_stat_points)
	
	if GameManager.game_data.stat_points > 0:
		_on_stat_points_availability_changed(true)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_added(stat: String) -> void:
	if remaining_stat_points > 0:
		get(stat).text = str(get(stat).text.to_int() + 1)
		remaining_stat_points -= 1
		remaining_label.text = str(remaining_stat_points)
		modified_stats[stat] += 1

func _on_subtracted(stat: String) -> void:
	if remaining_stat_points < initial_stat_points:
		var stat_value: int = get(stat).text.to_int()
		if stat_value > 1:
			get(stat).text = str(stat_value - 1)
			remaining_stat_points += 1
			remaining_label.text = str(remaining_stat_points)
			modified_stats[stat] -= 1

func _on_apply() -> void:
	for key in modified_stats.keys():
		var amount: int = modified_stats[key]
		if amount > 0:
			SB.broadcast_stat_modified(key, amount)
		modified_stats[key] = 0

func _on_reset() -> void:
	_setup_stats()
	
	remaining_stat_points = initial_stat_points
	remaining_label.text = str(remaining_stat_points)

func _on_stat_points_availability_changed(value: bool) -> void:
	_setup_stats()
	if value:
		for i in add_sub_buttons:
			i.visible = true
		apply.visible = true
		reset.visible = true
	else:
		for i in add_sub_buttons:
			i.visible = false
		apply.visible = false
		reset.visible = false

###############################################################################
# Private functions                                                           #
###############################################################################

func _setup_stats() -> void:
	var gd: GameData = GameManager.game_data
	
	strength.text = str(gd.strength)
	dexterity.text = str(gd.dexterity)
	agility.text = str(gd.agility)
	intelligence.text = str(gd.intelligence)
	luck.text = str(gd.luck)

###############################################################################
# Public functions                                                            #
###############################################################################
