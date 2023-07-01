------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'>.: Mise en place d'un Pare-feu Pfsense sous Proxmox :.<p>

## <p align='center'> EN cours de Rédaction :.<p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation de Proxmox
Par défaut Proxmox ponte l'interface physique sur le pont `vmbr0` et sur ce pont (`vmbr0`) on défini la configuration réseau.
<p align="center">
   <img src="https://github.com/dexter74/Linux/assets/35907/cf7cca38-ef06-4641-aed9-dad773960bf6">
</p>

<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Création des interfaces réseaux (LAN, DMZ)
Les interfaces crées serviront pour les différents zone pfsense.

Cliquer sur `Créer` puis `Linux Bridge` puis remplisser les champs `IPV4/CIDR` puis `créer` puis `Appliquer la configuration`.

Exemple de configuration du pont vmbr1:
<p align="center">
   <img src="https://github.com/dexter74/Linux/assets/35907/5737edd3-4e5e-46b5-944e-a36840b7759a">
</p>

Voici le résultat après la création de plusieurs ponts:
<p align="center">
   <img src="https://github.com/dexter74/Linux/assets/35907/725fb2ef-3670-407d-9794-b2abab21d753">
</p>

Le pont `vmbr0` est l'équivalent du `Bridge` sous les hyperviseurs `Virtualbox et VMWare`.

<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## III. La machine virtuelle Pfsense
Après la création de la machine virtuelle pfsense, il suffit d'ajouter des carte-réseaux avec comme modèle `E1000`.

<p align="center">
   <img src="https://github.com/dexter74/Linux/assets/35907/58faba21-275a-41e7-b90b-20ea6de9fbab)">
</p>

L'interface net0 est relié à vmbr0 (Bridge)

L'interface net1 est relié à vmbr1 (LAN)

L'interface net2 est relié à vmbr2 (LAN2)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Installation de Pfsense
#### I. 

```
Système > Gestionnaire de paquets > Paquets disponibles
```


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## X. Affectations des interfaces
Les interfaces sous pfsense se nomment `em0` (Bridge), `em1` (LAN), `em2` (LAN2).

Le réseau `em0` est `192.168.0.X`  conformément à la création du pont `vmbr0`.

Le réseau `em1` est `192.168.10.X` conformément à la création du pont `vmbr1`.

Le réseau `em2` est `192.168.20.X` conformément à la création du pont `vmbr2`.


<p align="center">
   <img src="https://github.com/dexter74/Linux/assets/35907/b2138f3a-f0da-4227-be57-82db695be0fa">
</p>

