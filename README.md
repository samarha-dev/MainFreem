# MainFreem - Environnement Docker COBOL

> Environnement Docker prêt à l'emploi pour apprendre et pratiquer le COBOL, du niveau novice à expert — sans aucune installation complexe.

![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)
![GNU COBOL](https://img.shields.io/badge/GNU_COBOL-4.0-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql&logoColor=white)
![ocesql](https://img.shields.io/badge/ocesql-1.6.0-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## Description

MainFreem est un environnement Docker préparé pour le développement et l'apprentissage du COBOL. Il contient :

* GNU COBOL 4.0 (compilateur COBOL)
* ocesql 1.6.0 (précompilateur SQL embarqué — équivalent libre du DB2 precompiler IBM)
* PostgreSQL 16 client (libpq + psql, pour les exercices SQL)
* Scripts utilitaires (`compile.sh`, `check-env.sh`)
* Exemples de programmes COBOL
* 15 exercices progressifs du niveau novice à expert

---

## Prerequisites

* [Docker](https://docs.docker.com/get-docker/) installé sur votre machine
* [Docker Compose](https://docs.docker.com/compose/install/) (uniquement pour les exercices SQL, exercices 10 à 12)

---

## Installation

### Pour les exercices COBOL pur (exercices 1 à 9, 13 à 15)

1. Clonez le dépôt :

```
git clone https://github.com/samarha-dev/MainFreem.git
cd MainFreem
```

2. Construire l'image Docker :

```
docker build -t mainfreem-cobol .
```

3. Lancer le conteneur :

```
docker run -it --rm -v $(pwd)/exercises:/workspace/exercises mainfreem-cobol
```

### Pour les exercices SQL (exercices 10 à 12)

Ces exercices nécessitent PostgreSQL. Utiliser `docker-compose` à la place :

1. Lancer COBOL + PostgreSQL ensemble :

```
docker-compose up -d
```

2. Se connecter au conteneur COBOL :

```
docker-compose exec cobol bash
```

3. Pour arrêter l'environnement :

```
docker-compose down
```

---

## Utilisation

### Vérifier l'environnement

```
check-env.sh
```

### Compiler un programme COBOL

```
cobc -x monprogramme.cobol
./monprogramme
```

### Compiler un programme COBOL + SQL embarqué

```
compile.sh monprogramme.pco
./monprogramme
```

### Script compile.sh

```
compile.sh monprog.cobol        # Compiler COBOL pur
compile.sh monprog.pco          # Précompiler ESQL + compiler
compile.sh monprog.pco -run     # Compiler et exécuter directement
```

### Accéder à PostgreSQL

```
psql -h postgres -U cobol -d coboldb
```

---

## Exercices COBOL

Le dossier `exercises/` contient **15 exercices progressifs** avec les fichiers `.cobol` et `.pco` prêts à compiler.

📄 **[Télécharger le PDF des exercices](./exercises/COBOL_Exercices_Progressifs.pdf)**

| Niveau | Exercices | Thèmes | Environnement |
|--------|-----------|--------|---------------|
| 🟢 Novice | 1 → 3 | Structure COBOL, variables, arithmétique | COBOL pur |
| 🟡 Débutant | 4 → 6 | IF/ELSE, boucles PERFORM, tableaux OCCURS | COBOL pur |
| 🟠 Intermédiaire | 7 → 9 | Fichiers séquentiels, écriture, tri, rupture | COBOL pur |
| 🔴 Avancé | 10 → 12 | SQL embarqué, curseurs, COMMIT/ROLLBACK | docker-compose |
| ⚫ Expert | 13 → 15 | ETL complet, débogage, architecture CALL | COBOL pur / docker-compose |

<details>
<summary><b>Partie 1 — Les Bases (Exercices 1-3)</b></summary>

* **ex01_hello.cobol** — Structure COBOL, DISPLAY, STOP RUN
* **ex02_variables.cobol** — WORKING-STORAGE, PIC, MOVE
* **ex03_arithmetique.cobol** — ADD, SUBTRACT, MULTIPLY, DIVIDE, COMPUTE

</details>

<details>
<summary><b>Partie 2 — Structures de Contrôle (Exercices 4-6)</b></summary>

* **ex04_conditions.cobol** — IF/ELSE imbriqués, END-IF, 88-levels
* **ex05_boucles.cobol** — PERFORM VARYING, TIMES, paragraphes
* **ex06_tableaux.cobol** — OCCURS, accès par indice, statistiques

</details>

<details>
<summary><b>Partie 3 — Fichiers Séquentiels (Exercices 7-9)</b></summary>

* **ex07_lecture_fichier.cobol** — FILE-CONTROL, READ, AT END
* **ex08_ecriture_fichier.cobol** — WRITE, STRING, formatage PIC Z
* **ex09_tri_rupture.cobol** — SORT, traitement de rupture, sous-totaux

</details>

<details>
<summary><b>Partie 4 — SQL Embarqué (Exercices 10-12) — nécessite docker-compose</b></summary>

* **ex10_select.pco** — EXEC SQL, SQLCA, SELECT INTO, SQLCODE
* **ex11_curseur.pco** — DECLARE CURSOR, OPEN, FETCH, CLOSE
* **ex12_transactions.pco** — INSERT, UPDATE, DELETE, COMMIT, ROLLBACK

</details>

<details>
<summary><b>Partie 5 — Expert (Exercices 13-15)</b></summary>

* **ex13_etl.pco** — ETL complet avec validation, rejets et reporting
* **ex14_debug.cobol** — 6 bugs intentionnels à identifier et corriger
* **ex15_principal.cobol + ex15_validemp.cobol + ex15_calcsal.cobol** — Architecture CALL

</details>

---

## Structure du projet

```
MainFreem/
├── Dockerfile                           # Image Docker v2.0
├── docker-compose.yml                   # Orchestration COBOL + PostgreSQL
├── LICENSE
├── README.md
├── sql/
│   └── init.sql                         # Tables + données de test PostgreSQL
├── exercises/
│   ├── ex01_hello.cobol                 # Exercice 1
│   ├── ex02_variables.cobol             # Exercice 2
│   ├── ex03_arithmetique.cobol          # Exercice 3
│   ├── ex04_conditions.cobol            # Exercice 4
│   ├── ex05_boucles.cobol               # Exercice 5
│   ├── ex06_tableaux.cobol              # Exercice 6
│   ├── FIC-EMPLOYES.dat                 # Fichier de données (ex. 7, 8)
│   ├── ex07_lecture_fichier.cobol       # Exercice 7
│   ├── ex08_ecriture_fichier.cobol      # Exercice 8
│   ├── ex09_tri_rupture.cobol           # Exercice 9
│   ├── ex10_select.pco                  # Exercice 10 (SQL)
│   ├── ex11_curseur.pco                 # Exercice 11 (SQL)
│   ├── ex12_transactions.pco            # Exercice 12 (SQL)
│   ├── ex13_etl.pco                     # Exercice 13 (SQL)
│   ├── ex14_debug.cobol                 # Exercice 14
│   ├── ex15_principal.cobol             # Exercice 15 - programme principal
│   ├── ex15_validemp.cobol              # Exercice 15 - sous-programme
│   ├── ex15_calcsal.cobol               # Exercice 15 - sous-programme
│   └── COBOL_Exercices_Progressifs.pdf  # PDF des énoncés
└── examples/
    └── hello.cobol                      # Premier exemple
```

---

## Exemples

Un exemple simple (`hello.cobol`) est fourni dans le dossier `examples/` :

```
cobc -x examples/hello.cobol -o hello
./hello
```

---

## Support

* Documentation GNU COBOL : https://gnucobol.sourceforge.io/
* Documentation ocesql : https://github.com/tafujino/ocesql
* Communauté COBOL : https://www.ibm.com/docs/en/cobol-zos
