##### Installation du Paquet
```
Système > Gestionnaire de paquets > Paquets disponibles
Wireguard
```

##### Générer des Clés Privées, Publiques et Pre-shared
```
@echo on

:: ##########################################
:: # Script pour Générer des Clés Wireguard #
:: # "C:\Program Files\WireGuard\wg" /?     #
:: ##########################################

:: Titre de la Fenetre DOS
title Generer Cle Wireguard

:: Declaration des Variables
set WIREGUARD="C:\Program Files\WireGuard\wg"

:: Nettoyage
rmdir /S /Q Wireguard

:: Création de l'arborescence des dossiers
mkdir Wireguard
mkdir Wireguard\Client
mkdir Wireguard\Serveur

:: Génération des Clés du Serveur
%WIREGUARD% genpsk > %USERPROFILE%\Desktop\Wireguard\Serveur\Preshared.txt
%WIREGUARD% genkey > %USERPROFILE%\Desktop\Wireguard\Serveur\Private.txt
powershell cat %USERPROFILE%\Desktop\Wireguard\Serveur\Private.txt | %WIREGUARD% pubkey > %USERPROFILE%\Desktop\Wireguard\Serveur\Publique.txt

:: Génération des Clés du Client
%WIREGUARD% genpsk > %USERPROFILE%\Desktop\Wireguard\Client\Preshared.txt
%WIREGUARD% genkey > %USERPROFILE%\Desktop\Wireguard\Client\Private.txt
powershell cat %USERPROFILE%\Desktop\Wireguard\Client\Private.txt | %WIREGUARD% pubkey > %USERPROFILE%\Desktop\Wireguard\Client\Publique.txt
```

##### Exemple
```
Serveur:
 - Preshared: YJUO1byaWTdh4cXmrOeZ7XG1rJoTropEoYMcozXQsCM=
 - Private  : 4McJApCA5LSuGWiEQhY6/N+ge4BYNUu/7kt2eWJXSm0=
 - Public   : PIgbMLozKsxhLYMvGn87sBFLzOHL8bM341J+lZw1UCw=

Client:
 - Preshared: h6dyEycgxcgjlzf84mxK/GtLzyUT5xVcKqmxVPlNznY=
 - Private  : SFqEF+d/4BvIRmfqYDRbJppRDoOcA60ZaztAJaEHfl4=
 - Public   : RSdHPzKQWWxhKlkr7PunaurJt6EuUi7seAreoCe2TxU=
```


##### Configuration du Serveur
```
VPN > Wireguard > Tunnels > Add Tunnels
- Description        : Wireguard
- Listen Port        : 51820 (UDP)
- Interface Keys     : Coller les clés générés
- Interface Address  : 192.168.5.0/24 
```


##### Client
