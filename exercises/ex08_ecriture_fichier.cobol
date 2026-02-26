      *===============================================================
      * Exercice 8 - Ecriture et transformation de fichier
      * Niveau : Intermediaire
      * Compiler : cobc -x ex08_ecriture_fichier.cobol -o ex08
      * Executer : ./ex08
      * Entree  : FIC-EMPLOYES.dat
      * Sortie  : FIC-RAPPORT.txt (genere automatiquement)
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX08-ECRITURE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FIC-EMPLOYES ASSIGN TO 'FIC-EMPLOYES.dat'
               ORGANIZATION IS SEQUENTIAL.
           SELECT FIC-RAPPORT ASSIGN TO 'FIC-RAPPORT.txt'
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  FIC-EMPLOYES LABEL RECORDS ARE STANDARD.
       01  ENR-EMPLOYES.
           05 EMP-MATRICULE   PIC X(6).
           05 EMP-NOM         PIC X(20).
           05 EMP-PRENOM      PIC X(15).
           05 EMP-SALAIRE     PIC 9(6).
           05 EMP-STATUT      PIC X.

       FD  FIC-RAPPORT LABEL RECORDS ARE STANDARD.
       01  ENR-RAPPORT        PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-FIN-FICHIER      PIC X VALUE 'N'.
          88 FIC-TERMINE      VALUE 'O'.
       01 WS-COMPTEUR         PIC 9(4) VALUE 0.
       01 WS-NB-AUGMENTES     PIC 9(4) VALUE 0.
       01 WS-TOTAL-SALAIRES   PIC 9(10) VALUE 0.
       01 WS-SEUIL-AUGMENT    PIC 9(6) VALUE 2000.

       01 WS-LIGNE-RAPPORT.
           05 RPT-NUMERO      PIC ZZZ9.
           05 FILLER          PIC X(2) VALUE ' |'.
           05 RPT-NOM-COMPLET PIC X(36).
           05 FILLER          PIC X(2) VALUE ' |'.
           05 RPT-SALAIRE     PIC ZZ,ZZ9.
           05 FILLER          PIC X(4) VALUE ' EUR'.
           05 RPT-FLAG        PIC X(5).

       01 WS-LIGNE-TITRE.
           05 FILLER          PIC X(80)
               VALUE '=== RAPPORT EMPLOYES ============================'.

       01 WS-LIGNE-ENTETE.
           05 FILLER          PIC X(80)
               VALUE ' N  | Nom et Prenom                        | Sal'.

       PROCEDURE DIVISION.
           OPEN INPUT  FIC-EMPLOYES.
           OPEN OUTPUT FIC-RAPPORT.

           MOVE WS-LIGNE-TITRE   TO ENR-RAPPORT.
           WRITE ENR-RAPPORT.
           MOVE WS-LIGNE-ENTETE  TO ENR-RAPPORT.
           WRITE ENR-RAPPORT.
           MOVE WS-LIGNE-TITRE   TO ENR-RAPPORT.
           WRITE ENR-RAPPORT.

           READ FIC-EMPLOYES
               AT END SET FIC-TERMINE TO TRUE
           END-READ.

           PERFORM UNTIL FIC-TERMINE
               PERFORM TRAITEMENT-EMPLOYE
               READ FIC-EMPLOYES
                   AT END SET FIC-TERMINE TO TRUE
               END-READ
           END-PERFORM.

           MOVE WS-LIGNE-TITRE TO ENR-RAPPORT.
           WRITE ENR-RAPPORT.

           CLOSE FIC-EMPLOYES.
           CLOSE FIC-RAPPORT.

           DISPLAY '================================'.
           DISPLAY '  Rapport genere : FIC-RAPPORT.txt'.
           DISPLAY '  Employes traites  : ' WS-COMPTEUR.
           DISPLAY '  Employes augmentes: ' WS-NB-AUGMENTES.
           DISPLAY '================================'.
           STOP RUN.

      *---------------------------------------------------------------
       TRAITEMENT-EMPLOYE.
           ADD 1 TO WS-COMPTEUR.

           IF EMP-SALAIRE < WS-SEUIL-AUGMENT
               COMPUTE EMP-SALAIRE = EMP-SALAIRE * 1.05
               ADD 1 TO WS-NB-AUGMENTES
               MOVE ' (+5%)' TO RPT-FLAG
           ELSE
               MOVE SPACES TO RPT-FLAG
           END-IF.

           ADD EMP-SALAIRE TO WS-TOTAL-SALAIRES.

           MOVE WS-COMPTEUR TO RPT-NUMERO.
           STRING EMP-PRENOM DELIMITED SPACE
                  ' '        DELIMITED SIZE
                  EMP-NOM    DELIMITED SPACE
                  INTO RPT-NOM-COMPLET.
           MOVE EMP-SALAIRE TO RPT-SALAIRE.

           MOVE WS-LIGNE-RAPPORT TO ENR-RAPPORT.
           WRITE ENR-RAPPORT.
