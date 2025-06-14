#!/bin/bash

export ToolPath="/home/dynamicx/rm_ws/src/rm_bringup/scripts/eeprom_tools"
export EthName="enp49s0"
export SlaveOrder=1
export EEpromType="MIT"  # use DBUS for rm/dbus slaves, or use MIT for mit slaves

sudo su -c "
    export ToolPath=\"$ToolPath\"
    export EthName=\"$EthName\"
    export SlaveOrder=\"$SlaveOrder\"
    export EEpromType=\"$EEpromType\"

    cd \$ToolPath || { echo \"\$ToolPath does not exist, please check again\"; exit 1; }
    chmod 777 eepromtool
    if [ \"\$EEpromType\" = \"DBUS\" ]; then
        ./eepromtool \$EthName \$SlaveOrder -wi eeprom_dbus.hex
    elif [ \"\$EEpromType\" = \"MIT\" ]; then
        ./eepromtool \$EthName \$SlaveOrder -wi eeprom_mit.hex
    else
        echo \"Unknown EEpromType: \EEpromType\"
        exit 1
    fi
    exit
    exec bash
"
