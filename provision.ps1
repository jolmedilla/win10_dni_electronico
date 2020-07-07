
function Install-Something
{
    param( [string]$Source, [string]$Installer, [string[]]$Arguments )
    $LocalTempDir = $env:TEMP; 
    $output="$LocalTempDir\$Installer"

    try {
        (new-object    System.Net.WebClient).DownloadFile($Source, $output); 
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
#$autofirma = "https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma64.zip"
#$autofirmazip="$LocalTempDir\AutoFirma64.zip"
#(new-object    System.Net.WebClient).DownloadFile($autofirma, $autofirmazip); 
#Set-Location -Path $LocalTempDir
#Expand-Archive -Path $source
#$file = Get-ChildItem .\Autofirma64\*.exe
#$executableName= $file.Name
#$executable = "$LocalTempDir\Autofirma64\$executableName"
#$proces = Start-Process $executable -ArgumentList "/S"
#while (!$process.HasExited) { Start-Sleep -Seconds 1 }
#Write-Output ([PSCustomObject]@{Success=$process.ExitCode -eq 0;Process=$process})
#Set-Location $LocalTempDir
#Remove-Item "$LocalTempDir\Autofirma64" -ErrorAction SilentlyContinue -Verbose
#Remove-Item $autofirmazip -ErrorAction SilentlyContinue -Verbose
