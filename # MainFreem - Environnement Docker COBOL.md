# MainFreem - Environnement Docker COBOL

**MainFreem** est un environnement Docker complet pour le développement et l'exécution de programmes COBOL. Il permet de créer et tester des applications COBOL dans un environnement isolé et portable.

## Fonctionnalités

- **Environment COBOL complet** : GNU Cobol 4.0 intégré
- **Dockerization** : Environnement isolé et portable
- **Exemples prêts à l'emploi** : Programmes de base pour démarrer
- **Facile à utiliser** : Commandes simples pour compiler et exécuter
- **Idéal pour l'apprentissage** : Environnement complet pour les développeurs COBOL

## Caractéristiques

- Compilation et exécution de programmes COBOL
- Environnement de développement intégré
- Support des standards COBOL 85, 2002 et 2014
- Image Docker légère et optimisée
- Scripts utilitaires pour le développement

## Utilisation

1. Clonez le dépôt
2. Construisez l'image Docker : `docker build -t mainfreem-cobol .`
3. Exécutez l'environnement : `docker run -it --rm mainfreem-cobol`
4. Compilez vos programmes COBOL avec `cobc -x programme.cobol`
5. Exécutez avec `./programme`

## Pourquoi MainFreem ?

MainFreem est conçu pour fournir un environnement COBOL complet et facile à utiliser pour :
- Les développeurs débutants en COBOL
- Les développeurs expérimentés qui veulent un environnement portable
- Les éducateurs et formateurs
- Les professionnels qui veulent tester des programmes COBOL sans configuration complexe

## Soutien

- Documentation GNU Cobol : https://gnucobol.sourceforge.io/
- Communauté COBOL : https://www.ibm.com/developerworks/cobol/