extends Node

signal coins_modified(value)
func broadcast_coins_modified(value: float) -> void:
	emit_signal("coins_modified", int(ceil(value)))

signal experience_modified(value)
func broadcast_experience_modified(value: float) -> void:
	emit_signal("experience_modified", value)

signal level_modified(value)
func broadcast_level_modified(value: int) -> void:
	emit_signal("level_modified", value)

signal stat_modified(stat, value)
func broadcast_stat_modified(stat: String, value: int) -> void:
	emit_signal("stat_modified", stat, value)

signal stat_points_modified(value)
func broadcast_stat_points_modified(value: int) -> void:
	emit_signal("stat_points_modified", value)

signal stat_points_availability_changed(value)
func broadcast_stat_points_availability_changed(value: bool) -> void:
	emit_signal("stat_points_availability_changed", value)

signal shop_item_bought(shop_item_name)
func broadcast_shop_item_brought(shop_item_name: String) -> void:
	emit_signal("shop_item_bought", shop_item_name)
