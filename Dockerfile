# ============================================================
#  MainFreem — Environnement Docker COBOL
#  GNU COBOL 4.0  +  ocesql  +  PostgreSQL client
# ============================================================
#
#  Exercices 1-9  &  13-15 : GNU COBOL seul (aucun service ext.)
#  Exercices 10-12         : ocesql + PostgreSQL requis
#                            → lancer avec docker-compose (voir README)
# ============================================================

FROM debian:bookworm-slim

# ── Métadonnées ──────────────────────────────────────────────
LABEL maintainer="samarha-dev"
LABEL description="COBOL learning environment: GNU COBOL 4.0 + ocesql + PostgreSQL client"
LABEL version="2.0"

# ── Variables d'environnement ────────────────────────────────
ENV DEBIAN_FRONTEND=noninteractive
ENV OCESQL_VERSION=1.6.0
ENV PGHOST=postgres
ENV PGPORT=5432
ENV PGDATABASE=coboldb
ENV PGUSER=cobol
ENV PGPASSWORD=cobol123

# ── Dépendances système ──────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Compilateur COBOL
    gnucobol4 \
    # Outils de build (pour compiler ocesql depuis les sources)
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    # Client PostgreSQL (libpq pour ocesql + psql pour les tests)
    libpq-dev \
    postgresql-client \
    # Utilitaires généraux
    curl \
    wget \
    vim \
    nano \
    less \
    # Nettoyage
    && rm -rf /var/lib/apt/lists/*

# ── Compilation d'ocesql depuis les sources ──────────────────
#
#  ocesql est un précompilateur ESQL (Embedded SQL) pour GNU COBOL.
#  Il transforme les blocs EXEC SQL...END-EXEC en appels C,
#  puis GNU COBOL compile le tout.
#
#  Dépôt officiel : https://github.com/OCamlPro/ocaml-cobol-toolkit
#  Fork stable utilisé : https://github.com/tafujino/ocesql
#
RUN git clone --depth=1 --branch v${OCESQL_VERSION} \
        https://github.com/tafujino/ocesql.git /tmp/ocesql \
    || git clone --depth=1 \
        https://github.com/tafujino/ocesql.git /tmp/ocesql \
    && cd /tmp/ocesql \
    && autoreconf -i \
    && ./configure --prefix=/usr/local \
    && make -j"$(nproc)" \
    && make install \
    && ldconfig \
    && rm -rf /tmp/ocesql

# ── Répertoire de travail ─────────────────────────────────────
WORKDIR /workspace

# ── Copie des exemples et exercices ──────────────────────────
COPY examples/ /workspace/examples/

# ── Script d'aide à la compilation ───────────────────────────
#
#  compile.sh simplifie la compilation COBOL et COBOL+SQL
#
RUN cat > /usr/local/bin/compile.sh << 'EOF'
#!/bin/bash
# ─────────────────────────────────────────────────────────────
# compile.sh — Aide à la compilation COBOL / COBOL+SQL
# Usage :
#   compile.sh monprog.cobol          → compile COBOL pur
#   compile.sh monprog.pco            → précompile ESQL + compile
#   compile.sh monprog.pco -run       → compile et exécute
# ─────────────────────────────────────────────────────────────
set -e

if [ $# -eq 0 ]; then
    echo "Usage: compile.sh <fichier.cobol|fichier.pco> [-run]"
    exit 1
fi

FILE=$1
BASENAME="${FILE%.*}"
EXT="${FILE##*.}"
RUN_AFTER=false
[ "$2" = "-run" ] && RUN_AFTER=true

if [ "$EXT" = "pco" ] || [ "$EXT" = "sqb" ]; then
    echo "→ Précompilation ESQL avec ocesql..."
    ocesql "$FILE" "${BASENAME}.cob" 2>&1
    echo "→ Compilation GNU COBOL avec libpq..."
    cobc -x "${BASENAME}.cob" -locesql -lpq -o "${BASENAME}"
    echo "✓ Binaire créé : ./${BASENAME}"
else
    echo "→ Compilation GNU COBOL..."
    cobc -x "$FILE" -o "${BASENAME}"
    echo "✓ Binaire créé : ./${BASENAME}"
fi

if $RUN_AFTER; then
    echo "→ Exécution de ./${BASENAME}..."
    echo "────────────────────────────"
    "./${BASENAME}"
fi
EOF
RUN chmod +x /usr/local/bin/compile.sh

# ── Script de vérification de l'environnement ────────────────
RUN cat > /usr/local/bin/check-env.sh << 'EOF'
#!/bin/bash
echo "════════════════════════════════════════"
echo " MainFreem — Vérification de l'environnement"
echo "════════════════════════════════════════"
echo ""
echo "📦 GNU COBOL :"
cobc --version | head -1
echo ""
echo "📦 ocesql :"
ocesql --version 2>/dev/null || echo "  ⚠️  ocesql non trouvé (vérifier la compilation)"
echo ""
echo "📦 PostgreSQL client :"
psql --version
echo ""
echo "🔌 Connexion PostgreSQL :"
if psql -c "SELECT version();" > /dev/null 2>&1; then
    echo "  ✅ Connecté à ${PGHOST}:${PGPORT}/${PGDATABASE}"
else
    echo "  ⚠️  Non connecté — normal si lancé sans docker-compose"
    echo "     Pour les exercices SQL, utiliser : docker-compose up"
fi
echo ""
echo "📁 Répertoire de travail : $(pwd)"
echo "════════════════════════════════════════"
EOF
RUN chmod +x /usr/local/bin/check-env.sh

# ── Message de bienvenue ──────────────────────────────────────
RUN cat > /etc/motd << 'EOF'

╔══════════════════════════════════════════════════════════════╗
║          MainFreem — Environnement Docker COBOL              ║
║          GNU COBOL 4.0  +  ocesql  +  PostgreSQL             ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  Commandes utiles :                                          ║
║    check-env.sh          → vérifier l'environnement         ║
║    compile.sh prog.cobol → compiler un programme COBOL       ║
║    compile.sh prog.pco   → compiler un programme COBOL+SQL   ║
║    compile.sh prog.pco -run → compiler et exécuter           ║
║                                                              ║
║  Exercices 1-9 & 13-15 : cobc -x monprog.cobol               ║
║  Exercices 10-12 (SQL)  : compile.sh monprog.pco             ║
║                           (nécessite docker-compose up)      ║
║                                                              ║
║  Documentation : github.com/samarha-dev/MainFreem            ║
╚══════════════════════════════════════════════════════════════╝

EOF

# ── Port exposé (optionnel, pour outils web futurs) ───────────
EXPOSE 8080

# ── Point d'entrée ────────────────────────────────────────────
CMD ["bash", "--login"]
