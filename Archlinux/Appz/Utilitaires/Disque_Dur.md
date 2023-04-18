#### Seatool (S.M.A.R.T)
```
wget https://www.seagate.com/content/dam/seagate/migrated-assets/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsLinuxX64Installer.zip -O /tmp/SeaToolsLinuxX64Installer.zip;
unzip /tmp/SeaToolsLinuxX64Installer.zip -d /tmp/
sudo chmod +x /tmp/SeaToolsLinuxX64Installer.run;
sudo /tmp/SeaToolsLinuxX64Installer.run;


kill -9 $(ps -ef | grep SeaTools5 | grep -v grep | cut -c 12-19)
```
