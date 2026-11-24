#!/usr/bin/env bash
set -euo pipefail

required=(
  Dockerfile
  compose.yaml
  .gitignore
  requirements-dev.txt
  tests/test_smoke.py
  .github/workflows/ci.yml
)

ok=1

for f in "${required[@]}"; do
  if [ -e "$f" ]; then
    echo "OK       $f"
  else
    echo "MANQUANT $f" >&2
    ok=0
  fi
done

if git ls-files --error-unmatch .env >/dev/null 2>&1; then
  echo "ERREUR   .env est suivi par Git" >&2
  ok=0
fi

if [ "$ok" -eq 1 ]; then
  echo "projet conforme"
  exit 0
else
  echo "projet non conforme" >&2
  exit 1
fi
