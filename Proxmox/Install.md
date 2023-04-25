#### Création d'un compte Utilisateur Proxmox
```bash
UTILISATEUR="Drthrax74@pam"
MOTDEPASSE="admin"
EMAIL="teste74@hotmail.fr"
PRENOM="Marc"
NOM="Jaffre"

# Purge
sudo pveum group del   Administrateurs 2>/dev/null;
sudo pveum group del   Audit 2>/dev/null;
sudo pveum group del   Stockage 2>/dev/null;
sudo pveum group del   Utilisateurs 2>/dev/null;
sudo pveum group del   VMadmin  2>/dev/null;
sudo pveum user delete $UTILISATEUR 2>/dev/null;

# Création des Groupes:
sudo pveum group add Administrateurs -comment "Groupe des administrateurs"
sudo pveum group add Audit           -comment "Groupe des auditeurs"
sudo pveum group add Stockage        -comment "Groupe du stockage"
sudo pveum group add Utilisateurs    -comment "Groupe des utilisateurs"
sudo pveum group add VMadmin         -comment "Groupe des Admins des VM"

# Création Utilisateur
sudo pveum user add "$UTILISATEUR" -email "$EMAIL" -enable 1 -first "$PRENOM" -lastname "$NOM";

# Changement du mot de passe:
(echo "$MOTDEPASSE"; echo "$MOTDEPASSE") | sudo pveum passwd $UTILISATEUR

# Modification des permissions pour les groupes
sudo pveum acl modify / -group Administrateurs -role Administrator;
sudo pveum acl modify / -group Audit -role PVEAuditor;
sudo pveum acl modify / -group Stockage -role PVEDatastoreAdmin;
sudo pveum acl modify / -group Utilisateurs -role PVEVMUser;
sudo pveum acl modify / -group VMadmin -role PVEVMAdmin;

# Modification permission de l'utilisateur
sudo pveum user modify "$UTILISATEUR" -group Administrateurs;
```
