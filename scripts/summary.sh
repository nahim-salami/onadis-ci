#!/usr/bin/env bash
# Résumé public : uniquement des compteurs, jamais de messages ni de chemins.
# Usage : summary.sh <fichier.trx> <code_retour>
trx="$1"; code="$2"
if [ -f "$trx" ]; then
  c=$(grep -o '<Counters [^>]*>' "$trx" | head -1)
  get() { echo "$c" | sed -n "s/.* $1=\"\([0-9]*\)\".*/\1/p"; }
  line="Tests : $(get passed) réussis / $(get failed) échoués (total $(get total))"
else
  line="Tests : non exécutés (échec de restauration ou de compilation)"
fi
echo "$line"
echo "$line" >> "$GITHUB_STEP_SUMMARY"
echo "Code retour : $code" >> "$GITHUB_STEP_SUMMARY"
