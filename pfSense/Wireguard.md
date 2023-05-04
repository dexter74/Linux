##### Installation du Paquet
```
Système > Gestionnaire de paquets > Paquets disponibles
Wireguard
```

##### Générer des Clés Privées, Publiques et Pre-shared
```bash
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

:: Création de l-arborescence des dossiers
mkdir Wireguard
mkdir Wireguard\Client
mkdir Wireguard\Serveur

:: Génération des Clés du Serveur
:: %WIREGUARD% genpsk > %USERPROFILE%\Desktop\Wireguard\Serveur\Preshared.txt
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
 - Private  : 4McJApCA5LSuGWiEQhY6/N+ge4BYNUu/7kt2eWJXSm0=
 - Public   : PIgbMLozKsxhLYMvGn87sBFLzOHL8bM341J+lZw1UCw=
 - Preshared: YJUO1byaWTdh4cXmrOeZ7XG1rJoTropEoYMcozXQsCM=

Client:
 - Private  : SFqEF+d/4BvIRmfqYDRbJppRDoOcA60ZaztAJaEHfl4=
 - Public   : RSdHPzKQWWxhKlkr7PunaurJt6EuUi7seAreoCe2TxU=
 - Preshared: h6dyEycgxcgjlzf84mxK/GtLzyUT5xVcKqmxVPlNznY=
```

##### Configuration du Serveur
```
VPN > Wireguard > Tunnels > Add Tunnels
- Description        : Wireguard
- Listen Port        : 51820 (UDP)
- Interface Keys     : 4McJApCA5LSuGWiEQhY6/N+ge4BYNUu/7kt2eWJXSm0=
- Interface Address  : 192.168.20.0/24

> Valider
```

##### Client
```
VPN > Wireguard > Peers >  Add Peers
- Tunnel           : tun_wg0
- Descrption       : Client 1
- Dynamic Endpoint : Décocher
- Endpoint         : 192.168.0.5:51820
- Public Key       : RSdHPzKQWWxhKlkr7PunaurJt6EuUi7seAreoCe2TxU=
- Pre-shared Key   : h6dyEycgxcgjlzf84mxK/GtLzyUT5xVcKqmxVPlNznY=
- Allowed IPs      : 0.0.0.0/0

```

##### Activation du Serveur
```
VPN > WireGuard > Paramètres
- Activer: Cocher
```

##### Création de l'interface 
```
Interface > Assignments
Ports réseau disponibles	 : tun_wg0 > Cliquer sur Ajouter
Editer OPTX
 - Activer: Oui
 - Description: VPN
 - Type de configuration IPv4: IP statique
 - MTU: 1420 (A voir si sa impact)
 - Adresse IPv4:  192..168.20.1 / 24 (CF. au serveur Wireguard)
```

##### Pare-Feu
```
Pare-feu > Règles > WireGuard
 -  

Pare-feu > Règles > WAN
```



##### Connexion
```
[Interface]
PrivateKey = SFqEF+d/4BvIRmfqYDRbJppRDoOcA60ZaztAJaEHfl4=
Address = 192.168.20.2/32
DNS = 192.168.0.1
MTU = 1420

[Peer]
PublicKey = PIgbMLozKsxhLYMvGn87sBFLzOHL8bM341J+lZw1UCw=
AllowedIPs = 192.168.0.0/24, 0.0.0.0/0
Endpoint = 192.168.0.5:51820

```


![image](https://user-images.githubusercontent.com/35907/236208130-5c07bd5e-db85-4f4b-8e87-9eccfa0bca46.png)

