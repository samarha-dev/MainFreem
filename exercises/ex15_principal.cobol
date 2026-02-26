      *===============================================================
      * Exercice 15 - Architecture modulaire : CALL
      * Niveau : Expert
      * Compiler les 3 fichiers dans cet ordre :
      *   cobc -c ex15_validemp.cobol -o ex15_validemp.o
      *   cobc -c ex15_calcsal.cobol  -o ex15_calcsal.o
      *   cobc -x ex15_principal.cobol ex15_validemp.o ex15_calcsal.o
      * Executer : ./ex15_principal
      *===============================================================

      *==============================================================
      * PROGRAMME PRINCIPAL
      *==============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX15-PRINCIPAL.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-RETOUR       PIC S9(4) COMP VALUE 0.

       01 WS-EMPLOYE.
          05 EMP-MATRICULE PIC X(6).
          05 EMP-NOM       PIC X(20).
          05 EMP-PRENOM    PIC X(15).
          05 EMP-SALAIRE   PIC 9(6)V99.
          05 EMP-ANCIENNETE PIC 9(2).

       01 WS-PAIE.
          05 PAI-BRUT      PIC 9(8)V99.
          05 PAI-CHARGES   PIC 9(8)V99.
          05 PAI-NET       PIC 9(8)V99.
          05 PAI-PRIME     PIC 9(6)V99.

       PROCEDURE DIVISION.
           DISPLAY '================================'.
           DISPLAY '  Exercice 15 - Architecture CALL'.
           DISPLAY '================================'.

           PERFORM TRAITEMENT-EMPLOYE-1.
           PERFORM TRAITEMENT-EMPLOYE-2.
           PERFORM TRAITEMENT-EMPLOYE-INVALIDE.

           STOP RUN.

      *---------------------------------------------------------------
       TRAITEMENT-EMPLOYE-1.
           MOVE 'EMP001'   TO EMP-MATRICULE.
           MOVE 'MARTIN'   TO EMP-NOM.
           MOVE 'Sophie'   TO EMP-PRENOM.
           MOVE 3500.00    TO EMP-SALAIRE.
           MOVE 5          TO EMP-ANCIENNETE.

           CALL 'EX15-VALIDEMP' USING BY REFERENCE WS-EMPLOYE
                                      BY REFERENCE WS-RETOUR.

           IF WS-RETOUR = 0
               CALL 'EX15-CALCSAL' USING BY REFERENCE WS-EMPLOYE
                                         BY REFERENCE WS-PAIE
               PERFORM AFFICHER-RESULTAT
           ELSE
               DISPLAY 'EMP001 : Validation echouee code ' WS-RETOUR
           END-IF.

      *---------------------------------------------------------------
       TRAITEMENT-EMPLOYE-2.
           MOVE 'EMP004'   TO EMP-MATRICULE.
           MOVE 'THOMAS'   TO EMP-NOM.
           MOVE 'Pierre'   TO EMP-PRENOM.
           MOVE 4200.00    TO EMP-SALAIRE.
           MOVE 12         TO EMP-ANCIENNETE.

           CALL 'EX15-VALIDEMP' USING BY REFERENCE WS-EMPLOYE
                                      BY REFERENCE WS-RETOUR.

           IF WS-RETOUR = 0
               CALL 'EX15-CALCSAL' USING BY REFERENCE WS-EMPLOYE
                                         BY REFERENCE WS-PAIE
               PERFORM AFFICHER-RESULTAT
           ELSE
               DISPLAY 'EMP004 : Validation echouee code ' WS-RETOUR
           END-IF.

      *---------------------------------------------------------------
       TRAITEMENT-EMPLOYE-INVALIDE.
           DISPLAY ' '.
           DISPLAY '-- Test employe invalide (matricule vide) :'.
           MOVE SPACES   TO EMP-MATRICULE.
           MOVE SPACES   TO EMP-NOM.
           MOVE 0        TO EMP-SALAIRE.

           CALL 'EX15-VALIDEMP' USING BY REFERENCE WS-EMPLOYE
                                      BY REFERENCE WS-RETOUR.

           IF WS-RETOUR NOT = 0
               DISPLAY '  Employe invalide detecte. Code : ' WS-RETOUR
           END-IF.

      *---------------------------------------------------------------
       AFFICHER-RESULTAT.
           DISPLAY ' '.
           DISPLAY '-- ' EMP-PRENOM ' ' EMP-NOM
                   ' (' EMP-MATRICULE ') :'.
           DISPLAY '   Anciennete : ' EMP-ANCIENNETE ' ans'.
           DISPLAY '   Salaire brut  : ' PAI-BRUT ' EUR'.
           DISPLAY '   Prime         : ' PAI-PRIME ' EUR'.
           DISPLAY '   Charges (22%) : ' PAI-CHARGES ' EUR'.
           DISPLAY '   Salaire net   : ' PAI-NET ' EUR'.
