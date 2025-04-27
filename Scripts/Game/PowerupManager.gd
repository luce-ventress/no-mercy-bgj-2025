extends Node

@onready var game_start_time: float = Time.get_unix_time_from_system()
@onready var PowerupLabel: Label = get_parent().find_child("PowerupLabel", true, false)
@onready var PowerdownLabel: Label = get_parent().find_child("PowerDown", true, false)
@onready var SpawnTimer: Timer = get_parent().find_child("SpawnerTimer", true, false)

@onready var PowerupSound = get_parent().find_child("PowerupSound", true, false)
@onready var PowerdownSound = get_parent().find_child("PowerdownSound", true, false)


var dicemax = 100
var rollToNoMercy = 75

var seconds_per_powerup: float = 5
var powerups: int = 0

var time: float
var tween: Tween

@onready var rng = RandomNumberGenerator.new()

func reset():
	game_start_time = Time.get_unix_time_from_system()
	powerups = 0

func _process(_delta: float) -> void:
	if PlayerStats.isDead:
		return
	if not SpawnTimer:
		SpawnTimer = get_parent().find_child("SpawnerTimer", true, false)
		return
	if not PowerupLabel:
		PowerupLabel = get_parent().find_child("PowerupLabel", true, false)
		return
	if not PowerdownLabel:
		PowerdownLabel = get_parent().find_child("PowerDown", true, false)
		return
		
	if not PowerupSound:
		PowerupSound = get_parent().find_child("PowerupSound", true, false)
		return
	if not PowerdownSound:
		PowerdownSound = get_parent().find_child("PowerdownSound", true, false)
		return
	
	time = Time.get_unix_time_from_system() - game_start_time
	if time >= ((powerups + 1) * seconds_per_powerup):
		in_this_game_god_actually_DOES_roll_dice()

func in_this_game_god_actually_DOES_roll_dice():
	if powerups >= rollToNoMercy:
		give_powerdown()
		return
		
	var dice_roll = rng.randi_range(powerups, dicemax)
	if dice_roll >= rollToNoMercy:
		give_powerdown()
	else:
		give_powerup()

func give_powerup():
	modify_value(true)
	lable_anim(PowerupLabel)
	powerups += 1;
	PowerupSound.play()
	
func give_powerdown():
	modify_value(false)
	lable_anim(PowerdownLabel)
	powerups += 1;
	PowerdownSound.play()


func modify_value(boost: bool):
	var stat_roll = rng.randi_range(1, 13)
	
	SpawnTimer.set_wait_time(SpawnTimer.get_wait_time() * 0.9)
	
	match stat_roll:
		#good goes up values
		1, 2, 3, 4, 5, 6, 7:
			var random_mult: float

				
			match stat_roll:
				1:
					if boost:
						random_mult = rng.randf_range(1.5, 2.0)
					else:
						random_mult = rng.randf_range(0.75, 1.0)
					PlayerStats.PlayerDamage *= random_mult
					print("PlayerStats.PlayerDamage = ", PlayerStats.PlayerDamage)
				2:
					if boost:
						random_mult = rng.randf_range(1.1, 1.3)
					else:
						random_mult = rng.randf_range(0.9, 1.0)
					PlayerStats.PlayerSpeed *= random_mult
					print("PlayerStats.PlayerSpeed = ", PlayerStats.PlayerSpeed)
				3:
					if boost:
						random_mult = rng.randf_range(1.1, 1.3)
					else:
						random_mult = rng.randf_range(0.9, 1.0)
					PlayerStats.PlayerProjectileSpeedMult *= random_mult
					print("PlayerStats.PlayerProjectileSpeedMult = ", PlayerStats.PlayerProjectileSpeedMult)
				4:
					if boost:
						random_mult = rng.randf_range(1.5, 3.0)
					else:
						random_mult = rng.randf_range(0.3, 0.9)
					PlayerStats.EnemyGravityScale *= random_mult
					print("PlayerStats.EnemyGravityScale = ", PlayerStats.EnemyGravityScale)
				5:
					if boost:
						random_mult = rng.randf_range(1.05, 1.1)
					else:
						random_mult = rng.randf_range(0.9, 1.0)
					PlayerStats.EnemyShootCooldown *= random_mult
					print("PlayerStats.EnemyShootCooldown = ", PlayerStats.EnemyShootCooldown)
				6:
					if boost:
						random_mult = rng.randf_range(1.5, 3.0)
					else:
						random_mult = rng.randf_range(0.3, 0.9)
					PlayerStats.EnemyPushbackStrengthMult *= random_mult
					print("PlayerStats.EnemyPushbackStrengthMult = ", PlayerStats.EnemyPushbackStrengthMult)
				7:
					if boost:
						random_mult = rng.randf_range(1.5, 3.0)
					else:
						random_mult = rng.randf_range(0.3, 0.9)
					PlayerStats.EnemyPushUpStrengthMult *= random_mult
					print("PlayerStats.EnemyPushUpStrengthMult = ", PlayerStats.EnemyPushUpStrengthMult)
		#good goes down values
		8, 9, 10, 11, 12, 13:
			var random_mult: float
			match stat_roll:
				8:
					if boost:
						random_mult = rng.randf_range(0.7, 0.9)
					else:
						random_mult = rng.randf_range(1.1, 1.2)
					PlayerStats.PlayerShotCooldown *= random_mult
					print("PlayerStats.PlayerShotCooldown = ", PlayerStats.PlayerShotCooldown)
				9:
					if boost:
						random_mult = rng.randf_range(0.7, 0.9)
					else:
						random_mult = rng.randf_range(1.1, 1.3)
					PlayerStats.EnemySpeedMult *= random_mult
					print("PlayerStats.EnemySpeedMult = ", PlayerStats.EnemySpeedMult)
				10:
					if boost:
						random_mult = rng.randf_range(0.7, 0.9)
					else:
						random_mult = rng.randf_range(1.1, 1.2)
					PlayerStats.EnemyRotSpeedMult *= random_mult
					print("PlayerStats.EnemyRotSpeedMult = ", PlayerStats.EnemyRotSpeedMult)
				11:
					if boost:
						random_mult = rng.randf_range(0.7, 0.9)
					else:
						random_mult = rng.randf_range(1.1, 1.2)
					PlayerStats.PlayerGravityScale *= random_mult
					print("PlayerStats.PlayerGravityScale = ", PlayerStats.PlayerGravityScale)
				12:
					if boost:
						random_mult = rng.randf_range(0.7, 0.9)
					else:
						random_mult = rng.randf_range(1.1, 1.2)
					PlayerStats.EnemyDamageMult *= random_mult
					print("PlayerStats.EnemyDamageMult = ", PlayerStats.EnemyDamageMult)
				13:	
					if boost:
						random_mult = rng.randf_range(0.7, 0.9)
					else:
						random_mult = rng.randf_range(1.1, 1.2)
					PlayerStats.EnemyProjectileSpeedMult *= random_mult
					print("PlayerStats.EnemyProjectileSpeedMult = ", PlayerStats.EnemyProjectileSpeedMult)

func lable_anim(label: Label):
	PowerupLabel.visible = false
	PowerdownLabel.visible = false
	
	if tween:
		tween.kill() # Abort the previous animation.
		
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible", true, 0)
	for n in 3:
		tween.tween_property(label, "scale", Vector2(1.2, 1.2), 0.2).set_trans(Tween.TRANS_SINE)
		tween.tween_property(label, "scale", Vector2(1.0, 1.0), 0.2).set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, "visible", false, 0)
