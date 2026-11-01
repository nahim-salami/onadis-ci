# onadis-ci

Dépôt relais de CI. Il ne contient **aucun code** : le workflow récupère le dépôt privé
(clé de déploiement en lecture seule), compile et teste, puis **chiffre** toute la sortie
(clé publique `keys/log_pub.pem`). Le journal public n'affiche que des compteurs.

Déclenchement manuel uniquement :

    gh workflow run build.yml -R nahim-salami/onadis-ci -f ref=<branche>

Lecture des journaux (poste détenteur de la clé privée) :

    bash scripts/open-logs.sh <run_id>
