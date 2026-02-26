      *===============================================================
      * Exercice 3 - Operations Arithmetiques
      * Niveau : Novice
      * Compiler : cobc -x ex03_arithmetique.cobol -o ex03_arithmetique
      * Executer : ./ex03_arithmetique
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX03-ARITHMETIQUE.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-A        PIC 9(5) VALUE 150.
       01 WS-B        PIC 9(5) VALUE 40.
       01 WS-RESULT   PIC 9(10) VALUE ZEROS.
       01 WS-RESTE    PIC 9(5)  VALUE ZEROS.
       01 WS-RESULT-D PIC 9(5)V99 VALUE ZEROS.

       PROCEDURE DIVISION.
           DISPLAY '================================'.
           DISPLAY '  Operations Arithmetiques'.
           DISPLAY '  A = ' WS-A ' / B = ' WS-B.
           DISPLAY '================================'.

           ADD WS-A TO WS-B GIVING WS-RESULT.
           DISPLAY 'Addition        : ' WS-A ' + ' WS-B
                   ' = ' WS-RESULT.

           SUBTRACT WS-B FROM WS-A GIVING WS-RESULT.
           DISPLAY 'Soustraction    : ' WS-A ' - ' WS-B
                   ' = ' WS-RESULT.

           MULTIPLY WS-A BY WS-B GIVING WS-RESULT.
           DISPLAY 'Multiplication  : ' WS-A ' x ' WS-B
                   ' = ' WS-RESULT.

           DIVIDE WS-A BY WS-B GIVING WS-RESULT
               REMAINDER WS-RESTE.
           DISPLAY 'Division entiere: ' WS-A ' / ' WS-B
                   ' = ' WS-RESULT ' reste ' WS-RESTE.

           COMPUTE WS-RESULT-D = WS-A / WS-B.
           DISPLAY 'Division reelle : ' WS-A ' / ' WS-B
                   ' = ' WS-RESULT-D.

           DISPLAY '================================'.
           STOP RUN.
