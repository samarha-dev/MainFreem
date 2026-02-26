      *===============================================================
      * Exercice 5 - Boucles PERFORM
      * Niveau : Debutant
      * Compiler : cobc -x ex05_boucles.cobol -o ex05_boucles
      * Executer : ./ex05_boucles
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX05-BOUCLES.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NOMBRE    PIC 9(2) VALUE 7.
       01 WS-I         PIC 9(2) VALUE 0.
       01 WS-RESULT    PIC 9(5) VALUE 0.
       01 WS-FACTORIEL PIC 9(10) VALUE 1.

       PROCEDURE DIVISION.
           PERFORM AFFICHER-TABLE.
           PERFORM AFFICHER-CARRES.
           PERFORM CALCULER-FACTORIEL.
           STOP RUN.

      *---------------------------------------------------------------
       AFFICHER-TABLE.
           DISPLAY '================================'.
           DISPLAY '  Table de multiplication de ' WS-NOMBRE.
           DISPLAY '================================'.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 10
               COMPUTE WS-RESULT = WS-NOMBRE * WS-I
               DISPLAY WS-NOMBRE ' x ' WS-I ' = ' WS-RESULT
           END-PERFORM.

      *---------------------------------------------------------------
       AFFICHER-CARRES.
           DISPLAY ' '.
           DISPLAY '================================'.
           DISPLAY '  Carres des 10 premiers entiers'.
           DISPLAY '================================'.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 10
               COMPUTE WS-RESULT = WS-I * WS-I
               DISPLAY WS-I ' x ' WS-I ' = ' WS-RESULT
           END-PERFORM.

      *---------------------------------------------------------------
       CALCULER-FACTORIEL.
           DISPLAY ' '.
           DISPLAY '================================'.
           DISPLAY '  Factorielle de ' WS-NOMBRE.
           DISPLAY '================================'.
           MOVE 1 TO WS-FACTORIEL.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > WS-NOMBRE
               MULTIPLY WS-I BY WS-FACTORIEL
           END-PERFORM.
           DISPLAY WS-NOMBRE ' ! = ' WS-FACTORIEL.
