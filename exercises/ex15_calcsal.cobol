      *===============================================================
      * Sous-programme CALCSAL
      * Calcule les elements de paie d'un employe
      * Prime d'anciennete : 1% par annee, max 15%
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX15-CALCSAL.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TAUX-PRIME     PIC 9V99 VALUE 0.
       01 WS-TAUX-CHARGES   PIC 9V99 VALUE 0.22.

       LINKAGE SECTION.
       01 LS-EMPLOYE.
          05 LS-MATRICULE   PIC X(6).
          05 LS-NOM         PIC X(20).
          05 LS-PRENOM      PIC X(15).
          05 LS-SALAIRE     PIC 9(6)V99.
          05 LS-ANCIENNETE  PIC 9(2).

       01 LS-PAIE.
          05 LS-BRUT        PIC 9(8)V99.
          05 LS-CHARGES     PIC 9(8)V99.
          05 LS-NET         PIC 9(8)V99.
          05 LS-PRIME       PIC 9(6)V99.

       PROCEDURE DIVISION USING LS-EMPLOYE LS-PAIE.

           COMPUTE WS-TAUX-PRIME = LS-ANCIENNETE * 0.01.
           IF WS-TAUX-PRIME > 0.15
               MOVE 0.15 TO WS-TAUX-PRIME
           END-IF.

           COMPUTE LS-PRIME   = LS-SALAIRE * WS-TAUX-PRIME.
           COMPUTE LS-BRUT    = LS-SALAIRE + LS-PRIME.
           COMPUTE LS-CHARGES = LS-BRUT * WS-TAUX-CHARGES.
           COMPUTE LS-NET     = LS-BRUT - LS-CHARGES.

           GOBACK.
