#!/usr/bin/env bash
# Télécharge et déchiffre les journaux d'une exécution.
# Usage : open-logs.sh <run_id> [dossier]
set -euo pipefail
run="$1"; dest="${2:-$HOME/.onadis-ci/runs/$run}"
priv="$HOME/.onadis-ci/log_key.pem"
mkdir -p "$dest"
gh run download "$run" -R nahim-salami/onadis-ci -D "$dest"
for f in "$dest"/*/*.enc; do
  base="${f%.enc}"; out="${base}"
  mkdir -p "$out"
  key=$(openssl pkeyutl -decrypt -inkey "$priv" -in "$base.key")
  openssl enc -d -aes-256-cbc -pbkdf2 -pass "pass:$key" -in "$f" | tar xzf - -C "$out"
  rm -f "$f" "$base.key"
done
echo "$dest"
