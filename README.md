

# 🐳 Conteneurisation 

Auteur : Arnold Morel Jabea

Projet : deux services orchestrés par **Docker Compose**

| Service   | Image & rôle                                                                 |
|-----------|------------------------------------------------------------------------------|
| `database` | MySQL 8 (bases **docker_doc**, **docker_doc_dev**) – volume `./data`         |
| `client`   | PHP 8.2-apache : affiche la table **article** via PDO MySQL                  |

<!-- START doctoc -->
- [1 • Prérequis](#1-•-prérequis)
- [2 • Installation rapide (DEV)](#2-•-installation-rapide-dev)
- [3 • Environnements](#3-•-environnements)
- [4 • Commandes demandées](#4-•-commandes-demandées)
  - [4.1 • Bash interactif MySQL (Q2)](#41-•-bash-interactif-mysql-q2)
  - [4.2 • Vérifier la base & son contenu](#42-•-vérifier-la-base--son-contenu)
  - [4.3 • Dump SQL sans session interactive (Q3)](#43-•-dump-sql-sans-session-interactive-q3)
- [5 • Structure de la page Web](#5-•-structure-de-la-page-web)
- [6 • Sécurité / bonnes pratiques (Q8)](#6-•-sécurité--bonnes-pratiques-q8)
- [7 • Arborescence & sources du dépôt](#7-•-arborescence--sources-du-dépôt)
- [8 • Versioning & fichiers ignorés](#8-•-versioning--fichiers-ignorés)
- [Licence](#licence)
<!-- END doctoc -->

---

## 1 • Prérequis

| Logiciel         | Version mini |
|------------------|--------------|
| Docker Desktop   | ≥ 4.x        |
| Espace disque    | ≈ 4 Go       |

---

## 2 • Installation rapide (DEV)

```bash
git clone https://github.com/arnoldJabea/conteneurisation-evaluation-j_arnold.git
cd conteneurisation-evaluation-j_arnold

# Lancement DEV (variables du fichier .env)
docker compose up -d

# Application
open http://localhost:8080        # Windows : start http://localhost:8080


⸻

3 • Environnements

Env.	Commande	root / db_client	Base	Affichage
DEV	docker compose up -d	root / password	docker_doc_dev	Bandeau « Environnement de développement », erreurs PHP visibles
PROD	docker compose --env-file .env.prod up -d	a-strong-password / another-strong-password	docker_doc	Bandeau masqué, erreurs silencieuses

Arrêt : docker compose down (ajouter -v pour purger le volume).

⸻

4 • Commandes demandées

4.1 • Bash interactif MySQL (Q2)

docker compose exec database bash
mysql -u db_client -p"$MYSQL_PASSWORD" docker_doc_dev

4.2 • Vérifier la base & son contenu

SHOW DATABASES;
USE docker_doc_dev;
SHOW TABLES;
SELECT * FROM article;
EXIT;

4.3 • Dump SQL sans session interactive (Q3)

docker compose exec -T database \
  mysqldump --no-tablespaces -u db_client -p"$MYSQL_PASSWORD" docker_doc_dev > dump.sql


⸻

5 • Structure de la page Web
	•	URL : http://localhost:8080
	•	client/src/index.php lit les variables d’environnement, se connecte via PDO MySQL et affiche la table article.
	•	DEV : bandeau + display_errors = On — PROD : bandeau masqué.

⸻

6 • Sécurité / bonnes pratiques (Q8)

Sujet	Détail
Variables d’environnement	Pratiques en dev mais exposables (logs, docker inspect).
Docker Secrets (prod)	Exemple :`printf “another-strong-password”
CVE	Scan Trivy (12-07-2025) : 1 CVE High (Debian). Mitigation : rebuild régulier ou image Alpine.


⸻

7 • Arborescence & sources du dépôt

.
├── client/         # Dockerfile + src/index.php
├── database/       # init.sql
├── docker-compose.yml
├── .env / .env.prod
├── .gitignore / .dockerignore
└── README.md


⸻

8 • Versioning & fichiers ignorés

.env
.env.*
data/
dump.sql
*.log
.DS_Store

.dockerignore exclut .git, data/, dump.sql, fichiers Markdown…

⸻

Licence

MIT — 2025
