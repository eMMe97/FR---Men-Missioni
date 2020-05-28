.text
.align 2
.thumb
.thumb_func
.global selected_string
/*
prevent bag_add_item, change message from 'withdrew fd 02' to something els
*/

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

selected_string:	
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	beq RegSel
	
QuestSel:
	ldrh r0, [r5, #0x2]
	ldr r1, =(0x0203ade6)
	ldrb r1, [r1]
	cmp r1, #0x1
	beq GetDetail
	add r0, #0x1
	ldr r4, =ActiveQuest
	ldr r1, =var8007
	ldrb r1, [r1]
	add r4, r4, r1
	ldrb r1, [r4]
	cmp r1, #0x1
	bne EndQuest
	
StartQuest:
	ldr r1, =(active_str)
	b Return
	
EndQuest:
	ldr r1, =(end_str)
	b Return
	
GetDetail:
	push {r4}
	mov r4, r0
	lsl r0, r0, #0x2
	ldr r1, =(deet_table)
	add r0, r0, r1
	ldr r1, [r0]
	mov r0, r4
	pop {r4}
	
Return:
	ldr r4, =DisplayedString
	ldr r0, =(0x0810e46a +1)
	bx r0
	
RegSel:
	ldrh r1, [r5, #0x10]
	mov r0, r4
	bl BagAddItem
	ldr r1, =(0x0810e43c +1)
	bx r1
		
BagAddItem:
	ldr r2, =(0x0809a084 +1)
	bx r2
	
active_str:
.hword Color
.byte C_dark_green, M_, i_, s_, s_, i_, o_, n_, e_, Space, A_, t_, t_, i_, v_, a_, t_, a_, Dot, 0xff

end_str:
.hword Color
.byte C_red, D_, i_, s_, a_, t_, t_, i_, v_, a_, z_, i_, o_, n_, e_, NewLine, i_, n_, Space, c_, o_, r_, s_, o_, Dot, Dot, Dot, 0xff

.pool
.align 2
deet_table:
.word 0x8FCBC61
.word 0x8FCBC9A
.word 0x8FCBCC6
.word 0x8FCBCDF
.word 0x8FCBD11

