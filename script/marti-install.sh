#!/bin/bash

# SCRIPT  : marti-install.sh
# PURPOSE : A menu driven Shell script using dialog utility
#           which walks the user through the marti install process.
#
##############################################################################
#                 Checking availability of dialog utility                    #
##############################################################################

# dialog is a utility installed by default on all major Linux distributions.
# But it is good to check availability of dialog utility on your Linux box.

which dialog &> /dev/null

[ $? -ne 0 ]  && echo "Dialog utility is not available, Install it" && sudo apt-get install dialog && exit 1


##############################################################################
#                            Global variables                                #
##############################################################################
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=10
BACKTITLE="MARTI Installation"
TITLE="Installation Menu"
MENU="Choose one of the following options:"
DIR=/opt/marti/marti

OPTIONS=(1  "Download MARTI"
    2  "Install MARTI"
    3  "Create temporary ssl cert"
    4    "Setup apache instance"
    5    "Initialize log file"
    6     "Adjust TCP for many users"
    7      "Start Marti server"
    8      "TO EXIT")

##############################################################################
#                      Define Functions Here                                 #
##############################################################################

###################### deletetempfiles function ##############################

# This function is called by trap command
# For conformation of deletion use rm -fi *.$$

deletetempfiles()
{
    rm -f *.$$
}

######################## Grab_MARTI function #################################

# Sets up the folders and clones the repo

grab_marti()
{
    echo "[*] Making directories and cloning repositories"
    sudo chmod 777 /opt
    cd /opt
    mkdir marti
    cd marti
    echo "[*] Cloning marti-services repo"
    git clone apluser@marti.taxii.jhuapl.edu:/opt/git/marti-services.git
    cd marti-services
    git checkout dev
    cd ../
    echo "[*] Cloning marti repo"
    git clone apluser@marti.taxii.jhuapl.edu:/opt/git/marti.git
    cd marti
    git checkout dev

}

######################## adjust_tcp function #################################

# Adjust the TCP parameters to allow for more traffic
adjust_tcp()
{
    echo "[*] Adjusting TCP Parmeters"
    sudo cp $DIR/extras/rc.local /etc/
    sudo chown root /etc/rc.local
    sudo chmod 755 /etc/rc.local
    sudo /etc/rc.local start
    sudo /etc/init.d/rc.local start
}

######################## install function #################################

# Installs all the dependencies and runs the bootstrap
install()
{
    echo "[*] Installing dependencies"
    sudo apt-get update
    sudo apt-get install -y python-m2crypto
    sudo apt-get install -y libffi-dev
    sudo apt-get install -y python-pip
    pip install --upgrade pip
    echo "[*] Running marti setup"
    cd $DIR
    ./script/bootstrap
    echo "[*] Installing apache"
    sudo apt-get install -y apache2 libapache2-mod-wsgi

    mkdir /opt/certs
    cp $DIR-services/taxii_service/certs/* /opt/certs/
    python manage.py setconfig service_dirs $DIR-services/
}

######################## init_log function #################################

# Sets up the log file
init_log()
{
    echo "[*] Setting up log file"
    sudo adduser crits
    sudo chgrp -R crits $DIR/logs
    touch $DIR/logs/crits.log
    chmod 777 $DIR/logs/crits.log
}

######################## apache_setup function #################################

# Setup the apache server
apache_setup()
{
    echo "[*] Apache server setup"
    sudo service apache2 stop
    sudo rm -rf /etc/apache2/sites-available
    sudo mkdir /etc/apache2/conf.d
    sudo cp $DIR/extras/*.conf /etc/apache2
    sudo cp -r $DIR/extras/sites-available /etc/apache2
    sudo rm /etc/apache2/sites-enabled/*
    sudo ln -s /etc/apache2/sites-available/default-ssl /etc/apache2/sites-enabled/default-ssl
    sudo a2dismod mpm_event
    sudo a2enmod mpm_worker
    sudo a2enmod ssl
    export LANG=en_US.UTF-8
}

######################## temp_cert function #################################

# Makes a temporary cert to use for the ssl site
temp_cert()
{
    echo "[*] Temporary cert setup"
    cd /tmp
    sudo openssl req -new > new.cert.csr
    sudo openssl rsa -in privkey.pem -out new.cert.key
    sudo openssl x509 -in new.cert.csr -out new.cert.cert -req -signkey new.cert.key -days 1825
    sudo cp new.cert.cert /etc/ssl/certs/marti.crt
    sudo cp new.cert.key /etc/ssl/private/marti.plain.key
}

######################## start_marti function #################################

# Start MARTI
start_marti()
{
    echo "[*] Starting the marti server for the first time"
    sudo service apache2 start
    wget --no-check-certificate https://localhost

    echo "Press any key to exit..."
    read -n 1
    clear; exit 0
}

##############################################################################
#                           MAIN STRATS HERE                                 #
##############################################################################

trap 'deletetempfiles'  EXIT     # calls deletetempfiles function on exit

while :
do

# Dialog utility to display options list

    dialog --clear --backtitle "INSTALL MARTI" --title "MAIN MENU" \
    --menu "Use [UP/DOWN] key to move" \
    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
     2> menuchoices.$$

    retopt=$?
    choice=`cat menuchoices.$$`

    case $retopt in

           0) case $choice in

                  1)    grab_marti ;;
                  2)    install ;;
                  3)    temp_cert ;;
                  4)    apache_setup ;;
                  5)    init_log ;;
                  6)    adjust_tcp ;;
                  7)    start_marti ;;
                  8)       clear; exit 0;;

              esac ;;

          *)clear ; exit ;;
    esac

    echo "Press any key to continue..."
    read -n 1

done
