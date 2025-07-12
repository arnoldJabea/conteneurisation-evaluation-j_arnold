

🐳 Conteneurisation


Auteur : Arnold Morel Jabea

Projet livré : deux services orchestrés par Docker Compose

Service	Image & rôle
database	MySQL 8 persistant dans ./data (bases docker_doc & docker_doc_dev)
client	PHP 8.2 Apache affichant la table article via PDO MySQL




	•	1 • Prérequis
	•	2 • Installation rapide (DEV)
	•	3 • Environnements
	•	4 • Commandes demandées
	•	4.1 • Bash interactif MySQL (Q2)
	•	4.2 • Vérifier la base & son contenu
	•	4.3 • Dump SQL sans session interactive (Q3)
	•	5 • Structure de la page Web
	•	6 • Sécurité / bonnes pratiques (Q8)
	•	7 • Arborescence & sources du dépôt
	•	8 • Versioning & fichiers ignorés
	•	Licence





⸻

1 • Prérequis

Logiciel	Version mini
Docker Desktop	4.x
Espace disque	≈ 4 Go


⸻

2 • Installation rapide (DEV)

git clone https://github.com/arnoldJabea/conteneurisation-evaluation-j_arnold.git
cd conteneurisation-evaluation-j_arnold
docker compose up -d           # lance DEV (variables .env)
open http://localhost:8080      # Windows : start http://localhost:8080


⸻

3 • Environnements

Environnement	Commande	root / db_client	Base utilisée	Affichage
DEV	docker compose up -d	root / password	docker_doc_dev	Bandeau « Environnement de développement », erreurs PHP visibles
PROD	docker compose --env-file .env.prod up -d	a-strong-password / another-strong-password	docker_doc	Bandeau masqué ; erreurs silencieuses

Arrêt : docker compose down (ajouter -v pour purger le volume MySQL).

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

Le fichier dump.sql (~ 2 Kio) est généré à la racine du projet.

⸻

5 • Structure de la page Web
	•	URL : http://localhost:8080
	•	client/src/index.php : lit les variables d’environnement, se connecte via PDO MySQL (user db_client), affiche la table article.
	•	DEV : bandeau + display_errors = On — PROD : bandeau masqué.

⸻

6 • Sécurité / bonnes pratiques (Q8)

Point	Explication
Variables d’environnement	Pratiques en dev mais exposables (docker inspect, logs).
Docker Secrets (prod)	Exemple : `printf “another-strong-password”
CVE	Scan Trivy (12-07-2025) : 1 CVE High (Debian). Mitigation : rebuild régulier ou image Alpine.


⸻

7 • Arborescence & sources du dépôt

.
├── client/           → Dockerfile + src/index.php
├── database/         → init.sql
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