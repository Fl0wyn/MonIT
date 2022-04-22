<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonIT</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-1.6-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" />
	<br/><br/>
</div>

Génèrer un rapport d'information pour les serveurs Windows

<img src="src/assets/demo.png"/>

## Installation

### Windows 2012 et supérieur

Lancer la commande PowerShell suivante

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; iwr -useb https://raw.githubusercontent.com/Fl0wyn/MonIT/master/scripts/install.ps1 | iex
```

> Entrer la commande PowerShell ci dessous si l'éxécution des scripts n'est pas autorisées

```powershell
Set-ExecutionPolicy Unrestricted -Force
```

## Exécution

Lancer l'applcation <img src="src/assets/logo.svg" width="16"/> **MonIT.exe** présent sur le bureau

## Ressources

- [Tabler](https://tabler.io/)
- [Font Awesome](https://fontawesome.com)
- [Speedtest CLI](https://www.speedtest.net/fr/apps/cli)
- [TinyWeb](https://www.ritlabs.com/en/products/tinyweb/)
- [PS2EXE ](https://github.com/MScholtes/PS2EXE)
