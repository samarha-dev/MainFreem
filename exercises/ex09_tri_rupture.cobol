      *===============================================================
      * Exercice 9 - Tri et traitement de rupture
      * Niveau : Intermediaire
      * Compiler : cobc -x ex09_tri_rupture.cobol -o ex09
      * Executer : ./ex09
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX09-TRI-RUPTURE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FIC-VENTES ASSIGN TO 'FIC-VENTES.dat'
               ORGANIZATION IS SEQUENTIAL.
           SELECT WRK-VENTES ASSIGN TO 'WRK-VENTES.tmp'.

       DATA DIVISION.
       FILE SECTION.
       FD  FIC-VENTES LABEL RECORDS ARE STANDARD.
       01  ENR-VENTES.
           05 VTE-REGION     PIC X(2).
           05 VTE-VENDEUR    PIC X(4).
           05 VTE-MONTANT    PIC 9(7).

       SD  WRK-VENTES.
       01  WRK-ENR.
           05 WRK-REGION     PIC X(2).
           05 WRK-VENDEUR    PIC X(4).
           05 WRK-MONTANT    PIC 9(7).

       WORKING-STORAGE SECTION.
       01 WS-FIN-FICHIER     PIC X VALUE 'N'.
          88 FIC-TERMINE     VALUE 'O'.

       01 WS-REGION-PREC     PIC X(2) VALUE SPACES.
       01 WS-VENDEUR-PREC    PIC X(4) VALUE SPACES.

       01 WS-TOTAL-VENDEUR   PIC 9(10) VALUE 0.
       01 WS-TOTAL-REGION    PIC 9(12) VALUE 0.
       01 WS-TOTAL-GENERAL   PIC 9(14) VALUE 0.

       01 WS-NB-VENDEURS     PIC 9(4)  VALUE 0.
       01 WS-NB-REGIONS      PIC 9(4)  VALUE 0.

       PROCEDURE DIVISION.
           PERFORM CREER-FICHIER-TEST.

           SORT WRK-VENTES
               ASCENDING KEY WRK-REGION WRK-VENDEUR
               USING  FIC-VENTES
               GIVING FIC-VENTES.

           OPEN INPUT FIC-VENTES.
           READ FIC-VENTES AT END SET FIC-TERMINE TO TRUE END-READ.

           IF NOT FIC-TERMINE
               MOVE VTE-REGION  TO WS-REGION-PREC
               MOVE VTE-VENDEUR TO WS-VENDEUR-PREC
           END-IF.

           DISPLAY '================================================'.
           DISPLAY '  RAPPORT DES VENTES PAR REGION ET VENDEUR'.
           DISPLAY '================================================'.

           PERFORM UNTIL FIC-TERMINE
               PERFORM TRAITEMENT-RUPTURE
               READ FIC-VENTES
                   AT END SET FIC-TERMINE TO TRUE
               END-READ
           END-PERFORM.

           PERFORM SOUS-TOTAL-VENDEUR.
           PERFORM SOUS-TOTAL-REGION.

           DISPLAY '================================================'.
           DISPLAY 'TOTAL GENERAL : ' WS-TOTAL-GENERAL ' EUR'.
           DISPLAY 'Regions       : ' WS-NB-REGIONS.
           DISPLAY 'Vendeurs      : ' WS-NB-VENDEURS.
           DISPLAY '================================================'.

           CLOSE FIC-VENTES.
           STOP RUN.

      *---------------------------------------------------------------
       TRAITEMENT-RUPTURE.
           IF VTE-REGION NOT = WS-REGION-PREC
               PERFORM SOUS-TOTAL-VENDEUR
               PERFORM SOUS-TOTAL-REGION
               MOVE VTE-REGION  TO WS-REGION-PREC
               MOVE VTE-VENDEUR TO WS-VENDEUR-PREC
           ELSE IF VTE-VENDEUR NOT = WS-VENDEUR-PREC
               PERFORM SOUS-TOTAL-VENDEUR
               MOVE VTE-VENDEUR TO WS-VENDEUR-PREC
           END-IF.
           ADD VTE-MONTANT TO WS-TOTAL-VENDEUR.
           ADD VTE-MONTANT TO WS-TOTAL-GENERAL.

      *---------------------------------------------------------------
       SOUS-TOTAL-VENDEUR.
           IF WS-TOTAL-VENDEUR > 0
               ADD 1 TO WS-NB-VENDEURS
               DISPLAY '  Vendeur ' WS-VENDEUR-PREC
                       ' : ' WS-TOTAL-VENDEUR ' EUR'
               MOVE 0 TO WS-TOTAL-VENDEUR
           END-IF.

      *---------------------------------------------------------------
       SOUS-TOTAL-REGION.
           IF WS-REGION-PREC NOT = SPACES
               ADD 1 TO WS-NB-REGIONS
               ADD WS-TOTAL-VENDEUR TO WS-TOTAL-REGION
               DISPLAY '------------------------------------------------'.
               DISPLAY '>> TOTAL REGION ' WS-REGION-PREC
                       ' : ' WS-TOTAL-REGION ' EUR'.
               DISPLAY '------------------------------------------------'.
               MOVE 0 TO WS-TOTAL-REGION
           END-IF.

      *---------------------------------------------------------------
       CREER-FICHIER-TEST.
           OPEN OUTPUT FIC-VENTES.
           MOVE 'ILVD01' TO VTE-REGION VTE-VENDEUR.
           MOVE 'IL' TO VTE-REGION. MOVE 'VD01' TO VTE-VENDEUR.
           MOVE 0015000 TO VTE-MONTANT. WRITE ENR-VENTES.
           MOVE 'IL' TO VTE-REGION. MOVE 'VD02' TO VTE-VENDEUR.
           MOVE 0022000 TO VTE-MONTANT. WRITE ENR-VENTES.
           MOVE 'IL' TO VTE-REGION. MOVE 'VD01' TO VTE-VENDEUR.
           MOVE 0008500 TO VTE-MONTANT. WRITE ENR-VENTES.
           MOVE 'PA' TO VTE-REGION. MOVE 'VD03' TO VTE-VENDEUR.
           MOVE 0031000 TO VTE-MONTANT. WRITE ENR-VENTES.
           MOVE 'PA' TO VTE-REGION. MOVE 'VD03' TO VTE-VENDEUR.
           MOVE 0012000 TO VTE-MONTANT. WRITE ENR-VENTES.
           MOVE 'PA' TO VTE-REGION. MOVE 'VD04' TO VTE-VENDEUR.
           MOVE 0019500 TO VTE-MONTANT. WRITE ENR-VENTES.
           MOVE 'LY' TO VTE-REGION. MOVE 'VD05' TO VTE-VENDEUR.
           MOVE 0028000 TO VTE-MONTANT. WRITE ENR-VENTES.
           CLOSE FIC-VENTES.
