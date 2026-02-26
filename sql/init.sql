-- ============================================================
--  MainFreem — Initialisation PostgreSQL
--  Exercices COBOL/SQL (exercices 10, 11, 12, 13)
-- ============================================================

CREATE TABLE IF NOT EXISTS employes (
    matricule   CHAR(6)       NOT NULL PRIMARY KEY,
    nom         VARCHAR(20)   NOT NULL,
    prenom      VARCHAR(15)   NOT NULL,
    code_svc    CHAR(4),
    salaire     DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    statut      CHAR(1)       NOT NULL DEFAULT 'A'
);

CREATE TABLE IF NOT EXISTS services (
    code        CHAR(4)       NOT NULL PRIMARY KEY,
    libelle     VARCHAR(30)   NOT NULL,
    budget      DECIMAL(14,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS employes_charges (
    matricule      CHAR(6)       NOT NULL PRIMARY KEY,
    nom_complet    VARCHAR(36)   NOT NULL,
    code_svc       CHAR(4),
    libelle_svc    VARCHAR(30),
    salaire_brut   DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    salaire_charge DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

INSERT INTO services (code, libelle, budget) VALUES
    ('INFO', 'Informatique',        500000.00),
    ('COMR', 'Commercial',          300000.00),
    ('CMPT', 'Comptabilite',        250000.00),
    ('DRHS', 'Ressources Humaines', 200000.00),
    ('OPER', 'Operations',          450000.00)
ON CONFLICT (code) DO NOTHING;

INSERT INTO employes (matricule, nom, prenom, code_svc, salaire, statut) VALUES
    ('EMP001', 'MARTIN',  'Sophie',  'INFO', 3500.00, 'A'),
    ('EMP002', 'DUPONT',  'Jean',    'COMR', 2800.00, 'A'),
    ('EMP003', 'BERNARD', 'Marie',   'CMPT', 2600.00, 'A'),
    ('EMP004', 'THOMAS',  'Pierre',  'INFO', 4200.00, 'A'),
    ('EMP005', 'PETIT',   'Lucie',   'DRHS', 2400.00, 'A'),
    ('EMP006', 'ROBERT',  'Paul',    'OPER', 3100.00, 'A'),
    ('EMP007', 'RICHARD', 'Claire',  'COMR', 2900.00, 'A'),
    ('EMP008', 'DURAND',  'Antoine', 'INFO', 3800.00, 'A'),
    ('EMP009', 'MOREAU',  'Julie',   'CMPT', 2700.00, 'A'),
    ('EMP010', 'SIMON',   'Marc',    'OPER', 1800.00, 'A')
ON CONFLICT (matricule) DO NOTHING;

CREATE OR REPLACE VIEW v_masse_salariale AS
    SELECT
        s.code,
        s.libelle,
        COUNT(e.matricule)    AS nb_employes,
        SUM(e.salaire)        AS masse_salariale,
        SUM(e.salaire * 1.42) AS masse_chargee
    FROM services s
    LEFT JOIN employes e ON e.code_svc = s.code AND e.statut = 'A'
    GROUP BY s.code, s.libelle
    ORDER BY masse_chargee DESC;
