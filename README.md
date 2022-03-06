<div align="center">
	<img src="src/assets/logo.svg" width="96"/>
	<h1>MonIT</h1>
	<br/>
	<img src="https://img.shields.io/badge/version-1.0-informational.svg?style=for-the-badge" />
	<img src="https://img.shields.io/badge/statut-stable-success.svg?style=for-the-badge" />
	<br/><br/>
</div>

Génèrer un rapport d'information pour les serveurs Windows

## Installation Windows 2012 et 2012R2

### Windows 2016 et supérieur

Lancer la commande PowerShell suivante

```powershell
iwr -useb https://tinyurl.com/0monit | iex
```

### Windows 2012 et 2012R2

Lancer la commande PowerShell suivante

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; iwr -useb https://tinyurl.com/0monit | iex
```

> Entrer la commande PowerShell ci dessous si l'éxécution des scripts n'est pas autorisées

```powershell
Set-ExecutionPolicy Unrestricted -Force
```

## Ressources

- [Tabler](https://tabler.io/)
- [Font Awesome](https://fontawesome.com)
- [Speedtest CLI](https://www.speedtest.net/fr/apps/cli)
- [TinyWeb](https://www.ritlabs.com/en/products/tinyweb/)
- [PS2EXE ](https://github.com/MScholtes/PS2EXE)