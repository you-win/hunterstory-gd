extends Node2D

const Arrow: PackedScene = preload("res://entities/player/arrow.tscn")

enum State { NONE, IDLE, DRAWING, DRAWN }

const Anims: Dictionary = {
	"IDLE": "Idle",
	"DRAWING": "Drawing",
	"DRAWN": "Drawn"
}

onready var bow_sprite: Sprite = $BowSprite
onready var anim_player: AnimationPlayer = $AnimationPlayer

var mouse_position := Vector2.ZERO
var current_state: int = State.NONE
var next_state: int = State.NONE

var arrows_node: Node2D
var damage_numbers_node: Node2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	anim_player.connect("animation_finished", self, "_on_anim_finished")

func _physics_process(_delta: float) -> void:
	mouse_position = get_global_mouse_position()
	
	bow_sprite.look_at(mouse_position)
	
	if current_state != next_state:
		match next_state:
			State.IDLE:
				if (current_state == State.DRAWING or current_state == State.DRAWN):
					var arrow: RigidBody2D = Arrow.instance()
					
					# TODO testing
					arrow.damage += GameManager.game_data.level * 10
					
					arrow.initial_position = global_position
					arrow.initial_rotation = bow_sprite.global_rotation
					arrows_node.call_deferred("add_child", arrow)
				anim_player.play(Anims.IDLE)
			State.DRAWING:
				anim_player.play(Anims.DRAWING)
			State.DRAWN:
				anim_player.play(Anims.DRAWN)
		
		current_state = next_state

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		next_state = State.DRAWING
	elif event.is_action_released("left_click"):
		next_state = State.IDLE
	
	elif event.is_action_pressed("right_click"):
		pass
	elif event.is_action_pressed("right_click"):
		pass

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_anim_finished(anim_name: String) -> void:
	match anim_name:
		Anims.DRAWING:
			next_state = State.DRAWN

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


