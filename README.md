<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonIT</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-2.0-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-test-red.svg?style=for-the-badge" />
	<!-- <img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" /> -->
	<br/><br/>
</div>

Génèrer un rapport d'information pour les serveurs Windows

<img src="src/assets/demo.png"/>

## Installation

### Prérequis

- Windows 2012 où supérieur
- Autoriser l'exécution des scripts PowerShell (`Set-ExecutionPolicy Unrestricted -Force`)

Lancer la commande PowerShell suivante :

```powershell
iwr -useb https://raw.githubusercontent.com/Fl0wyn/MonIT/master/scripts/install.ps1 | iex
```

## Exécution

Lancer l'applcation <img src="src/assets/logo.svg" width="16"/> **MonIT.exe** présent sur le bureau

## Désinstallation

Supprimer l'éxécutable **C:\Windows\Temp\MonIT-Update.exe**

Supprimer le dossier **C:\Exploitation\MonIT** et l'icône sur le bureau

## Ressources

- [Tabler](https://tabler.io/)
- [Speedtest CLI](https://www.speedtest.net/fr/apps/cli)
- [PS2EXE ](https://github.com/MScholtes/PS2EXE)
