#!/usr/bin/env bash
# Chiffre un dossier de sortie : AES-256 (clé aléatoire) + clé AES chiffrée en RSA.
# Usage : seal.sh <dossier> <cle_publique.pem> <nom>
set -euo pipefail
dir="$1"; pub="$2"; name="$3"
tar czf "$name.tgz" -C "$dir" .
key=$(openssl rand -hex 32)
echo "::add-mask::$key"
openssl enc -aes-256-cbc -pbkdf2 -salt -pass "pass:$key" -in "$name.tgz" -out "$name.enc"
printf %s "$key" | openssl pkeyutl -encrypt -pubin -inkey "$pub" -out "$name.key"
rm -f "$name.tgz"
