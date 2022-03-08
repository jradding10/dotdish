
.eqv BG_COLOR, 0x0F	 # light blue (0/7 red, 3/7 green, 3/3 blue)
.eqv dot_color, 0xFF
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

    li s4, BTNU_RD  # button values
    li s5, BTND_RD  
    li s6, BTNR_RD 
    li s7, BTNL_RD 
    li a5, 25 # this is the snake's x cor
    li a6, 35 # this is the snake's y cor
    li a4, dot_color #dot color
	# fill screen using default color
    call draw_background  # must not modify s2, s3



loop: # get new x cors 
    
    lw s9, 0(s4) #up button read
    lw s10, 0(s5) #down button read
    lw s11, 0(s4) #right
    lw x31, 0(s5) #left

    beqz s9, b1#skip over if BTNU is pressed
    call del_snake
     addi a6, a6, 1
    
   b1: beqz s10, b2 #skip over if BTNU is pressed
   call del_snake
    addi a6, a6, -1
    
    b2:beqz s11, b3# go to next if button is not pressed
    call del_snake
     addi a5, a5, 1
    
    b3:beqz x31, b4 # go to next if button is not pressed 
    call del_snake
    addi a5, a5, -1
     
     b4: call draw_snake

    j loop

draw_dot:
       addi sp,sp,-4
       sw ra, 0(sp)
	andi t0,a0,0x7F	# select bottom 7 bits (col)
	andi t1,a1,0x3F	# select bottom 6 bits  (row)
	slli t1,t1,7	#  {a1[5:0],a0[6:0]} 
	or t0,t1,t0	# 13-bit address
	sw t0, 0(s2)	# write 13 address bits to register
	sw a3, 0(s3)	# write color data to frame buffer
	addi sp,sp,4
	ret

draw_snake:
        addi sp,sp,-4
        sw ra, 0(sp)
	andi t0,a5,0x7F	# select bottom 7 bits (col)
	andi t1,a6,0x3F	# select bottom 6 bits  (row)
	slli t1,t1,7	#  {a1[5:0],a0[6:0]} 
	or t0,t1,t0	# 13-bit address
	sw t0, 0(s2)	# write 13 address bits to register
	sw a4, 0(s3)	# write color data to frame buffer
	addi sp,sp,4
	ret
del_snake:
        addi sp,sp,-4
        sw ra, 0(sp)
	andi t0,a5,0x7F	# select bottom 7 bits (col)
	andi t1,a6,0x3F	# select bottom 6 bits  (row)
	slli t1,t1,7	#  {a1[5:0],a0[6:0]} 
	or t0,t1,t0	# 13-bit address
	sw t0, 0(s2)	# write 13 address bits to register
	sw a3, 0(s3)	# write color data to frame buffer
	addi sp,sp,4
	ret

# draws a horizontal line from (a0,a1) to (a2,a1) using color in a3
# Modifies (directly or indirectly): t0, t1, a0, a2
draw_horizontal_line:
	addi sp,sp,-4
	sw ra, 0(sp)
	addi a2,a2,1	#go from a0 to a2 inclusive
draw_horiz1:
	call draw_dot  # must not modify: a0, a1, a2, a3
	addi a0,a0,1
	bne a0,a2, draw_horiz1
	lw ra, 0(sp)
	addi sp,sp,4
	ret

# draws a vertical line from (a0,a1) to (a0,a2) using color in a3
# Modifies (directly or indirectly): t0, t1, a1, a2
draw_vertical_line:
	addi sp,sp,-4
	sw ra, 0(sp)
	addi a2,a2,1
draw_vert1:
	call draw_dot  # must not modify: a0, a1, a2, a3
	addi a1,a1,1
	bne a1,a2,draw_vert1
	lw ra, 0(sp)
	addi sp,sp,4
	ret

# Fills the 60x80 grid with one color using successive calls to draw_horizontal_line
# Modifies (directly or indirectly): t0, t1, t4, a0, a1, a2, a3
draw_background:
	addi sp,sp,-4
	sw ra, 0(sp)
	li a3, BG_COLOR	#use default color
	li a1, 0	#a1= row_counter
	li t4, 60 	#max rows
start:	li a0, 0
	li a2, 79 	#total number of columns
	call draw_horizontal_line  # must not modify: t4, a1, a3
	addi a1,a1, 1
	bne t4,a1, start	#branch to draw more rows
	lw ra, 0(sp)
	addi sp,sp,4
	ret




