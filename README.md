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
docker run -it --rm mainfreem-cobol
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

Affiche les versions installées et teste la connexion à PostgreSQL.

### Compiler un programme COBOL

```
cobc -x monprogramme.cobol
```

### Exécuter un programme COBOL

```
./monprogramme
```

### Compiler un programme COBOL + SQL embarqué

Les fichiers SQL embarqué utilisent l'extension `.pco` :

```
compile.sh monprogramme.pco
```

Ou manuellement, étape par étape :

```
ocesql monprogramme.pco monprogramme.cob
cobc -x monprogramme.cob -locesql -lpq -o monprogramme
./monprogramme
```

### Script compile.sh — référence rapide

```
compile.sh monprog.cobol        # Compiler un programme COBOL pur
compile.sh monprog.pco          # Précompiler ESQL + compiler
compile.sh monprog.pco -run     # Compiler et exécuter directement
```

### Accéder à PostgreSQL

```
psql -h postgres -U cobol -d coboldb
```

---

## Exercices COBOL

Le dossier `exercises/` contient **15 exercices progressifs** couvrant tous les niveaux.

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

* **Ex. 1** — Hello, Monde ! : première structure COBOL, DISPLAY, STOP RUN
* **Ex. 2** — Variables et DISPLAY : WORKING-STORAGE, PIC, MOVE
* **Ex. 3** — Opérations arithmétiques : ADD, SUBTRACT, MULTIPLY, DIVIDE, COMPUTE

</details>

<details>
<summary><b>Partie 2 — Structures de Contrôle (Exercices 4-6)</b></summary>

* **Ex. 4** — Conditions IF/ELSE : IF imbriqués, END-IF, 88-levels
* **Ex. 5** — Boucles PERFORM : VARYING, TIMES, UNTIL, paragraphes
* **Ex. 6** — Tableaux OCCURS : déclaration, accès par indice, INITIALIZE

</details>

<details>
<summary><b>Partie 3 — Fichiers Séquentiels (Exercices 7-9)</b></summary>

* **Ex. 7** — Lecture d'un fichier : FILE-CONTROL, FILE SECTION, READ, AT END
* **Ex. 8** — Écriture et transformation : WRITE, STRING, formatage PIC Z
* **Ex. 9** — Tri et rupture : SORT, traitement de rupture, sous-totaux

</details>

<details>
<summary><b>Partie 4 — SQL Embarqué (Exercices 10-12) — nécessite docker-compose</b></summary>

* **Ex. 10** — SELECT INTO : EXEC SQL, SQLCA, SQLCODE, variables hôtes
* **Ex. 11** — Curseur : DECLARE CURSOR, OPEN, FETCH, CLOSE
* **Ex. 12** — Modifications : INSERT, UPDATE, DELETE, COMMIT, ROLLBACK

</details>

<details>
<summary><b>Partie 5 — Expert (Exercices 13-15)</b></summary>

* **Ex. 13** — ETL complet : validation, SEARCH, chargement en base, reporting
* **Ex. 14** — Débogage : 6 bugs et 3 problèmes de performance à corriger
* **Ex. 15** — Architecture modulaire : CALL, LINKAGE SECTION, sous-programmes

</details>

---

## Structure du projet

```
MainFreem/
├── Dockerfile                           # Image Docker principale (v2.0)
├── docker-compose.yml                   # Orchestration COBOL + PostgreSQL
├── LICENSE
├── README.md
├── sql/
│   └── init.sql                         # Initialisation PostgreSQL (tables + données de test)
├── exercises/
│   └── COBOL_Exercices_Progressifs.pdf  # Les 15 exercices
└── examples/
    └── hello.cobol                      # Exemple de base
```

---

## Exemples

Un exemple simple (`hello.cobol`) est fourni dans le dossier `examples/`.

Pour le compiler et l'exécuter :

```
cobc -x examples/hello.cobol -o hello
./hello
```

---

## Support

* Documentation GNU COBOL : https://gnucobol.sourceforge.io/
* Documentation ocesql : https://github.com/tafujino/ocesql
* Communauté COBOL : https://www.ibm.com/docs/en/cobol-zos
