class_name MetaStats
extends PanelContainer

onready var coins_value: Label = $HBoxContainer/VBoxContainer/Coins/Value
onready var stat_points_value: Label = $HBoxContainer/VBoxContainer/StatPoints/Value

onready var level_value: Label = $HBoxContainer/Level/HBoxContainer/Value
onready var level_progress_bar: ProgressBar = $HBoxContainer/Level/ProgressBar

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	coins_value.text = str(GameManager.game_data.coins)
	stat_points_value.text = str(GameManager.game_data.stat_points)
	level_value.text = str(GameManager.game_data.level)
	level_progress_bar.max_value = GameManager.game_data.get_experience_to_next_level()
	level_progress_bar.value = GameManager.game_data.experience
	
	SB.connect("coins_modified", self, "_on_coins_modified")
	SB.connect("stat_points_modified", self, "_on_stat_points_modified")
	SB.connect("experience_modified", self, "_on_experience_modified")
	SB.connect("level_modified", self, "_on_level_modified")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_coins_modified(value: int) -> void:
	coins_value.text = str(value)

func _on_stat_points_modified(value: int) -> void:
	stat_points_value.text = str(value)

func _on_experience_modified(value: float) -> void:
	level_progress_bar.value = value

func _on_level_modified(value: int) -> void:
	level_value.text = str(value)
	level_progress_bar.max_value = GameManager.game_data.get_experience_to_next_level()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################
