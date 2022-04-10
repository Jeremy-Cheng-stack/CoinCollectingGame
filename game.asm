##################################################################### #
# CSCB58 Winter 2022 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Jeremy Cheng, 1007062134, cheng264, jeremyj.cheng@mail.utoronto.ca #
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed) # - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones) # - Milestone 1/2/3 (choose the one the applies)
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features) # 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it! #
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
# #####################################################################


#add-ons
#(1)Disappear platforms... the flying sky platform moves around where the player needs to reach through a jump if right above.
#		     the player is not connected to the platform, the player needs to keep adjsting movement keys to keep up with the platform
#(1)win cond.... the player must survive for 1 min
#(1)lose cond... the player gets hit by meteor or falls into lava
#(2)Moving objects... metoer fall from the sky which the player has to avoid
#(2) Track score
#(2) Pick up effects

.eqv  BASE_ADDRESS 0x10008000

.eqv  base_out 0xff00baff
.eqv  base_in 0xff313185
.eqv  fire_out 0xff0000
.eqv  fire_in  0xff5900

.eqv charC1 0xff31853a
.eqv charC2 0xff0000
.eqv charC3 0x00ff00
.eqv charC4 0x0000ff

.eqv black 0x000000
.eqv gold 0xFFD700
.eqv white 0xffffffff

.eqv m1c 0xCD853F
.eqv m2c 0xffe200e8

.eqv key_press 0xffff0000

.data

coin_spawns:     .word 
counter: 	 .word 0:1
on: 	 .word 1:1



.text

#use s0 to store character position
#use s2  to store char speed
#use array for postiion of metoer, svaed register for current ones on board
# use s3 to hold the array of met_spawns
j main

reset_screen_black:
	li $t0, BASE_ADDRESS
	
	addi $t3, $zero, 0
	addi $t4, $zero, 16380
	
reset_screen_loop:	
	li $t1, black
	bge $t3, $t4, reset_exit #Drawing inside
	
	add $t5, $t0, $t3
	sw $t1, 0($t5)
	
	addi $t3, $t3, 4
	j reset_screen_loop

reset_exit:
	jr $ra
	
draw_mushroom:
	li $t0, BASE_ADDRESS
	li $t1, m2c
	
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	
	add $t5, $t2, $t0
	
	sw $t1, 0($t5)
	sw $t1, 4($t5)
	sw $t1, 8($t5)
	sw $t1, -4($t5)
	sw $t1, -8($t5)
	
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	
	sw $t1, -256($t5)
	sw $t1, -252($t5)
	sw $t1, -260($t5)
	
	jr $ra
	
GG_screen:
	li $t0, BASE_ADDRESS
	li $t1, white
	#256 * 28
	
	addi $t5, $t0, 7268
	
	sw $t1, 0($t5)
	sw $t1, 4($t5)
	sw $t1, 8($t5)
	
	sw $t1, 264($t5)
	sw $t1, 520($t5)
	
	sw $t1, 516($t5)
	sw $t1, 512($t5)
	sw $t1, 508($t5)
	sw $t1, 504($t5)
	
	sw $t1, 248($t5)
	sw $t1, -8($t5)
	sw $t1, -264($t5)
	sw $t1, -520($t5)
	
	sw $t1, -516($t5)
	sw $t1, -512($t5)
	sw $t1, -508($t5)
	sw $t1, -504($t5)
	
	addi $t5, $t0, 7308
	
	sw $t1, 0($t5)
	sw $t1, 4($t5)
	sw $t1, 8($t5)
	
	sw $t1, 264($t5)
	sw $t1, 520($t5)
	
	sw $t1, 516($t5)
	sw $t1, 512($t5)
	sw $t1, 508($t5)
	sw $t1, 504($t5)
	
	sw $t1, 248($t5)
	sw $t1, -8($t5)
	sw $t1, -264($t5)
	sw $t1, -520($t5)
	
	sw $t1, -516($t5)
	sw $t1, -512($t5)
	sw $t1, -508($t5)
	sw $t1, -504($t5)
	
	jr $ra
black_mushroom:
	li $t0, BASE_ADDRESS
	li $t1, black
	
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	
	add $t5, $t2, $t0
	
	sw $t1, 0($t5)
	sw $t1, 4($t5)
	sw $t1, 8($t5)
	sw $t1, -4($t5)
	sw $t1, -8($t5)
	
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	
	sw $t1, -256($t5)
	sw $t1, -252($t5)
	sw $t1, -260($t5)
	
	jr $ra
