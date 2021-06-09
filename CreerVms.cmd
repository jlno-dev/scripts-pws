SET MACHINE=lin-orl-002
SET REP_VM=D:\VirtualBox\Machines

SET DISQUE_DVD=D:\install\images.iso\Linux\OracleRedhat_7_V74844-01.iso


REM VBoxManage createvm --name %MACHINE% --ostype Oracle_64 --register --basefolder %REP_VM%

VBoxManage modifyvm %MACHINE%  --ioapic on --chipset ich9 --memory 4096 --vram 128 --rtcuseutc on --boot1 dvd --boot2 disk
VBoxManage modifyvm %MACHINE%  --graphicscontroller vmsvga

REM ------------------------------------------------------
REM Ajout de disques sata pour le systeme
REM ------------------------------------------------------
VBoxManage createhd --filename %DISQUE_SYSTEME% --size 15000 --format VDI
VBoxManage storagectl %MACHINE% --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach %MACHINE% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  %DISQUE_SYSTEME%

REM ------------------------------------------------------
REM Ajout de disques sata pour les applications
REM ------------------------------------------------------
VBoxManage createhd --filename %DISQUE_APPL_1% --size 12000 --format VDI
VBoxManage storagectl %MACHINE% --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach %MACHINE% --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium  %DISQUE_APPL_1%

VBoxManage createhd --filename %DISQUE_APPL_2% --size 12000 --format VDI
VBoxManage storagectl %MACHINE% --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach %MACHINE% --storagectl "SATA Controller" --port 1 --device 1 --type hdd --medium  %DISQUE_APPL_2%

REM ------------------------------------------------------
REM Ajout de cdrom
REM ------------------------------------------------------
VBoxManage storagectl %MACHINE% --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach %MACHINE% --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium %DISQUE_DVD%

VBoxManage modifyvm %MACHINE% --boot1 dvd --boot2 disk --boot3 none --boot4 none