package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"strings"

	"github.com/pkg/browser"
)

const (
	scriptPath           = "script.ps1"
	htmlFilePath         = "dist/index.html"
	versionURL           = "https://raw.githubusercontent.com/Fl0wyn/MonIT/master/VERSION"
	localVersionFilePath = "VERSION"
)

func runPowerShellScript(scriptPath string) error {
	cmd := exec.Command("powershell", "-ExecutionPolicy", "Bypass", "-File", scriptPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func openHTMLFile(htmlFilePath string) error {
	if _, err := os.Stat(htmlFilePath); os.IsNotExist(err) {
		return fmt.Errorf("Le fichier HTML n'existe pas")
	}

	return browser.OpenFile(htmlFilePath)
}

func compareVersions(localVersion, remoteVersion string) {
	if localVersion == remoteVersion {
		fmt.Println("Les versions sont identiques.")
	} else {
		fmt.Println("Une nouvelle version est disponible. Version locale:", localVersion, "Version sur GitHub:", remoteVersion)
	}
}

func checkGitVersion() error {
	response, err := http.Get(versionURL)
	if err != nil {
		return fmt.Errorf("Erreur lors de la récupération de la version depuis GitHub: %v", err)
	}
	defer response.Body.Close()

	body, err := io.ReadAll(response.Body)
	if err != nil {
		return fmt.Errorf("Erreur lors de la lecture de la réponse: %v", err)
	}

	remoteVersion := strings.TrimSpace(string(body))

	localVersionBytes, err := os.ReadFile(localVersionFilePath)
	if err != nil {
		return fmt.Errorf("Erreur lors de la lecture du fichier local: %v", err)
	}
	localVersion := strings.TrimSpace(string(localVersionBytes))

	compareVersions(localVersion, remoteVersion)

	return nil
}

func main() {
	fmt.Println("\033[32mMonIT\033[0m")

	if err := runPowerShellScript(scriptPath); err != nil {
		fmt.Println("Erreur lors de l'exécution du script PowerShell:", err)
		return
	}

	if err := openHTMLFile(htmlFilePath); err != nil {
		fmt.Println("Erreur lors de l'ouverture du fichier HTML dans le navigateur:", err)
		return
	}

	if err := checkGitVersion(); err != nil {
		fmt.Println("Erreur:", err)
	}
}