#DRAWING THE TWO GROUNDS 
draw_map_ground: 	
	li $t0, BASE_ADDRESS
	li $t1, base_out
	
	sw $t1, 14848($t0)
	sw $t1, 14852($t0)
	sw $t1, 14856($t0)
	sw $t1, 14860($t0)
	sw $t1, 14864($t0)
	sw $t1, 14868($t0)
	sw $t1, 14872($t0)
	sw $t1, 14876($t0)
	sw $t1, 14880($t0)
	sw $t1, 14884($t0)
	sw $t1, 14888($t0)
	sw $t1, 14892($t0)
	sw $t1, 14896($t0)
	sw $t1, 14900($t0)
	sw $t1, 14904($t0)
	sw $t1, 14908($t0)
	sw $t1, 14912($t0)
	sw $t1, 14916($t0)
	sw $t1, 14920($t0)
	sw $t1, 14924($t0)
	sw $t1, 14928($t0)
	sw $t1, 14932($t0)
	
	sw $t1, 15100($t0)
	sw $t1, 15096($t0)
	sw $t1, 15092($t0)
	sw $t1, 15088($t0)
	sw $t1, 15084($t0)
	sw $t1, 15080($t0)
	sw $t1, 15076($t0)
	sw $t1, 15072($t0)
	sw $t1, 15068($t0)
	sw $t1, 15064($t0)
	sw $t1, 15060($t0)
	sw $t1, 15056($t0)
	sw $t1, 15052($t0)
	sw $t1, 15048($t0)
	sw $t1, 15044($t0)
	sw $t1, 15040($t0)
	sw $t1, 15036($t0)
	sw $t1, 15032($t0)
	sw $t1, 15028($t0)
	sw $t1, 15024($t0)
	sw $t1, 15020($t0)
	sw $t1, 15016($t0)
	
		
	sw $t1, 15188($t0)#left
	sw $t1, 15444($t0)
	sw $t1, 15700($t0)
	sw $t1, 15956($t0)
	sw $t1, 16212($t0)
	
	sw $t1, 15272($t0)#right
	sw $t1, 15528($t0)
	sw $t1, 15784($t0)
	sw $t1, 16040($t0)
	sw $t1, 16296($t0)
	
	li $t1, base_in
	
	addi $t3, $zero, 15276
	addi $t4, $zero, 15360
	
	
LOOP1:	bge $t3, $t4, EXIT1 #Drawing inside
	
	add $t5, $t0, $t3
	sw $t1, 0($t5)
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	sw $t1, 768($t5)
	sw $t1, 1024($t5)
	
	
	addi $t3, $t3, 4
	j LOOP1

EXIT1:

	addi $t3, $zero, 15104
	addi $t4, $zero, 15188
	
LOOP2:	bge $t3, $t4, EXIT2 #Drawing inside
	
	add $t5, $t0, $t3
	sw $t1, 0($t5)
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	sw $t1, 768($t5)
	sw $t1, 1024($t5)
	
	
	addi $t3, $t3, 4
	j LOOP2

EXIT2:
	jr $ra

#TURN THE SKY GROUND BLACK 
ground_sky_black:
	li $t0, BASE_ADDRESS
	li $t1, black
	
	sw $t1, 12608($t0)
	sw $t1, 12612($t0)
	sw $t1, 12616($t0)
	sw $t1, 12620($t0)
	sw $t1, 12624($t0)
	sw $t1, 12628($t0)
	sw $t1, 12632($t0)
	sw $t1, 12636($t0)
	sw $t1, 12640($t0)
	sw $t1, 12644($t0)
	sw $t1, 12648($t0)
	sw $t1, 12652($t0)
	sw $t1, 12656($t0)
	sw $t1, 12660($t0)
	sw $t1, 12664($t0)
	sw $t1, 12668($t0)
	sw $t1, 12672($t0)
	sw $t1, 12676($t0)
	sw $t1, 12680($t0)
	sw $t1, 12684($t0)
	sw $t1, 12688($t0)
	sw $t1, 12692($t0)
	sw $t1, 12696($t0)
	sw $t1, 12700($t0)
	sw $t1, 12704($t0)
	sw $t1, 12708($t0)
	sw $t1, 12712($t0)
	sw $t1, 12716($t0)
	sw $t1, 12720($t0)
	sw $t1, 12724($t0)
	sw $t1, 12728($t0)
	sw $t1, 12732($t0)
	
	jr $ra
