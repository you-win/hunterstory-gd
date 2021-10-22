class_name UILayer
extends CanvasLayer

onready var meta_stats = $PanelContainer/VBoxContainer/MetaStats

onready var draw_strength_value = $PanelContainer/VBoxContainer/GameplayContainer/SkillsContainer/HboxContainer/DrawStrengthContainer/Value
const DRAW_STRENGTH_FORMAT = "%.f"

var player: Player
var player_anim_player: AnimationPlayer

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if player.anim_player.current_animation == Player.Anims.DRAWING:
		draw_strength_value.text = DRAW_STRENGTH_FORMAT % ((player.arrow_draw_scale / 1.0) * 100.0)
	elif player.anim_player.current_animation == Player.Anims.DRAWN:
		draw_strength_value.text = "100"
	else:
		draw_strength_value.text = "0"

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func setup_player(p: Player) -> void:
	player = p
	player_anim_player = player.anim_player
