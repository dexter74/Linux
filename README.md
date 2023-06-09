# Linux
```
echo "$(id 1000 | cut -d "(" -f 2 | cut -d ")" -f 1) ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin
```