#DRAW THE ORIGINAL GOUND_SKY
draw_ground_sky:	
	#14*4 = 56 
	li $t0, BASE_ADDRESS
	li $t1, base_out
	
	sw $t1, 12608($t0)
	sw $t1, 12612($t0)
	sw $t1, 12616($t0)
	sw $t1, 12620($t0)
	sw $t1, 12624($t0)
	sw $t1, 12628($t0)
	sw $t1, 12632($t0)
	sw $t1, 12636($t0)
	sw $t1, 12640($t0)
	sw $t1, 12644($t0)
	sw $t1, 12648($t0)
	sw $t1, 12652($t0)
	sw $t1, 12656($t0)
	sw $t1, 12660($t0)
	sw $t1, 12664($t0)
	sw $t1, 12668($t0)
	sw $t1, 12672($t0)
	sw $t1, 12676($t0)
	sw $t1, 12680($t0)
	sw $t1, 12684($t0)
	sw $t1, 12688($t0)
	sw $t1, 12692($t0)
	sw $t1, 12696($t0)
	sw $t1, 12700($t0)
	sw $t1, 12704($t0)
	sw $t1, 12708($t0)
	sw $t1, 12712($t0)
	sw $t1, 12716($t0)
	sw $t1, 12720($t0)
	sw $t1, 12724($t0)
	sw $t1, 12728($t0)
	sw $t1, 12732($t0)
	
	jr $ra
	
	

#draw the lava area 	
draw_lava:
	li $t0, BASE_ADDRESS
	li $t1, fire_out
	
	addi $t3, $zero, 15704
	addi $t4, $zero, 15784
	
LOOP3:	bge $t3, $t4, EXIT3 #Drawing inside
	
	add $t5, $t0, $t3
	li $t1, fire_out
	sw $t1, 0($t5)
	li $t1, fire_in
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	
	addi $t3, $t3, 4
	j LOOP3

EXIT3:
	jr $ra
	
remove_prev_char: # draws the character shape at a specific location all black
	li $t0, BASE_ADDRESS
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	add $t5, $t0, $t2
	
	li $t1, black
	
	sw $t1, 0($t5)
	sw $t1, -256($t5)
	sw $t1, -508($t5)
	sw $t1, -516($t5)
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	sw $t1, 516($t5)
	sw $t1, 508($t5)
	sw $t1, 772($t5)
	sw $t1, 764($t5)
	
	
	sw $t1, -512($t5)
	
	
	sw $t1, -260($t5)
	
	
	sw $t1, -252($t5)
	jr $ra
	
draw_char: #Requires the new location of character to draw it out
	li $t0, BASE_ADDRESS
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	add $t5, $t0, $t2
	
	li $t1, charC1
	
	sw $t1, 0($t5)
	sw $t1, -256($t5)
	sw $t1, -508($t5)
	sw $t1, -516($t5)
	sw $t1, 256($t5)
	sw $t1, 512($t5)
	sw $t1, 516($t5)
	sw $t1, 508($t5)
	sw $t1, 772($t5)
	sw $t1, 764($t5)
	
	li $t1, charC1
	sw $t1, -512($t5)
	
	li $t1, charC1
	sw $t1, -260($t5)
	
	li $t1, charC1
	sw $t1, -252($t5)
	jr $ra

check_char_move: # Check if a button on the keyboard was pressed so you would have to move the character to a different location
	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, keypress_w
	j keypress_exit

keypress_w:
	
 	lw $t2, 4($t9)
 	
 	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beq $t2, 0x77, respond_to_w
keypress_a:

	beq $t2, 0x61, respond_to_a
keypress_d:
	
	beq $t2, 0x64, respond_to_d
keypress_p:
	beq $t2, 0x70, respond_to_p
	
keypress_exit:
	jr $ra	
	
respond_to_p:
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jal reset_screen_black
	
	jal GG_screen
	
	li $v0, 32
	li $a0, 5000 # 40 recommeneded
	syscall
	
	jal reset_screen_black
	
	j main
	
respond_to_w:# if the w button was pressed
	

	
	add $t3, $zero, $s0
	
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal remove_prev_char
	
	addi $s0, $s0, -3328
	
	add $t3, $zero, $s0
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_char

exit_w:	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

respond_to_a:# if the a button was pressed
	
	
	add $t3, $zero, $s0
	
	addi $t3, $t3, -4
	addi $t4,$zero, 13828
	beq $t4, $t3, exit_a
	addi $t4,$zero, 13824
	beq $t4, $t3, exit_a
	
	addi $t3, $t3, 4
	
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal remove_prev_char
	
	addi $t8,$zero, -1
	
	mult $t8, $s2
	mflo $t9
	
	add $t7, $s0, $t9
	add $s0, $s0, $t9
	
	add $t3, $zero, $t7
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_char

