.eqv BG_COLOR, 0x0F	 # light blue (0/7 red, 3/7 green, 3/3 blue)
.eqv VG_ADDR, 0x11000120
.eqv VG_COLOR, 0x11000140
.eqv BTNU_RD, 0x11001100
.eqv BTND_RD, 0x11001110
.eqv BTNR_RD, 0x11001120
.eqv BTNL_RD, 0x11001130

main:
    li sp, 0x10000     #initialize stack pointer
	  li s2, VG_ADDR     #load MMIO addresses 
	  li s3, VG_COLOR  
    li s4, 25 # this is the snake's x cor
    li s5, 35 # this is the snake's y cor
    li s6, 0 # apple x coord
    li s7, 0 # apply y coord

	# fill screen using default color
	call draw_background  # must not modify s2, s3
	
    j loop
	
loop:
	# check each button and move snake accordingly
    li s1, BTNU_RD 
    lw t1, 0(s1) #up button read
    li s1, BTND_RD
    lw t2, 0(s1) #down button read
    li s1, BTNR_RD
    lw t3, 0(s1) #right
    li s1, BTNL_RD
    lw t4, 0(s1) #left
    li t6, 1
    bne t1, t6, b0 #skip over if BTNU is pressed
         addi s5, s5, 1 #add one to the y cor
b0:  bne t2, t6, b1 # go to next if button is not pressed
	 addi s5, s5, -1
b1: bne t3, t6, b2 # go to next if button is not pressed
	 addi s4, s4, 1
b2:  bne t4, t6, b3 # go to next if button is not pressed 
    	 addi s4, s4, -1
    
    	# check proximity to apple/food
b3:    addi t5, s6, 1 # load x coord right of food
    bne t1, s4, b4 # check if snake matches x coord
    	bne s5, s7, b4 # check if snake matches y coord
    		call eat # calls eat function if x and y matches
b4:    addi t5, s6, -1
    bne t1, s4, b5
    	bne s5, s7, b5
    		call eat
b5:    addi t5, s7, 1
    bne t1, s5, b6
    	bne s4, s6, b6
    		call eat
b6:    addi t5, s7, -1
    bne t1, s5, b7
    	bne s4, s6, b7
    		call eat
    
b7:    call draw_dot
    
    beqz s11, loop



#ISR: #changes button direction
#    li s1, BTNU_RD 
#    lw t1, 0(s1) #up button read
#    li s1, BTND_RD
#    lw t2, 0(s1) #down button read
#    li s1, BTNR_RD
#    lw t3, 0(s1) #right
#    li s1, BTNL_RD
#    lw t4, 0(s1) #left
#    li t6, 1
#    bne t1, t6, b8 #skip over if BTNU is pressed
#         addi s5, s5, 1 #add one to the y cor
#b8:    bne t2, t6, b9 # go to next if button is not pressed
#	 addi s5, s5, -1
#b9:    bne t3, t6, b10 # go to next if button is not pressed
#	 addi s4, s4, 1
#b10:    bne t4, t6, b11 # go to next if button is not pressed 
#    	 addi s4, s4, -1
#b11:    ret
    

eat: ret

draw_dot:
	andi t0,a0,0x7F	# select bottom 7 bits (col)
	andi t1,a1,0x3F	# select bottom 6 bits  (row)
	slli t1,t1,7	#  {a1[5:0],a0[6:0]} 
	or t0,t1,t0	# 13-bit address
	sw t0, 0(s2)	# write 13 address bits to register
	sw a3, 0(s3)	# write color data to frame buffer
	ret

draw_background:
	addi sp,sp,-4
	sw ra, 0(sp)
	li a3, BG_COLOR	#use default color
	li a1, 0	#a1= row_counter
	li t4, 60 	#max rows
	ret
