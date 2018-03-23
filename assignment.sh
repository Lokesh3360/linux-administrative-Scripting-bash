#!/bin/bash	
	
function host_name_and_domain_name {
echo "
._________________________.
|			  |
| Hostname and Domainname |
|_________________________|
"
#Define variables host_name and domain_name and set values using hostname and hostname -d
host_name=`hostname`
domain_name=`hostname -d`

if [ -n $host_name ]
then
echo "Name of Current System : $host_name"
else
echo "No Hostname on current system"
fi 
#fi command is used to end if command
#[ -z $host_name ] returns the string length
#If [ -z $host_name ] is zero then if block will run else then block will run.

if [ -z $domain_name ]
then
echo "No Domainname on current system"
else
echo "Domain name : $domain_name"
fi
}

function network_detail {
echo "
._________________________.
|		          |
|  Network Configuration  |
|_________________________|
"
echo "IP addresses for this host by interfaces are:"

temp=$(hostname -I)

if [ -z $temp ] 
then
echo "Network is not configured"	
else
echo "$temp"
fi
}


function os_name_and_version {
echo "
._________________________.
|			  |
|   OS Name and Version   |
|_________________________|
"
temp1=$(uname -o)
temp2=$(uname -r)
echo "System name : $temp1"
echo "OS version : $temp2"
}
	
function cpu_detail {
echo "
._________________________.
|			  |
|     CPU Information     |
|_________________________|
"
echo "The CPU Information :"
temp=$(lscpu) 
echo "
$temp
"
}

function memory_detail {
echo "
._________________________.
|			  |
|   Memory Information	  |
|_________________________|
"
echo "Memory installed : "
temp=`cat /proc/meminfo | grep "Mem" `
echo "
Total memory : 
$temp
"
}

function disk_space_detail {
echo "
._________________________.
|			  |
|    Disk Information	  |
|_________________________|
"

echo "Disks Space Available on connected physical hard drives : "
echo "
$(df -h)
"
# awk command is used for printing the 1st column and 4th column of line array
}
	
	
function printer_detail {
echo "
._________________________.
|			  |
|   Printer Information   |	
|_________________________|
"

temp=`lpstat -p 2>STERR | grep "printer" | cut -d " " -f 2`

if [ -z $temp ]
then
echo "No Printers Configured"
else
echo "The configured printers are :" ; echo `lpstat -p | grep "printer"`
fi
}
	
function Help {
echo "
._________________________.
|			  |
|	   Help		  |
|_________________________|
"
echo "
System information options
-s : System name with domain name if it has one
-n : IP addresses for this host by interface, leave out localhost loopback
-o : OS version and name
-c : CPU description
-m : Memory installed
-d : Available disk space on attached physical drives
-p : List of printers configured
"
}

# $# -eq 0 checks the number of arguments if arguments are none (0) then called methods will run and produce information

if [ $# -eq 0 ]; 
then
	host_name_and_domain_name
	network_detail
	os_name_and_version
	cpu_detail
	memory_detail
	disk_space_detail
	printer_detail
echo "

-h option show detail of available options"
fi
while (($#)); do
if [ $1 == "-s" ]; # if argument is -s, hostname and domainname information will be displayed
then 
host_name_and_domain_name
elif [ $1 == "-n" ];  # if argument is -n, network configuration will be displayed
then
network_detail
elif [ $1 == "-o" ];  # if argument is -o, OS name and version will be displayed
then
os_name_and_version
elif [ $1 == "-c" ];  # if argument is -c,cpu information will be displayed
then
cpu_detail
elif [ $1 == "-m" ];  # if argument is -m, memory information will be displayed
then
memory_detail
elif [ $1 == "-d" ];  # if argument is -d, disk space information will be displayed
then
disk_space_detail
elif [ $1 == "-p" ];  # if argument is -p, printer information will be displayed
then
printer_detail
elif [ $1 == "-h" ];  # if argument is -h, Helping information will be displayed
then
Help	
fi
shift
done #END

