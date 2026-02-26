# ============================================================
#  MainFreem — Environnement Docker COBOL v2.0
#  GNU COBOL 4.0  +  ocesql  +  PostgreSQL client
# ============================================================
#  Exercices 1-9  & 13-15 : GNU COBOL seul
#  Exercices 10-12         : ocesql + PostgreSQL (docker-compose)
# ============================================================

FROM debian:bookworm-slim

LABEL maintainer="samarha-dev"
LABEL description="COBOL learning environment: GNU COBOL 4.0 + ocesql + PostgreSQL client"
LABEL version="2.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV PGHOST=postgres
ENV PGPORT=5432
ENV PGDATABASE=coboldb
ENV PGUSER=cobol
ENV PGPASSWORD=cobol123

# ── Dépendances système ──────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnucobol4 \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    libpq-dev \
    postgresql-client \
    curl \
    vim \
    nano \
    less \
    && rm -rf /var/lib/apt/lists/*

# ── Compilation d'ocesql depuis les sources ──────────────────
RUN git clone --depth=1 https://github.com/tafujino/ocesql.git /tmp/ocesql \
    && cd /tmp/ocesql \
    && autoreconf -i \
    && ./configure --prefix=/usr/local \
    && make -j"$(nproc)" \
    && make install \
    && ldconfig \
    && rm -rf /tmp/ocesql

WORKDIR /workspace

COPY examples/ /workspace/examples/

# ── Script compile.sh ─────────────────────────────────────────
RUN cat > /usr/local/bin/compile.sh << 'EOF'
#!/bin/bash
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
    ocesql "$FILE" "${BASENAME}.cob"
    echo "→ Compilation GNU COBOL avec libpq..."
    cobc -x "${BASENAME}.cob" -locesql -lpq -o "${BASENAME}"
    echo "✓ Binaire : ./${BASENAME}"
else
    echo "→ Compilation GNU COBOL..."
    cobc -x "$FILE" -o "${BASENAME}"
    echo "✓ Binaire : ./${BASENAME}"
fi
$RUN_AFTER && "./${BASENAME}"
EOF
RUN chmod +x /usr/local/bin/compile.sh

# ── Script check-env.sh ───────────────────────────────────────
RUN cat > /usr/local/bin/check-env.sh << 'EOF'
#!/bin/bash
echo "════════════════════════════════════════════"
echo "  MainFreem — Vérification de l'environnement"
echo "════════════════════════════════════════════"
echo ""
echo "📦 GNU COBOL :"
cobc --version | head -1
echo ""
echo "📦 ocesql :"
ocesql --version 2>/dev/null || echo "  ⚠️  Non trouvé"
echo ""
echo "📦 PostgreSQL client :"
psql --version
echo ""
echo "🔌 Connexion PostgreSQL :"
if psql -c "SELECT 1;" > /dev/null 2>&1; then
    echo "  ✅ Connecté à ${PGHOST}:${PGPORT}/${PGDATABASE}"
else
    echo "  ⚠️  Non connecté (normal sans docker-compose)"
fi
echo ""
echo "════════════════════════════════════════════"
EOF
RUN chmod +x /usr/local/bin/check-env.sh

# ── Message de bienvenue ──────────────────────────────────────
RUN echo '\n\
╔══════════════════════════════════════════════════════╗\n\
║        MainFreem — Environnement Docker COBOL        ║\n\
║        GNU COBOL 4.0  +  ocesql  +  PostgreSQL       ║\n\
╠══════════════════════════════════════════════════════╣\n\
║  check-env.sh              → vérifier l'\''environnement║\n\
║  compile.sh prog.cobol     → compiler COBOL           ║\n\
║  compile.sh prog.pco       → compiler COBOL+SQL       ║\n\
║  compile.sh prog.pco -run  → compiler et exécuter     ║\n\
║                                                      ║\n\
║  Exercices : /workspace/exercises/                   ║\n\
║  Exemples  : /workspace/examples/                    ║\n\
╚══════════════════════════════════════════════════════╝\n'\
>> /etc/bash.bashrc

CMD ["bash"]
