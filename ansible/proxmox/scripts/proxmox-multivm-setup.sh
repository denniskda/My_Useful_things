#!/usr/bin/bash
# Script for automate setup of multiple vms. 
# I use this approach instead of roles to keep ansible work dir simple as possible 
workdir=/path/to/workdir
# Pass your inventory file as argument to script
ansible_inventory=$1
vms=("list of vms")

for vm in "${vms[@]}"; do
if [ -e $workdir/misc/vm_parameters/$vm ] ; #Check is vm parameters directory exists
then

echo "starting ansible playbook for $vm"

ansible-playbook -i $workdir/inv/$ansible_inventory.yml \ 
                    $workdir/plb/create_vm_from_template.yml \
                    --extra-vars vm=$vm \

if [ $? != 0 ];
then
    echo "VM clone failed for $vm"
    exit 1
fi

else
echo "$vm parameters directory don't exist"
exit 1
fi

echo "$vm setup success"
done

