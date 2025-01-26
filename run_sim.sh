#!/bin/bash

# Check if the user provided an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Take the first argument as the directory name
DIR="$1/"

# Define the input and output files
IMEMIN="imemin.txt"
DMEMIN="dmemin.txt"
DISKIN="diskin.txt"
IRQ2IN="irq2in.txt"

# Define the output files
DMEMOUT="dmemout.txt"
REGOUT="regout.txt"
TRACE="trace.txt"
HWREGTRACE="hwregtrace.txt"
CYCLES="cycles.txt"
LEDS="leds.txt"
DISPLAY="display7seg.txt"
DISKOUT="diskout.txt"
MONITOR="monitor.txt"
MONITOR_YUV="monitor.yuv"

# Run the simulation
./sim/sim "$DIR$IMEMIN" "$DIR$DMEMIN" "$DIR$DISKIN" "$DIR$IRQ2IN" \
    "$DIR$DMEMOUT" "$DIR$REGOUT" "$DIR$TRACE" "$DIR$HWREGTRACE" \
    "$DIR$CYCLES" "$DIR$LEDS" "$DIR$DISPLAY" "$DIR$DISKOUT" "$DIR$MONITOR" "$DIR$MONITOR_YUV"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Simulation completed successfully."
else
    echo "Simulation failed."
    exit 1
fi