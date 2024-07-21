extends Node

signal weapon_switched


func fire_weapon_switched():
	weapon_switched.emit()
