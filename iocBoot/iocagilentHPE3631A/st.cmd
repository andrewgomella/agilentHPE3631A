############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
< envPaths

# For deviocstats
epicsEnvSet("ENGINEER", "Andrew Gomella")
epicsEnvSet("LOCATION", "B1D521C")
epicsEnvSet("STARTUP","$(TOP)/iocBoot/$(IOC)")
epicsEnvSet("ST_CMD","st.cmd")

# For stream proto file
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

epicsEnvSet "P" "$(P=VPFI:AGILENT:dcps)"
epicsEnvSet "R" "$(R=)"
############################################################################
# Increase size of buffer for error logging from default 1256
errlogInit(20000)
############################################################################
# Register all support components
cd $(TOP)
dbLoadDatabase "dbd/agilentHPE3631A.dbd"
agilentHPE3631A_registerRecordDeviceDriver pdbbase
############################################################################
# Set up ASYN ports
GpibBoardDriverConfig("agilent",10,0,3,0)
asynInterposeEosConfig("agilent",10,1,1)
asynOctetSetInputEos("agilent",10,"\n")
asynOctetSetOutputEos("agilent",10,"\n")
#asynSetTraceIOMask("agilent",1,0x2)
#asynSetTraceMask("agilent",1,0x9)
############################################################################
# Load record instances
dbLoadRecords("db/devagilentHPE3631A.db","P=$(P), R=$(R), PORT=agilent, A=10")
dbLoadRecords("db/iocAdminSoft.db","IOC=$(P)")
############################################################################
# Start EPICS IOC
cd $(STARTUP)
iocInit
############################################################################
# write all the PV names to a local file
dbl > records.txt
############################################################################
# Set power supply voltage and current settings to 0
dbpf("$(P):SetP6Volts", "0")
dbpf("$(P):SetP6Amps", "0")
############################################################################
# print the time our boot was finished
date
############################################################################
