# Bitmap display starter code
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.eqv  BASE_ADDRESS 0x10008000
# $t0 stores the base address for display
# $t1 stores the red colour code
# $t2 stores the green colour code
# $t3 stores the blue colour code
.text
li $t0, BASE_ADDRESS
li $t1, 0xff0000
li $t2, 0x00ff00
li $t3, 0x0000ff
sw $t1, 0($t0)
sw $t2, 4($t0)
# paint the first (top-left) unit red.
# paint the second unit on the first row green. Why $t0+4?
sw $t3, 256($t0) # paint the first unit on the second row blue. Why +256?
li $v0, 10 # terminate the program gracefully syscall
