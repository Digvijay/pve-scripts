#!/bin/bash
# create-template-jammy-minimal.sh

imageName="jammy-server-cloudimg-amd64.img"
imageURL="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

templateName="ubuntu-jammy-cloudinit-templ"
volumeName="local-lvm"
virtualMachineId="$TEMPLATE_ID"
cloneId="$CLONE_ID"
cloneName="$CLONE_NAME"


tmp_cores="24"
tmp_memory="61440"
rootPasswd="$VMPASSWORD"
cpuTypeRequired="host"
userName="$VMUSER"
sshkeys_pub="./authorized_keys"

apt update
wget -O $imageName $imageURL

qm destroy $cloneId
qm destroy $virtualMachineId

qm create $virtualMachineId --name $templateName --memory $tmp_memory --cores $tmp_cores --net0 virtio,bridge=vmbr0
qm importdisk $virtualMachineId $imageName $volumeName
qm set $virtualMachineId --scsihw virtio-scsi-pci --scsi0 $volumeName:vm-$virtualMachineId-disk-0
pvesm alloc $volumeName $virtualMachineId  '' 1G
qm set $virtualMachineId --scsihw virtio-scsi-pci --scsi1 $volumeName:vm-$virtualMachineId-disk-1

qm set $virtualMachineId --boot c --bootdisk scsi0
qm set $virtualMachineId --ide2 $volumeName:cloudinit
#qm resize $virtualMachineId scsi0 40G
qm set $virtualMachineId --serial0 socket --vga serial0
qm set $virtualMachineId --ipconfig0 ip=dhcp
qm set $virtualMachineId --cpu cputype=$cpuTypeRequired
qm set $virtualMachineId --agent 1
qm set $virtualMachineId --ciuser $userName
qm set $virtualMachineId --cipassword $rootPasswd
qm set $virtualMachineId --sshkeys ./authorized_keys
qm set $virtualMachineId --tags ubuntu,template,22.04,jammy,cloudinit
qm template $virtualMachineId

# Create a VM from the template
qm clone $virtualMachineId $cloneId -format qcow2 -full 1 -name $cloneName
qm resize $cloneId scsi0 600G
qm resize $cloneId scsi1 100G
qm set $cloneId --ipconfig0 ip=192.168.86.93/24,gw=192.168.86.1
qm set $cloneId --tags ubuntu,docker,22.04