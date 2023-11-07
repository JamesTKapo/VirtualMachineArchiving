#Archiving VMs to create backups
-This bash script will create a complete backup of a single VM the user specifies.

#How it works
-First, the user is presented with an echo displaying the usage of and permission of sudo access.
-Thereafter it will present the user with a list of names of all the VMs on the current machine with the help of a Virsh manager command.
-It will then be up to the user to select the VM they wish to backup.
-Once the user has entered a name, the script will create a tar archive that contains the VMs XML and qcow2 files compressed using gzip from the correct path that was obtained by grepping the XML file.
-At completion, the archive will hold the naming convention VM name, current date, and proper extension for the compression type.

