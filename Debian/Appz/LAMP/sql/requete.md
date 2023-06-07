----------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Gestion d'un serveur SQL</p>

### Connexion SQL:
```sql
mysql -u root -padmin
```

### Autoriser Accès
```sql
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');
```

### Création du BDD
```sql
CREATE DATABASE IF NOT EXISTS STUDITEST;
```

#### Se connecter dans la BDD
```sql
use STUDITEST;
```

### Création d'une Table
```sql
create table test (msg text);
```

### Insertion de contenu
```sql
insert into test values ('coucou');
```

### Afficher Contenu
```sql
select * from test;
```

### Quitter la SQL:
```sql
exit;
```
