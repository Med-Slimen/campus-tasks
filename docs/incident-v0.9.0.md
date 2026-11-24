# Compte rendu d'incident - v0.9.0

1. **Ce qui s'est passé** : la version v0.9.0 (défectueuse, incident provoqué pour l'exercice) a été mise en service sur staging ; le conteneur démarrait, mais /health renvoyait une erreur 500.
2. **Détection** : `scripts/wait-healthy.sh` a échoué après 12 tentatives (environ 60 s) avec « staging non sain ». Première erreur utile dans les journaux : `ERROR in app: health check failed: database unreachable`. Le pipeline était pourtant vert : aucun test ne vérifie /health.
3. **Action** : retour arrière sur v1.0.0 en changeant IMAGE_TAG puis `docker compose up -d`, sans reconstruire. Santé confirmée (« staging sain »), digest identique : sha256:c6214e9a092e9301db2d5f6e65dd161c08be28a28123f70a02f9b97b96bece16.
4. **Indisponibilité** : au moins 6 min 30 s, de 22:59:44 UTC (première erreur visible dans les journaux) à 23:06:14 UTC (service sain). Le début réel est un peu antérieur.
5. **Prévention** : ajouter un test automatique de /health dans la CI, et faire du contrôle de santé une étape obligatoire après chaque mise en service, avec retour arrière dès qu'il échoue.
