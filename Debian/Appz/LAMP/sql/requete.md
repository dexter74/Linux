```sql
# Connexion SQL:
mysql -u root -padmin

# Autoriser Accès
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');

# Création du BDD
CREATE DATABASE IF NOT EXISTS STUDITEST;

# Se connecter dans la BDD
use STUDITEST;

# Création d'une Table
create table test (msg text);

# Insertion de contenu
insert into test values ('coucou');

# Afficher Contenu
select * from test;

# Quitter la SQL:
exit;
```
