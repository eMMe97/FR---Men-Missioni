.text
.align 2
.thumb
.thumb_func
.global quest_status

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

quest_status:
mov r0, r4
ldr r1, =QuestFlag
ldrb r1, [r1]
cmp r1, #0x0
bne CheckActive

ItemCount:
bl CountPCItems
ldr r1, =(0x0810da68 +1)
bx r1

CountPCItems:
ldr r1, =(0x0810dd80 +1)
bx r1

CheckActive:
ldr r1, =ActiveQuest
ADD R1, R1, R4

ldrb r1, [r1]
CMP R1, #0x1
BEQ Active
CMP R1, #0x2
BEQ Complete

Null:
ldr r1, =(null_str)
b Decoder

Active:
ldr r1, =(active_str)
b Decoder

Complete:
ldr r1, =(complete_str)

Decoder:
ldr r4, =DisplayedString

MOV R0, R4
BL StringCopy

Return:
ldr r0, =(0x0810da82 +1)
bx r0

StringCopy:
LDR R2, = 0x08008D84+1
BX R2

active_str:
.hword Color
.byte C_dark_blue, A_, t_, t_, i_, v_, o_, 0xff

complete_str:
.hword Color
.byte C_dark_green, F_, a_, t_, t_, o_, 0xff

null_str:
.byte 0xff