function Executer-VBoxCmde {
    Param (
     [string] $pArguments
    )

    Start-Process -NoNewWindow -FilePath "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" -ArgumentList "$pArguments"
}
 
function Ajouter-Machine {
    Param (
     [string] $pNomMachine,
     [string] $pTypeOS,
     [int] $pRamMo,
     [string] $pRepertoireRacine
    )
    Executer-VBoxCmde "createvm --name $pNomMachine --ostype $pTypeOS --register --basefolder $pRepertoireRacine"
    Executer-VBoxCmde "modifyvm $pNomMachine  --ioapic on --chipset ich9 --memory $pRamMo --vram 128 --rtcuseutc on --boot1 dvd --boot2 disk"
    Executer-VBoxCmde "modifyvm $pNomMachine --graphicscontroller vmsvga"
}

function Ajouter-DisqueSata {
    Param (
     [string] $pNomMachine,
     [string] $pNomFichier,
     [int] $pTailleMo,
     [int] $pNumPort,
     [int] $pNumDisque
    )
    Executer-VBoxCmde "createhd --filename $pNomFichier --size $TailleMo --format VDI"
    Eecuter-VBoxCmde "storagectl $pNomMachine --name ""SATA Controller"" --add sata --controller IntelAhci"
    Executer-VBoxCmde "storageattach $pNomMachine --storagectl ""SATA Controller"" --port $pNumPort --device $pNumDisque --type hdd --medium $NomFichier"
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
[xml]$xml = get-content (".\lin-orl-002.xml")
$machine = $xml.machine

Write-Host "Creation de la machine "$machine.nom "["$machine.os_type"] dans "$machine.repertoire_racine
Ajouter-Machine $machine.nom $machine.os_type $machine.memoire_mo $machine.repertoire_racine
