#### Torrent
```bash
clear;
# ------------------------------------------------------------------------------------------------------------------
CHEMIN=/var/lib/docker/volumes/
STACK=warez
CONTENEUR=Qbittorrent
# ------------------------------------------------------------------------------------------------------------------
docker stop qbittorrent;
# ------------------------------------------------------------------------------------------------------------------
echo "[AutoRun]
OnTorrentAdded\Enabled=false
OnTorrentAdded\Program=
enabled=false
program=

[BitTorrent]
Session\ExcludedFileNames=
Session\Port=60221
Session\QueueingSystemEnabled=false

[Core]
AutoDeleteAddedTorrentFile=Never

[Downloads]
SavePath=/media/Download/Torrent

[%General]
General\Locale=fr_FR
Locale=fr_FR

[Meta]
MigrationVersion=4

[Network]
Cookies=@Invalid()
Proxy\OnlyForTorrents=false

[Preferences]
Advanced\RecheckOnCompletion=false
Advanced\trackerPort=9000
Advanced\trackerPortForwarding=false
Connection\ResolvePeerCountries=true
DynDNS\DomainName=changeme.dyndns.org
DynDNS\Enabled=false
DynDNS\Password=
DynDNS\Service=DynDNS
DynDNS\Username=
General\Locale=fr
MailNotification\email=
MailNotification\enabled=false
MailNotification\password=
MailNotification\req_auth=true
MailNotification\req_ssl=false
MailNotification\sender=qBittorrent_notification@example.com
MailNotification\smtp_server=smtp.changeme.com
MailNotification\username=
WebUI\Address=*
WebUI\AlternativeUIEnabled=false
WebUI\AuthSubnetWhitelist=0.0.0.0/0
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\BanDuration=3600
WebUI\CSRFProtection=true
WebUI\ClickjackingProtection=true
WebUI\CustomHTTPHeaders=
WebUI\CustomHTTPHeadersEnabled=false
WebUI\HTTPS\CertificatePath=
WebUI\HTTPS\Enabled=false
WebUI\HTTPS\KeyPath=
WebUI\HostHeaderValidation=false
WebUI\LocalHostAuth=false
WebUI\MaxAuthenticationFailCount=5
WebUI\Port=1007
WebUI\ReverseProxySupportEnabled=false
WebUI\RootFolder=
WebUI\SecureCookie=true
WebUI\ServerDomains=*
WebUI\SessionTimeout=3600
WebUI\TrustedReverseProxiesList=
WebUI\UseUPnP=false
WebUI\Username=admin

[RSS]
AutoDownloader\DownloadRepacks=true

[WebUI]
HostHeaderValidation=false" > $CHEMIN/${STACK}_Qbittorrent/_data/qBittorrent/qBittorrent.conf
# ------------------------------------------------------------------------------------------------------------------
docker start qbittorrent;
```
