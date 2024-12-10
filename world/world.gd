extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var camera_2d: Camera2D = $Player/Camera2D


func _ready() -> void:
	var used = tile_map.get_used_rect()
	var tile_size = tile_map.tile_set.tile_size
	
	camera_2d.limit_top = used.position.y * tile_size.y - 400
	camera_2d.limit_bottom = tile_size.y * used.end.y
	camera_2d.limit_left = tile_size.x * used.position.x
	camera_2d.limit_right = tile_size.x * used.end.x
