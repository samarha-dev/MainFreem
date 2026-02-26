      *===============================================================
      * Exemple : Hello, Monde !
      * Compiler : cobc -x hello.cobol -o hello
      * Executer : ./hello
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       PROCEDURE DIVISION.
           DISPLAY '================================'.
           DISPLAY '  MainFreem - Environnement COBOL'.
           DISPLAY '  GNU COBOL 4.0'.
           DISPLAY '================================'.
           DISPLAY 'Bonjour, le monde !'.
           DISPLAY '================================'.
           STOP RUN.
