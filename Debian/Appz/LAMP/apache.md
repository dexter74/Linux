**Editer le Site Actif**
```
nano /etc/apache2/sites-enabled/000-default.conf;
```

**Modifier la racine du Site**
```
DocumentRoot /var/www/html
```

**Page par défaut à charger**
```
<IfModule dir_module>
    DirectoryIndex index.html index.php
</IfModule>
```
