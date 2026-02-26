      *===============================================================
      * Exercice 7 - Lecture d'un fichier sequentiel
      * Niveau : Intermediaire
      * Compiler : cobc -x ex07_lecture_fichier.cobol -o ex07
      * Executer : ./ex07
      * Fichier  : FIC-EMPLOYES.dat doit etre dans le meme dossier
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX07-LECTURE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FIC-EMPLOYES ASSIGN TO 'FIC-EMPLOYES.dat'
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  FIC-EMPLOYES
           LABEL RECORDS ARE STANDARD.
       01  ENR-EMPLOYES.
           05 EMP-MATRICULE   PIC X(6).
           05 EMP-NOM         PIC X(20).
           05 EMP-PRENOM      PIC X(15).
           05 EMP-SALAIRE     PIC 9(6).
           05 EMP-STATUT      PIC X.

       WORKING-STORAGE SECTION.
       01 WS-FIN-FICHIER      PIC X VALUE 'N'.
          88 FIC-TERMINE      VALUE 'O'.
       01 WS-COMPTEUR         PIC 9(4) VALUE 0.
       01 WS-TOTAL-SALAIRES   PIC 9(10) VALUE 0.
       01 WS-SALAIRE-MOYEN    PIC 9(7)V99 VALUE 0.

       PROCEDURE DIVISION.
           PERFORM OUVERTURE-FICHIER.
           PERFORM LECTURE-PREMIERE.
           PERFORM TRAITEMENT UNTIL FIC-TERMINE.
           PERFORM AFFICHER-BILAN.
           PERFORM FERMETURE-FICHIER.
           STOP RUN.

      *---------------------------------------------------------------
       OUVERTURE-FICHIER.
           OPEN INPUT FIC-EMPLOYES.
           DISPLAY '================================'.
           DISPLAY '  Liste des employes'.
           DISPLAY '================================'.

      *---------------------------------------------------------------
       LECTURE-PREMIERE.
           READ FIC-EMPLOYES
               AT END SET FIC-TERMINE TO TRUE
           END-READ.

      *---------------------------------------------------------------
       TRAITEMENT.
           ADD 1 TO WS-COMPTEUR.
           ADD EMP-SALAIRE TO WS-TOTAL-SALAIRES.
           DISPLAY WS-COMPTEUR '. ' EMP-MATRICULE ' - '
                   EMP-PRENOM ' ' EMP-NOM
                   '  Salaire : ' EMP-SALAIRE ' EUR'.
           READ FIC-EMPLOYES
               AT END SET FIC-TERMINE TO TRUE
           END-READ.

      *---------------------------------------------------------------
       AFFICHER-BILAN.
           DISPLAY '================================'.
           DISPLAY 'Total employes  : ' WS-COMPTEUR.
           DISPLAY 'Total salaires  : ' WS-TOTAL-SALAIRES ' EUR'.
           IF WS-COMPTEUR > 0
               COMPUTE WS-SALAIRE-MOYEN =
                   WS-TOTAL-SALAIRES / WS-COMPTEUR
               DISPLAY 'Salaire moyen   : ' WS-SALAIRE-MOYEN ' EUR'
           END-IF.
           DISPLAY '================================'.

      *---------------------------------------------------------------
       FERMETURE-FICHIER.
           CLOSE FIC-EMPLOYES.
