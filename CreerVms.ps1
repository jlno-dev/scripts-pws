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
}

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

$ImportData = Import-Csv "D:\projets\vbox\admin\modele_lin-orl.csv" -delimiter ";"
foreach ( $Data in  $ImportData )
{
	$fichier_complet = $Data.repertoire_base + "\" + $Data.machine + "_" + $Data.fichier
     Ajouter-DisqueSata $Data.machine $fichier_complet $Data.taille $Data.port $Data.device
} 