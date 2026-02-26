      *===============================================================
      * Exercice 2 - Variables et DISPLAY
      * Niveau : Novice
      * Compiler : cobc -x ex02_variables.cobol -o ex02_variables
      * Executer : ./ex02_variables
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX02-VARIABLES.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NOM        PIC X(20) VALUE SPACES.
       01 WS-AGE        PIC 9(3)  VALUE ZEROS.
       01 WS-VILLE      PIC X(30) VALUE SPACES.
       01 WS-SALAIRE    PIC 9(7)V99 VALUE ZEROS.

       PROCEDURE DIVISION.
           MOVE 'Jean Dupont'  TO WS-NOM.
           MOVE 28             TO WS-AGE.
           MOVE 'Paris'        TO WS-VILLE.
           MOVE 3500.50        TO WS-SALAIRE.

           DISPLAY '================================'.
           DISPLAY '  Fiche Employe'.
           DISPLAY '================================'.
           DISPLAY 'Nom     : ' WS-NOM.
           DISPLAY 'Age     : ' WS-AGE ' ans'.
           DISPLAY 'Ville   : ' WS-VILLE.
           DISPLAY 'Salaire : ' WS-SALAIRE ' EUR'.
           DISPLAY '================================'.
           STOP RUN.
