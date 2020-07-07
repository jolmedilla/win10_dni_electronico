function Install-Something
{
    param( [string]$Source, [string]$Installer, [string[]]$Arguments )
    $LocalTempDir = $env:TEMP; 
    $output="$LocalTempDir\$Installer"

    try {
        (new-object    System.Net.WebClient).DownloadFile($Source, $output); 
        if ($output -like '*.zip' ) {
            Expand-Archive -Path $output -DestinationPath "$LocalTempDir\ExpandedArchive"
            $file = Get-ChildItem "$LocalTempDir\ExpandedArchive\*.exe"
            $output = $file.FullName
        }
        $p = Start-Process $output -ArgumentList $Arguments -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }
        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})

    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$Installer" -ErrorAction SilentlyContinue -Verbose
    }

}

Install-Something -source "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -installer "ChromeInstaller.exe" -arguments "/silent","/install"
Install-Something -source "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"  -installer "FirefoxInstaller.exe" -arguments "/S"
Install-Something -source "https://www.dnielectronico.es/descargas/CSP_para_Sistemas_Windows/Windows_64_bits/DNIe_v14_1_0(64bits).exe"  -installer "DNIeInstaller.exe" -arguments "/la","/s","/v","/qn"
Install-Something -source "https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma64.zip" -installer "AutoFirma64.zip" -arguments "/S"
