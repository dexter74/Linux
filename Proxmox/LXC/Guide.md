#### Accés SSH
```
sed -i -e 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config;
systemctl restart ssh;
```
