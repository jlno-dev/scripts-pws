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


[xml]$xml = get-content (".\lin-orl-002.xml")
$machine = $xml.machine

Write-Host "Creation de la machine "$machine.nom "["$machine.os_type"] dans "$machine.repertoire_racine
Ajouter-Machine $machine.nom $machine.os_type $machine.memoire_mo $machine.repertoire_racine
