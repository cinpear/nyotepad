extends Node2D

@export var keyListener = ""

@onready var sets = [[$a_spritemap, $c_spritemap, $c_spritemap2, $o_spritemap, $r_spritemap, $d_spritemap, $i_spritemap],
						[$n_spritemap, $g_spritemap, $t_spritemap, $o_spritemap2, $a_spritemap2, $l_spritemap, $l_spritemap2],
						[$k_spritemap, $n_spritemap2, $o_spritemap3, $w_spritemap, $n_spritemap3, $l_spritemap3, $a_spritemap3],
						[$w_spritemap2, $s_spritemap, $o_spritemap4, $f_spritemap, $a_spritemap4, $v_spritemap, $i_spritemap2],
						[$a_spritemap5, $t_spritemap2, $i_spritemap3, $o_spritemap5, $n_spritemap4, $t_spritemap3, $h_spritemap],
						[$e_spritemap, $r_spritemap2, $e_spritemap2, $i_spritemap4, $s_spritemap2, $n_spritemap5, $o_spritemap6],
						[$w_spritemap3, $a_spritemap6, $y_spritemap, $t_spritemap4, $h_spritemap2, $a_spritemap7, $t_spritemap5],
						[$a_spritemap8, $b_spritemap, $e_spritemap3, $e_spritemap4, $s_spritemap3, $h_spritemap3, $o_spritemap7],
						[$u_spritemap, $l_spritemap4, $d_spritemap2, $b_spritemap2, $e_spritemap5, $a_spritemap9, $b_spritemap3],
						[$l_spritemap5, $e_spritemap6, $t_spritemap6, $o_spritemap8, $f_spritemap2, $l_spritemap6, $y_spritemap2]]
@onready var beat = [[1.0/3.0, 0.4, 11.0/30.0, 0.4, 0.4, 13.0/30.0],
						[0.4, 0.4, 0.4, 0.4, 0.4, 0.4],
						[1.0/3.0, 0.4, 0.4, 0.4, 11.0/30.0, 7.0/30.0],
						[0.4, 0.4, 0.4, 0.5, 0.4, 0.4],
						[0.4, 0.4, 0.4, 0.5, 7.0/30.0, 7.0/30.0],
						[0.4, 8.0/15.0, 4.0/15.0, 1.0/3.0, 11.0/30.0, 0.4],
						[0.3, 19.0/30.0, 4.0/15.0, 0.4, 0.5, 11.0/30.0],
						[0.4, 8.0/15.0, 4.0/15.0, 1.0/3.0, 7.0/15.0, 13.0/30.0],
						[0.2, 7.0/15.0, 0.2, 0.7, 1.0/3.0, 0.3],
						[0.2, 0.4, 0.2, 0.8, 0.4, 0.4]]
@onready var curr_char = [["a", "c", "c", "o", "r", "d", "i"],
							["n", "g", "t", "o", "a", "l", "l"],
							["k", "n", "o", "w", "n", "l", "a"],
							["w", "s", "o", "f", "a", "v", "i"],
							["a", "t", "i", "o", "n", "t", "h"],
							["e", "r", "e", "i", "s", "n", "o"],
							["w", "a", "y", "t", "h", "a", "t"],
							["a", "b", "e", "e", "s", "h", "o"],
							["u", "l", "d", "b", "e", "a", "b"],
							["l", "e", "t", "o", "f", "l", "y"]]

var i := 0
var player_input := ""
var score := 0
var combo := 0
var beattimes := []
var setnum := 0 # goes from 0 to 9
var beatwaittimes := [13.0/15.0, 13.0/15.0, 1, 0.8, 1 + 12.0/30.0, 0.9, 1.0, 30.0/30.0, 34.0/30.0]
# var beatwaittimes := [4 + 1.0/15.0, 4 + 1.0/6.0, 4 + 2.0/15.0, 4 + 2.0/15.0, 4 + 7.0/30.0, 4.1, 3.6, 4 + 1.0/6.0, 4.2]
# var waittimes := [13.0/15.0, 0.9, 1, 23.0/30.0, 1 + 1.0/30.0, 0.9, 0.6, 29.0/30.0, 1 + 1.0/30.0, 14.0/15.0]
var waittimes := [4 + 1.0/6.0, 4.0, 4 + 4.0/15.0, 4.0, 4 + 7.0/30.0, 3.9, 4.1, 4.0, 4.2]

