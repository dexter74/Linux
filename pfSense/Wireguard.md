----------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Configuration d'un serveur VPN Wireguard sous pfSense par Marc Jaffré</p>

----------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation de l'environnement
```
Pfsense:
 - Réseau WAN: 192.168.0.0/24
 - Réseau LAN: 192.168.10.0/24
 - Réseau wg0: 192.168.20.0/24
```
----------------------------------------------------------------------------------------------------------------------------------------------

### II. Installation du Paquet
```
Système > Gestionnaire de paquets > Paquets disponibles
Wireguard
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------
### III. Générer des Clés Privées, Publiques et Pre-shared
Sur un poste Windows, il faut installer WireGuard. Les clés sont générés dans le dossier Wireguard qui sera crée sur le bureau de l'utilisateur.
Le script A ou B font la même chose.

##### Script A
```batch
@echo off

:: ##########################################################
:: # Script pour Générer des Clés Wireguard par Marc Jaffré #
:: # Syntaxe Commande : "C:\Program Files\WireGuard\wg" /?  #
:: ##########################################################

:: Titre de la Fenetre DOS
title Generer Cle Wireguard

:: Declaration des Variables
set WIREGUARD="C:\Program Files\WireGuard\wg"

:: Création du Dossier Temporaire
mkdir %USERPROFILE%\tmp\

:: Génération des Clés Serveur
%WIREGUARD% genkey > %USERPROFILE%\tmp\PRIVATE.txt
powershell cat %USERPROFILE%\tmp\PRIVATE.txt | %WIREGUARD% pubkey >  %USERPROFILE%\tmp\PUBLIC.txt
FOR /F "tokens=*" %%g IN ('powershell cat %USERPROFILE%\tmp\PRIVATE.txt') do (SET SRV_PRIV=%%g)
FOR /F "tokens=*" %%g IN ('powershell cat %USERPROFILE%\tmp\PUBLIC.txt') do (SET SRV_PUB=%%g)

:: Génération des Clés Client
%WIREGUARD% genkey                                                           > %USERPROFILE%\tmp\PRIVATE.txt
%WIREGUARD% genpsk                                                           > %USERPROFILE%\tmp\Preshared.txt
powershell cat %USERPROFILE%\tmp\PRIVATE.txt | %WIREGUARD% pubkey            > %USERPROFILE%\tmp\PUBLIC.txt
FOR /F "tokens=*" %%g IN ('powershell cat %USERPROFILE%\tmp\PRIVATE.txt')    do (SET CLIENT_PRIV=%%g)
FOR /F "tokens=*" %%g IN ('powershell cat %USERPROFILE%\tmp\Preshared.txt')  do (SET CLIENT_Preshared=%%g)
FOR /F "tokens=*" %%g IN ('powershell cat %USERPROFILE%\tmp\PUBLIC.txt')     do (SET CLIENT_PUB=%%g)

:: Génération du fichier de sortie:
echo Serveur: > %USERPROFILE%\Desktop\Wireguard.txt
echo  - Private : %SRV_PRIV%         >> %USERPROFILE%\Desktop\Wireguard.txt
echo  - Public  : %SRV_PUB%          >> %USERPROFILE%\Desktop\Wireguard.txt
echo.                                >> %USERPROFILE%\Desktop\Wireguard.txt
echo Client:                         >> %USERPROFILE%\Desktop\Wireguard.txt
echo  - Private : %CLIENT_PRIV%      >> %USERPROFILE%\Desktop\Wireguard.txt
echo  - Preshare: %CLIENT_Preshared% >> %USERPROFILE%\Desktop\Wireguard.txt
echo  - Public  : %CLIENT_PUB%       >> %USERPROFILE%\Desktop\Wireguard.txt

:: Purge du Dossier Temp:
rmdir /S /Q %USERPROFILE%\tmp

:: Ouverture du fichier Wireguard.txt
start %USERPROFILE%\Desktop\Wireguard.txt
exit
```

##### Script B
```batch
@echo off

:: ##########################################################
:: # Script pour Générer des Clés Wireguard par Marc Jaffré #
:: # Syntaxe Commande : "C:\Program Files\WireGuard\wg" /?  #
:: ##########################################################

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
%WIREGUARD% genkey > %USERPROFILE%\Desktop\Wireguard\Serveur_Private.txt
powershell cat %USERPROFILE%\Desktop\Wireguard\Serveur_Private.txt | %WIREGUARD% pubkey > %USERPROFILE%\Desktop\Wireguard\Serveur_Publique.txt

