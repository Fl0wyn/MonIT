<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonIT</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-1.7-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" />
	<br/><br/>
</div>

Génèrer un rapport d'information pour les serveurs Windows

<img src="src/assets/demo.png"/>

## Installation

### Prérequis

- Windows 2012 où supérieur
- Navigateur web moderne par défault
- Autoriser l'exécution des scripts PowerShell (`Set-ExecutionPolicy Unrestricted -Force`)

Lancer la commande PowerShell suivante:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; iwr -useb https://raw.githubusercontent.com/Fl0wyn/MonIT/master/scripts/install.ps1 | iex
```

## Exécution

Lancer l'applcation <img src="src/assets/logo.svg" width="16"/> **MonIT.exe** présent sur le bureau

## Désinstallation

Supprimer l'éxécutable **C:\Windows\Temp\MonIT-Update.exe**

Supprimer le dossier **C:\Exploitation\MonIT** et l'icône sur le bureau

Arrêter le serveur web si le dossier est en cours d'utilisation

```powershell
Stop-Process -Force -Name "tiny"
```

## Ressources

- [Tabler](https://tabler.io/)
- [Font Awesome](https://fontawesome.com)
- [Speedtest CLI](https://www.speedtest.net/fr/apps/cli)
- [TinyWeb](https://www.ritlabs.com/en/products/tinyweb/)
- [PS2EXE ](https://github.com/MScholtes/PS2EXE)
