#!/bin/bash

# Check if the user provided an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Take the first argument as the directory name
DIR="$1/"

# Define the input and output files
INTPUT_DIR="sim_input/"
IMEMIN="imemin.txt"
DMEMIN="dmemin.txt"
DISKIN="diskin.txt"
IRQ2IN="irq2in.txt"

# Define the output files
OUTPUT_DIR="sim_output/"
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
./sim/sim "$PROGRAMS_DIR$DIR$INTPUT_DIR$IMEMIN" "$PROGRAMS_DIR$DIR$INTPUT_DIR$DMEMIN" \
          "$PROGRAMS_DIR$DIR$INTPUT_DIR$DISKIN" "$PROGRAMS_DIR$DIR$INTPUT_DIR$IRQ2IN" \
          "$PROGRAMS_DIR$DIR$OUTPUT_DIR$DMEMOUT" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$REGOUT" \
          "$PROGRAMS_DIR$DIR$OUTPUT_DIR$TRACE" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$HWREGTRACE" \
          "$PROGRAMS_DIR$DIR$OUTPUT_DIR$CYCLES" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$LEDS" \
          "$PROGRAMS_DIR$DIR$OUTPUT_DIR$DISPLAY" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$DISKOUT" \
          "$PROGRAMS_DIR$DIR$OUTPUT_DIR$MONITOR" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$MONITOR_YUV"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Simulation completed successfully."
else
    echo "Simulation failed."
    exit 1
fi

#gcc main.c registers.c monitor.c memory.c io.c interrupts.c instruction_fetch.c instruction_decode.c execution.c disk.c -o sim