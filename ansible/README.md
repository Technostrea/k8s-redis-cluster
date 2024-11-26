# Playbooks

## creer un env
```bash
python3 -m venv nom-de-l-env
```

## Activer l'env virtuel
```bash
source nom-de-l-env/bin/activate
```

## Installer les packages s'il n'existe pas
```bash
pip install -r requirements.txt
```

## Modifier l'inventaire des machines cibles
- l'adresse de la machine
- le port ssh
- le nom d'utilisateur

## Playbook d'installation microk8s
- changer de version en modifiant la variable `microk8s_version`

## Playbook d'installation k9s
- changer de version en modifiant la variable`k9s_version`

## Playbook de configuration
- changer de CIDR en modifiant la variable `cidr`

## Playbook d'installation de argocd
- changer de version en modifiant la variable `argocd_version`

## Tester la connexion aux machines cibles
```bash
ansible control-plan -m ping
```

## Verificer le programme
```bash
ansible-playbook main.yaml --check
```

## Lancer le programme
```bash
ansible-playbook main.yaml -vv
```