:: Génération des Clés du Client
%WIREGUARD% genpsk > %USERPROFILE%\Desktop\Wireguard\Client_Preshared.txt
%WIREGUARD% genkey > %USERPROFILE%\Desktop\Wireguard\Client_Private.txt
powershell cat %USERPROFILE%\Desktop\Wireguard\Client_Private.txt | %WIREGUARD% pubkey > %USERPROFILE%\Desktop\Wireguard\Client_Publique.txt
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
### IV. Configuration du service Wireguard
##### A. Serveur
```
VPN > Wireguard > Tunnels >  Add Tunnels
```
![image](https://user-images.githubusercontent.com/35907/236337098-b1524720-6256-424d-90e7-cb119c3231bd.png)

##### B. Client
```
VPN > Wireguard > Peers >  Add Peers
```
![image](https://user-images.githubusercontent.com/35907/236337732-9e1b7a0d-897e-40d6-8e84-a203c47dcb8a.png)

##### Activation du Serveur
```
VPN > WireGuard > Paramètres
```
![image](https://user-images.githubusercontent.com/35907/236337964-5e5770e7-abaa-4b89-b57b-bd3d14b4c262.png)


##### C. Etat du Serveur
```
État > WireGuard
```
On peut voir le réseau est actif car il est blan et pas gris.
![image](https://user-images.githubusercontent.com/35907/236338291-3962556b-d3c0-452a-a968-0cecfc93626f.png)
<br />

----------------------------------------------------------------------------------------------------------------------------------------------
### V. Création de l'interface 

**CLiquer sur Ajouter**
![image](https://user-images.githubusercontent.com/35907/236338769-42cbbcd2-89d1-4bc0-9481-b36d6d0e085c.png)

**Editer OPT1 en cliquant dessus** 
![image](https://user-images.githubusercontent.com/35907/236338820-b15c34d6-f4b7-4422-87a7-3eeedffcbac1.png)

**Il faut que l'adresse IP de Wireguard soit dans le réseau créer dans l'étape précédente.**
![image](https://user-images.githubusercontent.com/35907/236339134-e7d9137f-7f3e-40c6-95aa-ac36643e7967.png)

![image](https://user-images.githubusercontent.com/35907/236339280-37bebab7-19ec-4e53-a6c2-f52f68265c21.png)

**Ajouter l'interface wg0 au groupe Wireguard**
![image](https://user-images.githubusercontent.com/35907/236339352-1e512167-e3fa-4805-93e6-224be6145af4.png)

![image](https://user-images.githubusercontent.com/35907/236339386-caff331c-85c4-4a90-8b1d-cc3328968e06.png)

<br />

----------------------------------------------------------------------------------------------------------------------------------------------
### VI. Pare-Feu
###### WAN
Lors du choix "Source" il faut choisir Tout si on accéde sur un réseau autre que le WAN de pfsense.
![image](https://user-images.githubusercontent.com/35907/236339693-fa31fef5-d22b-4450-b87b-42ad2c006401.png)

###### Wireguard
![image](https://user-images.githubusercontent.com/35907/236339772-8f69c96a-30f5-4166-bffa-03e1e901b393.png)

<br />

----------------------------------------------------------------------------------------------------------------------------------------------
### VII. Connexion depuis le client
J'autorise les réseaux `192.168.0.0/24` et `192.168.1.0/24` car j'utilise ses réseaux
```
[Interface]
PrivateKey = SFqEF+d/4BvIRmfqYDRbJppRDoOcA60ZaztAJaEHfl4=
Address = 192.168.20.2/32
DNS = 192.168.20.1
MTU = 1420

[Peer]
PublicKey = PIgbMLozKsxhLYMvGn87sBFLzOHL8bM341J+lZw1UCw=
PresharedKey = h6dyEycgxcgjlzf84mxK/GtLzyUT5xVcKqmxVPlNznY=
AllowedIPs = 0.0.0.0/0
AllowedIPs = 192.168.1.0/24
AllowedIPs = 192.168.0.0/24
Endpoint = 192.168.0.5:51820
```

##### Etat de Wireguard

![image](https://user-images.githubusercontent.com/35907/236340595-d801adc3-c990-47c5-8ee4-632a9da7504a.png)

![image](https://user-images.githubusercontent.com/35907/236340858-ad617dfd-8bcd-44b2-b6a7-b7d34c440648.png) : Connexion Réussi avec le serveur Wireguard

![image](https://user-images.githubusercontent.com/35907/236338483-457647b9-b6b2-4d3c-b360-8db382e37fc4.png) : Aucune connexion en cours


