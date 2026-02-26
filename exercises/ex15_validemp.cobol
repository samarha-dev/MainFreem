      *===============================================================
      * Sous-programme VALIDEMP
      * Valide un enregistrement employe
      * Code retour : 0=OK, 4=nom manquant, 8=matricule vide, 12=salaire nul
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX15-VALIDEMP.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       LINKAGE SECTION.
       01 LS-EMPLOYE.
          05 LS-MATRICULE   PIC X(6).
          05 LS-NOM         PIC X(20).
          05 LS-PRENOM      PIC X(15).
          05 LS-SALAIRE     PIC 9(6)V99.
          05 LS-ANCIENNETE  PIC 9(2).

       01 LS-RETOUR         PIC S9(4) COMP.

       PROCEDURE DIVISION USING LS-EMPLOYE LS-RETOUR.
           MOVE 0 TO LS-RETOUR.

           IF LS-MATRICULE = SPACES OR LS-MATRICULE = LOW-VALUES
               MOVE 8 TO LS-RETOUR
               GOBACK
           END-IF.

           IF LS-NOM = SPACES OR LS-NOM = LOW-VALUES
               MOVE 4 TO LS-RETOUR
               GOBACK
           END-IF.

           IF LS-SALAIRE = 0
               MOVE 12 TO LS-RETOUR
               GOBACK
           END-IF.

           GOBACK.
