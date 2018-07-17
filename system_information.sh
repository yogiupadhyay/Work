#!/bin/bash




###################################################################################################
#####
#####
##### This script will help to create the banner for login, will also share the details of the nodes
##### This script tracks
#+---------------------------------------------------------------------------------------+
#|                   Username    |                                           Yogi        |
#|                       Time    |                   Tue Jul 10 09:53:46 CDT 2018        |
#+-------------------------------+-------------------------------------------------------+
#|            Static hostname    |                                        testbed        |
#|                     Kernel    |               Linux 3.10.0-514.16.1.el7.x86_64        |
#|           Operating System    |                       RHEL Server release 7.4         |
#|                    IP-Addr    |                                  192.168.0.112        |
#|               Product-Name    |                        VMware Virtual Platform        |
#+-------------------------------+-------------------------------------------------------+
#|               Load Average    |                               0.15, 0.27, 0.25        |
#|                Login Users    |                                              2        |
#|                Uptime Days    |                                       427 days        |
#+-------------------------------+-------------------------------------------------------+
#|                  Swap Used    |                                          2.20%        |
#|                   RAM Used    |                                         49.17%        |
#+-------------------------------+-------------------------------------------------------+
###################################################################################################
#####  Owner : Yogi
#####  Github id: yogiupadhyay
#####  Date: 10/July/2018
#####  Version : 1.0
#####
#####
###################################################################################################

#echo "+---------------------------------------------------------------------------------------+"


### set username variable from id command
username=$(id|cut -d')' -f1|cut -d'(' -f2)


### set the date for the timestamp in dt variable
dt=$(date)





####print the username and system date and time


### extract hostnamectl details from system



## for rhel 6.x

os_version=$(cat /etc/redhat-release| cut -d'(' -f1|sed "s|Red Hat Enterprise Linux |RHEL |g")
os_ker_verison=$( uname -r)
ipdet=$(hostname -i)

#sys_vendor=$(cat /sys/devices/virtual/dmi/id/sys_vendor)
#echo "Sys-Vendor: $sys_vendor"|awk -F':' '{printf "|\t\033[01;92m%20s\t\033[0m|\t\033[01;96m%40s\t\033[0m|\n",$1,$2}'


product_name=$(cat /sys/devices/virtual/dmi/id/product_name)




#######################################################################
#### Storing host uptime days details in uptime_days variable



uptime_days=$(uptime|cut -d, -f1| awk -F'p' '{print $2}'|sed "s|^ ||g")

#######################################################################
#### Storing host logged in users count in logged_in variable



logged_in=$(uptime|cut -d, -f3| awk '{print $1}')



#######################################################################
#### Storing host load average in load_avg variable

load_avg=$(uptime| grep load| cut -d':' -f5|sed "s|^ ||g")

ipdet=$(hostname -i)










#### Memory usage
Mem_used=$(free -m | grep "^Mem"| awk '{printf "%0.2f %\n", ($3/$2)*100}')
swap_used=$(free -m | grep "^Swap"| awk '{printf "%0.2f %\n", ($3/$2)*100}')

#### Disk Space
disk_space=$(df -Ph | awk '0+$5 >= 80 {print}')


runlevel=`who -r | awk '{print $2}'`


echo -e "     ┌────────────────────────────────────────────────────────────────────
     │              • \033[01;92mSummary Of $(hostname)\033[0m  •
     │
     │ ➤ \033[01;96mSSH session\033[0m
     │   • Active users     :   \033[01;95m$logged_in\033[0m
     │   • Hostname         :   \033[01;95m$(hostname)\033[0m
     │   • Username         :   \033[01;95m$username\033[0m
     │   • IP address       :   \033[01;95m$ipdet \033[0m
     │
     │ ➤ \033[01;96mOS details\033[0m
     │   • Kernel           :   \033[01;95m$os_ker_verison  \033[0m
     │   • OS               :   \033[01;95m$os_version     \033[0m
     │   • Product-name     :   \033[01;95m$product_name   \033[0m
     │   • Run level        :   \033[01;95m$runlevel\033[0m
     │
     │ ➤ \033[01;96mServer details\033[0m
     │   • Swap             :   \033[01;95m$swap_used  \033[0m
     │   • Memory           :   \033[01;95m$Mem_used  \033[0m
     │   • Load average     :   \033[01;95m$load_avg     \033[0m
     │   • Uptime           :   \033[01;95m$uptime_days    \033[0m
     │   • Disk Space above 80%	    :	\033[01;95m$disk_space     \033[0m
     │ ➤ \033[01;96mDate-time\033[0m          :   \033[01;95m$dt \033[0m
     └────────────────────────────────────────────────────────────────────"
