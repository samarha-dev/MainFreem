FROM debian:bookworm-slim

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances COBOL
RUN apt-get update && apt-get install -y \
    gnucobol4 \
    build-essential \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Copier les exemples
COPY examples/ /app/examples/

# Commande par défaut
CMD ["cobc", "--version"]