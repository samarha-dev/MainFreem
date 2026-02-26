      *===============================================================
      * Exercice 4 - Conditions IF / ELSE
      * Niveau : Debutant
      * Compiler : cobc -x ex04_conditions.cobol -o ex04_conditions
      * Executer : ./ex04_conditions
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX04-CONDITIONS.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NOTE      PIC 9(3) VALUE 14.
       01 WS-MENTION   PIC X(15) VALUE SPACES.
       01 WS-ADMIS     PIC X(3)  VALUE SPACES.

      * 88-levels : conditions nommees
       01 WS-STATUT    PIC X VALUE 'N'.
          88 ADMIS     VALUE 'O'.
          88 RECALE    VALUE 'N'.

       PROCEDURE DIVISION.
           DISPLAY '================================'.
           DISPLAY '  Calcul de mention'.
           DISPLAY '  Note : ' WS-NOTE '/20'.
           DISPLAY '================================'.

           IF WS-NOTE >= 16
               MOVE 'Tres Bien'    TO WS-MENTION
           ELSE IF WS-NOTE >= 14
               MOVE 'Bien'         TO WS-MENTION
           ELSE IF WS-NOTE >= 12
               MOVE 'Assez Bien'   TO WS-MENTION
           ELSE IF WS-NOTE >= 10
               MOVE 'Passable'     TO WS-MENTION
           ELSE
               MOVE 'Insuffisant'  TO WS-MENTION
           END-IF.

           IF WS-NOTE >= 10
               SET ADMIS TO TRUE
               MOVE 'OUI' TO WS-ADMIS
           ELSE
               SET RECALE TO TRUE
               MOVE 'NON' TO WS-ADMIS
           END-IF.

           DISPLAY 'Mention : ' WS-MENTION.
           DISPLAY 'Admis   : ' WS-ADMIS.
           DISPLAY '================================'.
           STOP RUN.
