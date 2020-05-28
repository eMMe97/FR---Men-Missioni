.text
.align 2
.thumb
.thumb_func
.global selected_msg
/*
alter message that is displayed when an entry is selected in the quest menu
*/

.include "src/headers/chars.asm"
.include "src/headers/defs.asm"

selected_msg:
	ldrh r0, [r6, #0x2]
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	beq Itemsel
	
Questsel:
	ldr r1, =sel_str
	ldr r6, =(0x02021d18)
	mov r0, r6
	b ReturnDecoder
	
Itemsel:	
	bl GetItemID	
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	ldr r1, =(0x0810e2f4 +1)
	bx r1
	
ReturnDecoder:	
	ldr r2, =(0x0810e300 +1)
	bx r2
	
GetItemID:
	ldr r1, =(0x0810dd68 +1)
	bx r1
	
sel_str:
.byte S_, c_, e_, g_, l_, i_, Space, u_, n_, a_, Space, NewLine, O_, p_, z_, i_, o_, n_, e_, Dot, 0xff