exit_a:	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

respond_to_d: # if the d button was pressed
	
	
	add $t3, $zero, $s0
	
	addi $t3, $t3, 4
	addi $t4,$zero, 14076
	beq $t4, $t3, exit_d
	
	addi $t4,$zero, 14072
	beq $t4, $t3, exit_d
	
	addi $t4,$zero, 14068
	beq $t4, $t3, exit_d
	
	addi $t3, $t3, -4
	
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal remove_prev_char
	
	add $s0, $s0, $s2
	
	add $t3, $zero, $s0
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_char
	
exit_d:	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
black_m1:
	li $t0, BASE_ADDRESS
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	add $t5, $t0, $t2
	
	li $t1, black
	sw $t1, -256($t5)
	sw $t1, 256($t5)
	sw $t1, 260($t5)
	sw $t1, 4($t5)
	sw $t1, -4($t5)
	sw $t1, 516($t5)
	sw $t1, 508($t5)
	sw $t1, -516($t5)
	sw $t1, -508($t5)
	sw $t1, 264($t5)
	sw $t1, 252($t5)
	sw $t1, 248($t5)
	sw $t1, -260($t5)
	sw $t1, -264($t5)
	sw $t1, -252($t5)
	sw $t1, -248($t5)
	
	li $t1, black
	sw $t1, 0($t5)
	
	jr $ra
draw_m1: #fast one  (on the 512 line.... min 520, max 760)
	li $t0, BASE_ADDRESS
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	add $t5, $t0, $t2
	
	li $t1, m1c
	sw $t1, -256($t5)
	sw $t1, 256($t5)
	sw $t1, 260($t5)
	sw $t1, 4($t5)
	sw $t1, -4($t5)
	sw $t1, 516($t5)
	sw $t1, 508($t5)
	sw $t1, -516($t5)
	sw $t1, -508($t5)
	sw $t1, 264($t5)
	sw $t1, 252($t5)
	sw $t1, 248($t5)
	sw $t1, -260($t5)
	sw $t1, -264($t5)
	sw $t1, -252($t5)
	sw $t1, -248($t5)
	
	li $t1, charC3
	sw $t1, 0($t5)
	
	jr $ra


meteor_fall:
	li $t0, BASE_ADDRESS
	
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	
	jal black_m1
	
	addi $t2, $t2, 256
	
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	
	jal draw_m1
	
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


track_gravity:
	li $t0, BASE_ADDRESS	
	addi $t5, $s0, 1028
	add  $t5, $t5, $t0
	
	li $t1, base_out
	lw $t6, 0($t5)
	
	beq $t1, $t6, jump_cont # check if player is in sky
	
	addi $t5, $s0, 1020
	add  $t5, $t5, $t0
	
	li $t1, base_out
	lw $t6, 0($t5)
	
	beq $t1, $t6, jump_cont# check if player is in sky
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal draw_ground_sky
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal remove_prev_char
	
	addi $s0, $s0, 256
	
	add $t3, $zero, $s0
	addi $sp, $sp, -4
	sw $s0 0($sp)
	
	jal draw_char
	
	
exit_grav: #character has been moved down one space
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	j cont1
	
jump_cont: # if player not in sky
	jr $ra

check_meteor:
	li $t0, BASE_ADDRESS
	
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	
	addi $t5, $t2, 768
	add  $t5, $t5, $t0
	
	li $t1, base_out
	lw $t6, 0($t5)
	
	beq $t1, $t6, meteor_B
	li $t1, m2c
	beq $t1, $t6, meteor_B
	
	jr $ra

meteor_B:	
	add $t3, $zero, $s1
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal black_m1
	
	addi $t2, $t2, 44
	
	add $t3, $zero, $s3
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal black_m1
	
	addi $t2, $t2, 52
	
	add $t3, $zero, $s4
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal black_m1
	
	addi $t2, $t2, 60
	
	add $t3, $zero, $s5
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal black_m1
	
	addi $t2, $t2, 60
	
	add $t3, $zero, $s6
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal black_m1
	
	addi $s1,$zero, 532
	addi $s3,$zero, 576
	addi $s4,$zero, 628
	addi $s5,$zero, 688
	addi $s6,$zero, 748
	
	j cont2


check_lava_death:
	li $t0, BASE_ADDRESS	
	addi $t5, $s0, 1028
	add  $t5, $t5, $t0
	
	li $t1, fire_out
	lw $t6, 0($t5)
	
	beq $t1, $t6, ju_end
	
	jr $ra


ju_end:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal respond_to_p


