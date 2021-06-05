function Executer-VBoxCmde {
    Param (
     [string] $pArguments
    )

    Start-Process -NoNewWindow -FilePath "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" -ArgumentList "$pArguments"
}

<# 
function Ajouter-Machine {
    Param (
     [string] $NomMachine,
     [string] $NomFichier,
     [int] $RamMo,
     [int] $NumPort,
     [int] $NumDisque
    )

   VBoxManage modifyvm $NomMachine  --ioapic on --chipset ich9 --memory $RamMo --vram 128 --rtcuseutc on --boot1 dvd --boot2 disk
   VBoxManage modifyvm $NomMachine --graphicscontroller vmsvga
} #>

function Ajouter-DisqueSata {
    Param (
     [string] $NomMachine,
     [string] $NomFichier,
     [int] $TailleMo,
     [int] $NumPort,
     [int] $NumDisque
    )
     write-host "VBoxManage createhd --filename "$NomFichier" --size "$TailleMo" --format VDI"
     write-host "VBoxManage storagectl "$NomMachine" --name ""SATA Controller"" --add sata --controller IntelAhci"
     write-host "VBoxManage storageattach "$NomMachine" --storagectl ""SATA Controller"" --port "$NumPort" --device "$NumDisque" --type hdd --medium  "$NomFichier
}

# $ImportData = Import-Csv "modele_lin-orl.csv" -delimiter ";"
# foreach ( $Data in  $ImportData )
# {
# 	$fichier_complet = $Data.machine + "_" + $Data.fichier
#      Ajouter-DisqueSata $Data.machine $fichier_complet $Data.taille $Data.port $Data.device
# } 
#$NomMachine = "lin-orl-002"
# $RamMo = 4096
#Executer-VBoxCmde "createvm --name $NomMachine  --ostype Oracle_64 --register --basefolder H:\projets\VBox\Vms"
#Lecture du fichier.
[xml]$xml = get-content ("H:\projets\scripts\pws\lin-orl-002.xml")

#Je récupéré dans $Livres les données entre la balise <Livres> et </Livres>.
$machine = $xml.machine

#Puis j'affiche mes données.
Write-Host $machine.nom
Write-Host $machine.os_type
Write-Host $machine.disques[0]
