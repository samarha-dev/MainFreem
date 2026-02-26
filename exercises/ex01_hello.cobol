      *===============================================================
      * Exercice 1 - Hello, Monde !
      * Niveau : Novice
      * Compiler : cobc -x ex01_hello.cobol -o ex01_hello
      * Executer : ./ex01_hello
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX01-HELLO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       PROCEDURE DIVISION.
           DISPLAY 'Bonjour, le monde !'.
           DISPLAY 'Bienvenue dans MainFreem - Environnement COBOL'.
           STOP RUN.
