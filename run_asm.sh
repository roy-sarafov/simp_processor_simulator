#!/bin/bash

# Check if the user provided an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Take the first argument as the directory name
PROGRAMS_DIR="programs/"
DIR="$1/"

# Define the input and output files
INPUT_DIR="asm_input/"
ASM="$1.asm"

# Define the output files
OUTPUT_DIR="sim_input/"
IMEMIN="imemin.txt"
DMEMIN="dmemin.txt"

# Run the assembler with the specified directory
./asm/asm "$PROGRAMS_DIR$DIR$INPUT_DIR$ASM" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$IMEMIN" "$PROGRAMS_DIR$DIR$OUTPUT_DIR$DMEMIN"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Assembler completed successfully."
else
    echo "Assembler failed."
    exit 1
fi