      *===============================================================
      * Exercice 6 - Tableaux avec OCCURS
      * Niveau : Debutant
      * Compiler : cobc -x ex06_tableaux.cobol -o ex06_tableaux
      * Executer : ./ex06_tableaux
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX06-TABLEAUX.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TABLEAU.
          05 WS-NOTES    PIC 9(3) OCCURS 10 TIMES.

       01 WS-I           PIC 9(2) VALUE 0.
       01 WS-SOMME       PIC 9(6) VALUE 0.
       01 WS-MOYENNE     PIC 9(3)V99 VALUE 0.
       01 WS-MAX         PIC 9(3) VALUE 0.
       01 WS-MIN         PIC 9(3) VALUE 999.
       01 WS-IDX-MAX     PIC 9(2) VALUE 0.
       01 WS-IDX-MIN     PIC 9(2) VALUE 0.

       PROCEDURE DIVISION.
           PERFORM INITIALISER-NOTES.
           PERFORM CALCULER-STATS.
           PERFORM AFFICHER-RESULTATS.
           STOP RUN.

      *---------------------------------------------------------------
       INITIALISER-NOTES.
           MOVE 15 TO WS-NOTES(1).
           MOVE 12 TO WS-NOTES(2).
           MOVE 18 TO WS-NOTES(3).
           MOVE 09 TO WS-NOTES(4).
           MOVE 14 TO WS-NOTES(5).
           MOVE 17 TO WS-NOTES(6).
           MOVE 11 TO WS-NOTES(7).
           MOVE 08 TO WS-NOTES(8).
           MOVE 16 TO WS-NOTES(9).
           MOVE 13 TO WS-NOTES(10).

      *---------------------------------------------------------------
       CALCULER-STATS.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 10
               ADD WS-NOTES(WS-I) TO WS-SOMME
               IF WS-NOTES(WS-I) > WS-MAX
                   MOVE WS-NOTES(WS-I) TO WS-MAX
                   MOVE WS-I           TO WS-IDX-MAX
               END-IF
               IF WS-NOTES(WS-I) < WS-MIN
                   MOVE WS-NOTES(WS-I) TO WS-MIN
                   MOVE WS-I           TO WS-IDX-MIN
               END-IF
           END-PERFORM.
           COMPUTE WS-MOYENNE = WS-SOMME / 10.

      *---------------------------------------------------------------
       AFFICHER-RESULTATS.
           DISPLAY '================================'.
           DISPLAY '  Statistiques des notes'.
           DISPLAY '================================'.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 10
               DISPLAY 'Note ' WS-I ' : ' WS-NOTES(WS-I) '/20'
           END-PERFORM.
           DISPLAY '--------------------------------'.
           DISPLAY 'Somme   : ' WS-SOMME.
           DISPLAY 'Moyenne : ' WS-MOYENNE '/20'.
           DISPLAY 'Maximum : ' WS-MAX '/20 (eleve ' WS-IDX-MAX ')'.
           DISPLAY 'Minimum : ' WS-MIN '/20 (eleve ' WS-IDX-MIN ')'.
           DISPLAY '================================'.