check_player_hit:
	li $t0, BASE_ADDRESS
	
	addi $t5, $s0, -520 #Spot 1
	add  $t5, $t5, $t0
	
	li $t1, m1c
	lw $t6, 0($t5)
	
	beq $t1, $t6, p_hit_met
	
	addi $t5, $s0, -504 #Spot 2
	add  $t5, $t5, $t0
	
	li $t1, m1c
	lw $t6, 0($t5)
	
	beq $t1, $t6, p_hit_met
	
	addi $t5, $s0, -772 #Spot 3
	add  $t5, $t5, $t0
	
	li $t1, m1c
	lw $t6, 0($t5)
	
	beq $t1, $t6, p_hit_met
	
	addi $t5, $s0, -764 #Spot 4
	add  $t5, $t5, $t0
	
	li $t1, m1c
	lw $t6, 0($t5)
	
	beq $t1, $t6, p_hit_met
	
	
	addi $t5, $s0, 8 #Spot 1 -BOOST
	add  $t5, $t5, $t0
	
	li $t1, m2c
	lw $t6, 0($t5)
	
	beq $t1, $t6, p_hit_boost
	
	addi $t5, $s0, -8 #Spot 2 - BOOST
	add  $t5, $t5, $t0
	
	li $t1, m2c
	lw $t6, 0($t5)
	
	beq $t1, $t6, p_hit_boost
	
	jr $ra

p_hit_met:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal respond_to_p
	

p_hit_boost:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	add $t3, $zero, 14248
	addi $sp, $sp, -4
	sw $t3, 0($sp)	
	
	jal black_mushroom
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	addi $s2, $s2, 8
	jr $ra
	
	
#Use t9 as counter
main:  
	jal draw_map_ground
	jal draw_lava
	
	jal draw_ground_sky
	
	add $t3, $zero, 14248
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal draw_mushroom
	
	addi $s0, $zero,11648
	
	addi $s2, $zero, 4
	
	add $t3, $zero, $s0
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_char
	
#RESET METEOR	
	addi $s1,$zero, 532
	addi $s3,$zero, 576
	addi $s4,$zero, 628
	addi $s5,$zero, 688
	addi $s6,$zero, 748
	
	
	add $t3, $zero, $s1
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_m1
	
	
	add $t3, $zero, $s3
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_m1
	
	add $t3, $zero, $s4
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_m1
	
	add $t3, $zero, $s5
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_m1
	
	add $t3, $zero, $s6
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal draw_m1
	
	
main_loop:
	la $t9, counter
	lw $t7, 0($t9)
	addi $t8, $zero, 2000
	bne $t7, $t8, cont3
	
	addi $t8, $zero, 0
	sw $t8, 0($t9)
	
	la $t6, on
	lw $t5, 0($t6)
	addi $t8, $zero, 0
	bne $t5, $t8, else32
	
	jal draw_ground_sky
	j cont3
	
else32:	
	jal ground_sky_black
	#lw$t5, 0($t4)# $t5 = B[i]
	#sw$t5, 0($t3)# A[i] = $t5
cont3:
	la $t9, counter
	lw $t7, 0($t9)
	
	addi $t8, $t7, 1
	sw $t8, 0($t9)
	
	jal track_gravity
	jal check_char_move
	
	#addi $t3, $zero, 3428
	#addi $sp, $sp, -4
	#sw $t3, 0($sp)
	
	#jal draw_m1
	
	#addi $t3, $zero, 6244
	#addi $sp, $sp, -4
	#sw $t3, 0($sp)
	
	#jal draw_m2
	
cont1:	
	add $t3, $zero, $s1
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal check_meteor
	
	add $t3, $zero, $s3
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal check_meteor
	
	add $t3, $zero, $s4
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal check_meteor
	
	add $t3, $zero, $s5
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal check_meteor
	
	add $t3, $zero, $s6
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal check_meteor
	
	
	####
	
	
	add $t3, $zero, $s3
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal meteor_fall
	add $s3, $s3, 256
	
	add $t3, $zero, $s4
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal meteor_fall
	add $s4, $s4, 256
	
	add $t3, $zero, $s5
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal meteor_fall
	add $s5, $s5, 256
	
	add $t3, $zero, $s6
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal meteor_fall
	add $s6, $s6, 256
	
	
	add $t3, $zero, $s1
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	jal meteor_fall
	add $s1, $s1, 256
	
	jal check_player_hit
	
	
cont2:	jal check_lava_death
	
	li $v0, 32
	li $a0, 40 # 40 recommeneded
	syscall
	
	j main_loop
	
game_finished:	

	li $v0, 10 #Game end
	syscall
