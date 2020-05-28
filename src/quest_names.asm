.text
.align 2
.thumb
.thumb_func
.global quest_names
/*
show quest names instead of item names
*/

.include "src/headers/chars.asm"
.include "src/headers/defs.asm"

quest_names:
	push {r5, r6, r7}
	mov r4, #0x0
	mov r7, #0x0
	mov r5, #0x8 @NumQuests
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	ldr r6, =(QuestNames)
	cmp r0, #0x0
	bne LoadQuestName
	b LoadItemName
	
Aggiungi:
	add r7, r7, #0x1
	cmp r7, r5
	beq ReturnAddCancel
	
LoadQuestName:
	mov r0, #0x80
	lsl r0, #0x2
	add r0, r0, r7
	bl CheckFlag
	cmp r0, #0x0
	beq UnkownQuest

KnownQuest:
	mov r0, r6
	mov r1, #0x4
	mul r1, r1, r4
	add r0, r0, r1
	ldr r0, [r0]
	b SetPointer
	
UnkownQuest:
	ldr r0, =(q_null)
	
SetPointer:
	ldr r1, =(0x0203adc4)
	ldr r2, [r1]
	lsl r1, r4, #0x3
	add r1, r1, r2
	str r0, [r1]
	str r4, [r1, #0x4]
	add r0, r4, #0x1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10

NextItem:
	ldr r0, =(0x0203adbc)
	ldr r0, [r0]
	ldrb r0, [r0, #0x7]
	cmp r4, r0
	blo Aggiungi
	b ReturnAddCancel

LoadPCItem:
	ldr r0, =(0x03005008)
	ldr r0, [r0]
	ldr r1, =(0x00000298)
	add r6, r0, r1
	b ReturnAddCancel
	
LoadItemName:
	ldr r0, =0x203adbc
	ldr r0, [r0]
	ldrb r0, [r0, #0x7]
	cmp r4, r0
	blo boh
	b ReturnAddCancel

boh:
	ldr r0, =0x3005008
	ldr r0, [r0]
	lsl r1, r4, #0x2
	add r0, r0, r1
	mov r1, #0xa6
	lsl r1, r1, #0x2
	add r0, r0, r1
	ldrh r0, [r0]
	bl PCItemName
	ldr r1, =0x203adc4
	ldr r2, [r1]
	lsl r1, r4, #0x3
	add r1, r1, r2
	str r0, [r1]
	str r4, [r1, #0x4]
	add r0, r4, #0x1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	b LoadItemName
	
ReturnAddCancel:
	pop {r5, r6, r7}
	ldr r0, =(0x0810d8ae +1)
	bx r0
	
CheckFlag:
	ldr r1, =(0x0806e6d0 +1)
	bx r1

PCItemName:
	ldr r1, =(0x0809a8bc +1)
	bx r1

.align 2
QuestNames:
.word 0x8FCBB20
.word 0x8FCBB31
.word 0x8FCBB40
.word 0x8FCBB4F
.word 0x8FCBB6D

q_null:
.hword Color
.byte C_grey, QMark, QMark, QMark, QMark, QMark, QMark, QMark, QMark, 0xff
