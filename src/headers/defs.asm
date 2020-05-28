.text
.align 2
.thumb
.thumb_func
.global definitions

/*	CHANGE THESE	*/
.equ NumQuests, 0x5 @NON_MODIFICARE
.equ QuestFlag, 0x0203e000				@ free ram 1 byte -> 0x1 attiva la funzione
.equ ActiveQuest, 0x0203e001			@ free ram 0xNumQuest byte -> Stato della quest


.equ CurrentMap, 0x02036dfc
.equ DisplayedString, 0x02021d18
.equ var8007, 0x020370c6
.equ check_flag, 0x0806e6d0
.equ set_callback2, 0x08000544
