kubectl patch mutatingwebhookconfiguration cnpg-mutating-webhook-configuration -p '{"webhooks": [{"name": "mcluster.cnpg.io","failurePolicy": "Ignore"}]}'
kubectl patch validatingwebhookconfiguration cnpg-validating-webhook-configuration -p '{"webhooks": [{"name": "vcluster.cnpg.io","failurePolicy": "Ignore"}]}'
