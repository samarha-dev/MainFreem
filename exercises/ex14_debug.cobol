      *===============================================================
      * Exercice 14 - Debogage d'un programme
      * Niveau : Expert
      * Ce programme contient 6 bugs intentionnels a corriger.
      * Compiler : cobc -x ex14_debug.cobol -o ex14_debug
      * Executer : ./ex14_debug
      *
      * BUGS A TROUVER :
      *   Bug 1 - Ligne ~55  : boucle infinie potentielle
      *   Bug 2 - Ligne ~70  : division par zero possible
      *   Bug 3 - Ligne ~78  : variable non initialisee
      *   Bug 4 - Ligne ~85  : depassement de capacite PIC
      *   Bug 5 - Ligne ~95  : condition jamais vraie
      *   Bug 6 - Ligne ~105 : MOVE vers mauvais type
      *===============================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX14-DEBUG.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-COMPTEUR      PIC 9(3) VALUE 0.
       01 WS-TOTAL         PIC 9(5) VALUE 0.
       01 WS-MOYENNE       PIC 9(3)V99 VALUE 0.
       01 WS-MAX           PIC 9(3) VALUE 0.
       01 WS-VALEUR        PIC 9(3).
       01 WS-NOM           PIC X(10) VALUE SPACES.
       01 WS-CODE          PIC X(3)  VALUE SPACES.
       01 WS-I             PIC 9(3)  VALUE 0.

      * Tableau de test
       01 WS-TABLEAU.
          05 WS-VALS PIC 9(3) OCCURS 5 TIMES.

       PROCEDURE DIVISION.
           PERFORM INIT-TABLEAU.
           PERFORM BUG1-BOUCLE-INFINIE.
           PERFORM BUG2-DIVISION-ZERO.
           PERFORM BUG3-VAR-NON-INIT.
           PERFORM BUG4-DEPASSEMENT.
           PERFORM BUG5-CONDITION-FAUSSE.
           PERFORM BUG6-MAUVAIS-TYPE.
           DISPLAY 'Fin du programme'.
           STOP RUN.

      *---------------------------------------------------------------
       INIT-TABLEAU.
           MOVE 100 TO WS-VALS(1).
           MOVE 200 TO WS-VALS(2).
           MOVE 150 TO WS-VALS(3).
           MOVE 300 TO WS-VALS(4).
           MOVE 050 TO WS-VALS(5).

      *===============================================================
      * BUG 1 : La boucle ne s'arrete jamais correctement
      *   -> WS-I est reinitialise a 0 dans la boucle
      *===============================================================
       BUG1-BOUCLE-INFINIE.
           DISPLAY '--- Bug 1 : boucle'.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 5
               ADD WS-VALS(WS-I) TO WS-TOTAL
               MOVE 0 TO WS-I
           END-PERFORM.

      *===============================================================
      * BUG 2 : Division sans protection contre le zero
      *   -> WS-COMPTEUR reste a 0, division impossible
      *===============================================================
       BUG2-DIVISION-ZERO.
           DISPLAY '--- Bug 2 : division'.
           DIVIDE WS-TOTAL BY WS-COMPTEUR GIVING WS-MOYENNE.
           DISPLAY 'Moyenne : ' WS-MOYENNE.

      *===============================================================
      * BUG 3 : WS-VALEUR n'est pas initialisee avant utilisation
      *   -> valeur aleatoire en memoire
      *===============================================================
       BUG3-VAR-NON-INIT.
           DISPLAY '--- Bug 3 : variable non initialisee'.
           IF WS-VALEUR > 50
               DISPLAY 'Valeur > 50 : ' WS-VALEUR
           ELSE
               DISPLAY 'Valeur <= 50 : ' WS-VALEUR
           END-IF.

      *===============================================================
      * BUG 4 : Depassement de capacite
      *   -> PIC 9(3) ne peut pas contenir 1000
      *===============================================================
       BUG4-DEPASSEMENT.
           DISPLAY '--- Bug 4 : depassement'.
           MOVE 999 TO WS-MAX.
           ADD 1 TO WS-MAX.
           DISPLAY 'WS-MAX apres ajout : ' WS-MAX.

      *===============================================================
      * BUG 5 : La condition est structurellement toujours fausse
      *   -> WS-CODE contient 'ABC', on teste 'AB' (pas meme taille)
      *===============================================================
       BUG5-CONDITION-FAUSSE.
           DISPLAY '--- Bug 5 : condition'.
           MOVE 'ABC' TO WS-CODE.
           IF WS-CODE = 'AB'
               DISPLAY 'Code reconnu !'
           ELSE
               DISPLAY 'Code non reconnu (devrait etre reconnu)'
           END-IF.

      *===============================================================
      * BUG 6 : MOVE d'un numerique vers un PIC X sans conversion
      *   -> le contenu de WS-NOM sera incorrect
      *===============================================================
       BUG6-MAUVAIS-TYPE.
           DISPLAY '--- Bug 6 : type'.
           MOVE 42 TO WS-NOM.
           DISPLAY 'Nom contient : "' WS-NOM '"'.
           DISPLAY '(Attendu : "42" aligne a droite ou gauche ?)'.
