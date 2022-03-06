<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonIT</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-1.0-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" />
	<br/><br/>
</div>

Génèrer un rapport d'information pour les serveurs Windows 2012 ou supérieur

## Installation

Lancer la commande PowerShell suivante
```powershell
iwr -useb https://tinyurl.com/0monit | iex
```

> Les commandes PowerShell suivantes peuvent résoudre les erreurs rencontrées sur le script d'installation
```powershell
# Activer TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Autoriser l'éxécution des scripts globalement
Set-ExecutionPolicy Unrestricted -Force

# Commande d'installation sans les raccourcies d'URL et de cmdlet
Invoke-WebRequest -useb https://raw.githubusercontent.com/Fl0wyn/MonIT/master/scripts/install.ps1 | Invoke-Expression
```

## Ressources

- [Tabler](https://tabler.io/)
- [Font Awesome](https://fontawesome.com)
- [Speedtest CLI](https://www.speedtest.net/fr/apps/cli)
- [TinyWeb](https://www.ritlabs.com/en/products/tinyweb/)
- [PS2EXE ](https://github.com/MScholtes/PS2EXE)