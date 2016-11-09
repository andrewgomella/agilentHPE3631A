#!/bin/bash 
chmod +x st.cmd
procServ --allow -n "HP-DCPS" -p pid.txt -L log.txt --logstamp -i ^D^C 2010 ../../bin/$EPICS_HOST_ARCH/agilentHPE3631A st.cmd
sleep 10

