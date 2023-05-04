----------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Configuration d'un serveur VPN Wireguard sous pfSense </p>

----------------------------------------------------------------------------------------------------------------------------------------------

#### Installation du Paquet
```
Système > Gestionnaire de paquets > Paquets disponibles
Wireguard
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------
#### Générer des Clés Privées, Publiques et Pre-shared
Sur un poste Windows, il faut installer WireGuard. Les clés sont générés dans le dossier Wireguard qui sera crée sur le bureau de l'utilisateur.

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

Client:
 - Private  : SFqEF+d/4BvIRmfqYDRbJppRDoOcA60ZaztAJaEHfl4=
 - Public   : RSdHPzKQWWxhKlkr7PunaurJt6EuUi7seAreoCe2TxU=
 - Preshared: h6dyEycgxcgjlzf84mxK/GtLzyUT5xVcKqmxVPlNznY=
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------
#### Configuration du Serveur
Indiquer la clé Privée du serveur.

![image](https://user-images.githubusercontent.com/35907/236337098-b1524720-6256-424d-90e7-cb119c3231bd.png)

#### Client
```
VPN > Wireguard > Peers >  Add Peers
- Tunnel           : tun_wg0
- Descrption       : Client 1
- Public Key       : RSdHPzKQWWxhKlkr7PunaurJt6EuUi7seAreoCe2TxU=
- Pre-shared Key   : h6dyEycgxcgjlzf84mxK/GtLzyUT5xVcKqmxVPlNznY=
- Allowed IPs      : 0.0.0.0/0
```

##### Activation du Serveur
```
VPN > WireGuard > Paramètres
- Activer: Cocher
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------
##### Création de l'interface 
```
Interface > Assignments
Ports réseau disponibles : tun_wg0 
 > Cliquer sur Ajouter
 > Enregistrer
 
 Editer OPTX
 - Activer: Oui
 - Description: VPN
 - Type de configuration IPv4: IP statique
 - MTU: 1420 (A voir si sa impact)
 - Adresse IPv4:  192.168.20.1 / 24
  > CF. à la configuration du serveur Wireguard

Ajouter dans le groupe Wireguard l'interface VPN
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------
##### Pare-Feu
```
Pare-feu > Règles > WireGuard
Pare-feu > Règles > WAN
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------
##### Connexion
```
[Interface]
PrivateKey = <Clé Privée du Client>
Address = 192.168.XX.2/32
DNS = 192.168.XX.1
MTU = 1420

[Peer]
PublicKey = <Clé Privée du Serveur>
AllowedIPs = 0.0.0.0/0
Endpoint = <Adresse DNS ou IP serveur>:<Port Wireguard>
```


![image](https://user-images.githubusercontent.com/35907/236208130-5c07bd5e-db85-4f4b-8e87-9eccfa0bca46.png)

