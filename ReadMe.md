MENU MISSIONI PUBLIC SOURCE CODE
1. Questo codice integrerà in una rom Pokémon - Fire Red (U) v 1.0 un menù per delle missioni.
2. Sviluppato inizialmente da koople e pubblicato sulla pagina github di ghoulslash https://github.com/ghoulslash/Quest-Menu
3. Questa è una versione rivista e corretta, dove vengono risolti tutti i bug che affliggevano la versione pubblicata sul github di ghoulslash. Si ringrazia Andrea per aver risolto un bug grafico che non riuscivo a risolvere da solo.

Features:
1. Tramite l'impostazione di un byte è possibile convertire il pc strumenti in un menù missione
2. Possibilità di sbloccare le missioni tramite variabile (personalizzabile). Le missioni sconosciute appariranno come '??????'
3. Possibilità di impostare una descrizione con tanto di immagine oggetto accanto (vedi src/description.asm)
4. Possibilità di attivare una missione e controllare il suo stato di completamento (grazie Andrea per risoluzione bug grafico)
5. Possibilità di includere dei dettagli missione visualizzabili tramite mini menù
6. Completa traduzione della funzione originale in italiano
7. Cambiamento della meccanica di koople, risparmiando così flag

Compilazione:
1. Installare GNU make e DevkitARM (see pokecommunity forums for further detail)
2. Inserire una rom rinominata bpre0.gba nella cartella principale
3. Aprire il file "insert.s" andare a fine pagine e nella stringa ".org 0x08990000" mettere il proprio offset
4. Scegliere il numero della flag che attiva i nomi delle missioni (una volta attiva al posto di ??????? sarà visualizzato il nome e si potrà interagire con la missione). La flag da indicare è quella per la prima missione. Saranno impostate in automatico le flag successive per le altre missioni.
Di base è impostata la flag 0x200 e successive. Se si intende modificare tale flag recarsi ai percorsi.
4a. src/quest_name.asm, cercare la dicitura
	mov r0, #0x80
	lsl r0, #0x2

che corrisponde alla flag 200 e cambiarla con la flag che più si preferisce.

4b. src/quest_prevent_a.asm (in questo caso il registro usato è r1)
4c. src/quest_descriptions.asm (in questo caso il registro usato è r1)
5. Aprire il file src/headers/defs.asm e modificare i parametri in questo modo:
  5a. QuestFlag: indicare un offset della ram libero per 1 byte. Se il byte è 0x0 allora il menù sarà quello normale del pc strumenti, con 0x1 verrà sostituito con il menù missioni.
  5b. ActiveQuest: indicare un offset della ram libero, la lunghezza è 1 byte per ogni missione. Questo byte determinerà se la missione non è stata ancora iniziata dal giocatore (valore 0x0), se è stata intrapresa (valore 0x1), se è stata completata (valore 0x2). Ogni missione occupa 1 byte.
6. Scegliere il numero di Missioni e cambiare i seguenti parametri. Di base sono impostate 8 missioni:
6a. Aprire il file src/quest_name.asm e cercare la dicitura "mov r5, #0x8 @NumQuests". Al posto di 0x8 inserire il numero totale delle missioni che si desidera.
6b. Aprire il file src/quest_num.asm e cercare la dicitura "mov r0, #0x8 @NumQuests". Al posto di 0x8 inserire il numero totale delle missioni che si desidera.
7. Inserire tramite xse i vari nomi delle Missioni (per intenderci andranno a sostituire i nomi degli strumenti) nella rom ed annotarsi gli offset. Inserire questi offset infondo al file src/quest_names.asm costruendo una tabella. Nel file è riportato già un esempio per facilitare l'inserimento.
8. Creare una tabella affine nel file src/quest_descriptions.asm con la descrizione delle missioni (ex descrizione strumenti) ed una con le immagini dei vari strumenti da visualizzare a sinistra. Già presente una tabella di esempio.
9. In src/quest_selected.asm ripetere la stessa operazione per i dettagli della missione. Selezionando una missione è possibile, nel menù che compare, selezionare la voce "Dettagli", per indicare, per esempio, il luogo o altre info. Già presente una tabella di esempio.
10. Dalla cartella principale aprire il prompt dei comandi e digitare "make" senza le virgolette.

Come si Usa:
1. In uno script (XSE):
	writebytetooffset 0x1 0x[Indirizzo_QuestFlag]   // attiva il menù missioni
	
	fadescreen 0x1
	
	callasm 0x80EBCD9       // apre il menù
	
	waitstate
	
2. Non c'è bisogno di resettare l'Indirizzo_QuestFlag, una volta usciti fa tutto in automatico.

3. Per rendere una Missione Completata, in uno script (XSE):
	writebytetooffset 0x2 0x[Indirizzo_ActiveQuest +il numero della missione]
Una volta riaperto il menù delle missioni comparirà la scritta "Fatto" accanto alla missione e non sarà più selezionabile.

Crediti:
koople - idea originale e base su cui sono partito
ghoulslash - per aver pubblicato il codice
Andrea - per la risoluzione di un bug grafico
eMMe - correzione errori e riadattamento funzione di koople
