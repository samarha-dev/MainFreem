# MainFreem - Environnement Docker COBOL

Environnement Docker complet pour développer et exécuter des programmes COBOL.

## Description

MainFreem est un environnement Docker préparé pour le développement COBOL. Il contient :
- GNU Cobol 4.0 (compilateur COBOL)
- Environnement de développement COBOL
- Scripts utilitaires
- Exemples de programmes COBOL

## Prerequisites

- Docker installé sur votre machine

## Installation

1. Clonez le dépôt :
   ```bash
   git clone https://github.com/ton-utilisateur/MainFreem.git
   cd MainFreem
   ```

2. Construire l'image Docker :
   ```bash
   docker build -t mainfreem-cobol .
   ```

3. Lancer le conteneur :
   ```bash
   docker run -it --rm mainfreem-cobol
   ```

## Utilisation

Pour compiler un programme COBOL :
```bash
cobc -x monprogramme.cobol
```

Pour exécuter :
```bash
./monprogramme
```

## Exemples

Un exemple simple (hello.cobol) est fourni dans le dépôt.

## Support

- Documentation GNU Cobol : https://gnucobol.sourceforge.io/
- Communauté COBOL : https://www.ibm.com/developerworks/cobol/
