extends Actor

export var stomp_impulse : float = 1000
var wall_jump_performed: bool = false

func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	if area.global_position.y > get_node("EnemyDetector").global_position.y:
		return
	_velocity = _calculate_stomp_velocity(_velocity, stomp_impulse)

func _calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var recalculated_velocity: = linear_velocity
	recalculated_velocity.y = -impulse
	print(recalculated_velocity)
	return recalculated_velocity

func _physics_process(delta: float) -> void:
	var direction = get_direction()
		
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
func get_direction() -> Vector2:
	var x: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y: float = -1.0 if Input.is_action_just_pressed("jump") else 1.0
	
	return Vector2(x, y)

func walljump(direction: Vector2) -> bool:
	return !is_on_floor() and is_on_wall() and direction.y == -1.0 and direction.x != 0

func jump_from_floor(y: float) -> bool:
	return y == -1.0 and is_on_floor()
	
func jump_interrupted() -> bool:
	return Input.is_action_just_released("jump") and _velocity.y < 0.0

func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2) -> Vector2:
	var recalculated_velocity: = linear_velocity
	
	if wall_jump_performed:
		recalculated_velocity.y += gravity * get_physics_process_delta_time()
		recalculated_velocity.x = speed.x * direction.x
		wall_jump_performed = false if is_on_floor() else true
	elif jump_interrupted():
		recalculated_velocity.y = linear_velocity.y / 2
		recalculated_velocity.x = speed.x * direction.x
	elif walljump(direction):
		recalculated_velocity.x += speed.x * direction.x * -1
		recalculated_velocity.y = speed.y * direction.y
		wall_jump_performed = true
	elif jump_from_floor(direction.y):
		recalculated_velocity.x = speed.x * direction.x
		recalculated_velocity.y = speed.y * direction.y
	else:
		recalculated_velocity.x = speed.x * direction.x
		recalculated_velocity.y += gravity * get_physics_process_delta_time()
	# 
	return recalculated_velocity