func _ready():
	$BeatTimer1.wait_time = beat[setnum][0]
	$KeyTimer1.wait_time = beat[setnum][0]
	var cumulative_time = 19.6
	beattimes.append([cumulative_time])
	for j in len(beat):
		for b in beat[j]:
			cumulative_time += b
			beattimes[j].append(cumulative_time)
		if j < 9:
			cumulative_time += waittimes[j]
			beattimes.append([cumulative_time])
	# print(beattimes)

func _on_beat_timer_1_timeout() -> void:
	$hit_spritemap.frame = 5
	# print($BeatTimer1.wait_time)
	if i >= 7:
		print("here1")
		if setnum > 9:
			$BeatTimer1.stop()
			return
		else:
			i = 0
			if setnum < 9:
				$BeatTimer1.wait_time = beatwaittimes[setnum]
				print(setnum)
				print($BeatTimer1.wait_time)
			return
	else:
		sets[setnum][i].visible = true
		#print(sets[setnum][i])
		#print(setnum)
		#print(i)
		if i < 5 and setnum == 0:
			$BeatTimer1.wait_time = beat[setnum][i + 1]
		elif i < 6 and setnum != 0:
			$BeatTimer1.wait_time = beat[setnum][i]
		i += 1

func _on_key_timer_1_timeout() -> void:
	# print($KeyTimer1.wait_time)
	$hit_spritemap.frame = 5
	if i >= 7:
		print("here2")
		setnum += 1
		if setnum > 9:
			$KeyTimer1.stop()
			return
		else:
			i = 0
			$KeyTimer1.wait_time = waittimes[setnum - 1]
			return
	else:
		# print("here")
		if i < 5 and setnum == 0:
			$KeyTimer1.wait_time = beat[setnum][i + 1]
		elif i < 6 and setnum != 0:
			$KeyTimer1.wait_time = beat[setnum][i]
		

func _input(event):
	if Input.is_action_just_pressed("keyPressed"):
		print(Time.get_ticks_msec())
		var copy_i = i - 1
		var curr_time = $KeyTimer1.get_time_left()
		if setnum > 9:
			return
		if copy_i < 7:
			var expected_time = beattimes[setnum][copy_i]
		else:
			0
		
		var typed_char = char(event.keycode).to_lower()
		
		if typed_char in "abcdefghijklmnopqrstuvwxyz":
			player_input = typed_char
			print(player_input)
			if player_input == curr_char[setnum][copy_i]:
				var hit_time = Time.get_ticks_msec() / 1000.0
				var expected_hit_time = beattimes[setnum][copy_i]
				var timing_deviation = hit_time - expected_hit_time
				
				var timing_text = "Perfect!"
				var points = 100
				
				if timing_deviation > 3:
					print(timing_deviation)
					if timing_deviation > 6:
						timing_text = "Very Late"
						$hit_spritemap.frame = 3
						points = 20
					else:
						timing_text = "Late"
						$hit_spritemap.frame = 1
						points = 70
				elif abs(timing_deviation) > 3:
					print(abs(timing_deviation))
					if abs(timing_deviation) > 6:
						timing_text = "Very Early"
						$hit_spritemap.frame = 4
						points = 20
					else:
						timing_text = "Early"
						$hit_spritemap.frame = 2
						points = 70
				else:
					$hit_spritemap.frame = 0
				
				print(timing_text)
				sets[setnum][copy_i].frame = 1
				combo += 1
				score += combo * points
				print(timing_text, "! +", points, " points (", combo, "x combo)")
				

func _on_audio_stream_player_finished() -> void:
	for a in sets:
		for b in a:
			b.visible = false
	$hit_spritemap.visible = false
	$gangganggang.visible = false
	$end_screen.visible = true
	await get_tree().create_timer(5).timeout
	queue_free()
