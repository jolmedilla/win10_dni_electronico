function Install-WithZippedExe
{
    param( [string]$Source, [string]$Installer, [string[]]$Arguments )
    $LocalTempDir = $env:TEMP; 
    $output="$LocalTempDir\$Installer"

    try {
        (new-object    System.Net.WebClient).DownloadFile($Source, $output); 
        Expand-Archive -Path $output -DestinationPath "$LocalTempDir\ExpandedArchive"
        $file = Get-ChildItem "$LocalTempDir\ExpandedArchive\*.exe"
        $output = $file.FullName
        $p = Start-Process $output -ArgumentList $Arguments -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }
        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})

    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$Installer" -ErrorAction SilentlyContinue -Verbose
    }

}

Install-WithZippedExe -source "https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma64.zip" -installer "AutoFirma64.zip" -arguments "/S"
