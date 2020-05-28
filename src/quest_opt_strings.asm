.text
.align 2
.thumb
.thumb_func
.global quest_opt_strings
/*
change the strings loaded in the multichoice when selecting an item in the quest menu
*/

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

quest_opt_strings:
	mov r5, #0x3
	str r5, [sp, #0x4]
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	bne QuestOptStrs
	
RegOptStrs:
	ldr r0, =(0x08453f74)
	b Return
	
QuestOptStrs:
	ldrh r1, [r6, #0x2]
	ldr r0, =var8007
	strh r1, [r0]

QuestOpts:
	ldr r0, =ActiveQuest
	push {r1}
	ldr r1, =var8007
	ldrb r1, [r1]
	add r0, r0, r1
	pop {r1}
	ldrb r0, [r0]
	cmp r0, #0x0
	bne Deactivate

Activate:	
	ldr r0, =Start_Opts
	b Return
	
Deactivate:
	ldr r0, =Stop_Opts
	
Return:
	str r0, [sp, #0x8]
	ldr r0, =(0x0810e2bc +1)
	bx r0

.align 2
Start_Opts:
.word start_str
.word 0
.word details_str
.word 0
.word chiudi_str
.word 0

.align 2
Stop_Opts:
.word stop_str
.word 0
.word details_str
.word 0
.word chiudi_str
.word 0

start_str:
.byte I_, n_, i_, z_, i_, a_, 0xff

stop_str:
.byte T_, e_, r_, m_, i_, n_, a_, 0xff

details_str:
.byte D_, e_, t_, t_, a_, g_, l_, i_, 0xff

chiudi_str:
.byte C_, h_, i_, u_, d_, i_, 0xff
	