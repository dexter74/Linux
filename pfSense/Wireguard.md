##### Installation du Paquet
```
Système > Gestionnaire de paquets > Paquets disponibles
Wireguard
```

##### Générer des Clés Privées, Publiques et Pre-shared
```
"C:\Program Files\WireGuard\wg" /?
Available subcommands:
  show: Shows the current configuration and device information
  showconf: Shows the current configuration of a given WireGuard interface, for use with `setconf'
  set: Change the current configuration, add peers, remove peers, or change peers
  setconf: Applies a configuration file to a WireGuard interface
  addconf: Appends a configuration file to a WireGuard interface
  syncconf: Synchronizes a configuration file to a WireGuard interface
  genkey: Generates a new private key and writes it to stdout
  genpsk: Generates a new preshared key and writes it to stdout
  pubkey: Reads a private key from stdin and writes a public key to stdout


del /F /Q Desktop\Wireguard
mkdir Desktop\Wireguard\Client
mkdir Desktop\Wireguard\Serveur

"C:\Program Files\WireGuard\wg" genpsk > Desktop\Wireguard\Client\Preshared.txt
"C:\Program Files\WireGuard\wg" genkey > Desktop\Wireguard\Client\Private.txt
"C:\Program Files\WireGuard\wg" pubkey > Desktop\Wireguard\Client\Public.txt


"C:\Program Files\WireGuard\wg" genpsk > Desktop\Wireguard\Serveur\Preshared.txt
"C:\Program Files\WireGuard\wg" genkey > Desktop\Wireguard\Serveur\Private.txt
"C:\Program Files\WireGuard\wg" pubkey > Desktop\Wireguard\Serveur\Public.txt
```



##### Configuration du Serveur
```
VPN > Wireguard > Tunnels > Add Tunnels
- Description        : Coller la clé Publique
- Listen Port        : 51820 (UDP)
- Interface Keys     : Cliquer sur Générer et copier la clé puis coller dans la "Description"
- Interface Address  : 192.168.5.0/24 
```


##### Client
