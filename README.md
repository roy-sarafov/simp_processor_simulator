# SIMP Processor Simulator

The SIMP Processor Simulator is a simple educational tool that simulates a custom processor. It allows users to write assembly code, assemble it into machine code, and run the instructions through a software-based CPU simulator.

## Project Directory Structure

```
SIMP_Processor_Simulator/
│-- asm/                        # Assembler code and executable
│   ├── asm                     # Assembler executable
│   ├── main.c                  # Assembler source code
│
│-- programs/                   # Program examples
│   ├── binom/                  # Binomial coefficient calculation program
│   │   ├── asm_input/          # Assembly input files
│   │   │   ├── binom.asm       # Assembly source code for binom
│   │   ├── sim_input/          # Simulation input files
│   │   │   ├── diskin.txt      # Disk input file
│   │   │   ├── dmemin.txt      # Data memory input
│   │   │   ├── imemin.txt      # Instruction memory input
│   │   │   ├── irq2in.txt      # IRQ2 input file
│   │   ├── sim_output/         # Simulation output files
│   │       ├── cycles.txt      # Number of execution cycles
│   │       ├── diskout.txt     # Disk output file
│   │       ├── display7seg.txt # 7-segment display output
│   │       ├── dmemout.txt     # Data memory output
│   │       ├── hwregtrace.txt  # Hardware register trace
│   │       ├── leds.txt        # LED output trace
│   │       ├── monitor.txt     # Monitor output
│   │       ├── monitor.yuv     # Monitor graphical output in YUV format
│   │       ├── regout.txt      # Register values after execution
│   │       ├── trace.txt       # Execution trace
│   ├── circle/                 # Circle drawing program
│   ├── disktest/               # Disk-related tests and utilities
│   ├── fib/                    # Fibonacci sequence program
│   ├── mulmat/                 # Matrix multiplication program
│
│-- sim/                        # Simulator source code
│   ├── disk.c                  # Disk operations implementation
│   ├── disk.h                  # Disk operations header
│   ├── execution.c             # Execution logic implementation
│   ├── execution.h             # Execution logic header
│   ├── instruction_decode.c    # Instruction decoding implementation
│   ├── instruction_decode.h    # Instruction decoding header
│   ├── instruction_fetch.c     # Instruction fetching implementation
│   ├── instruction_fetch.h     # Instruction fetching header
│   ├── interrupts.c            # Interrupt handling implementation
│   ├── interrupts.h            # Interrupt handling header
│   ├── io.c                    # I/O operations implementation
│   ├── io.h                    # I/O operations header
│   ├── main.c                  # Main entry point of the simulator
│   ├── memory.c                # Memory management implementation
│   ├── memory.h                # Memory management header
│   ├── monitor.c               # Monitor (display) handling implementation
│   ├── monitor.h               # Monitor (display) handling header
│   ├── registers.c             # Register operations implementation
│   ├── registers.h             # Register operations header
│
│-- .gitignore                  # Git ignore file
│-- README.md                   # Project documentation (this file)
│-- run_asm.sh                  # Script to run assembler
│-- run_sim.sh                  # Script to run simulator
```

## Installation and Setup

### 1. Build the Assembler and Simulator

To compile the assembler and simulator, run the following commands:

```bash
# Build the assembler
cd <simp_processor_simulator_path>/asm
gcc -o asm main.c

# Build the simulator
cd <simp_processor_simulator_path>/sim
gcc -o sim main.c disk.c execution.c instruction_decode.c instruction_fetch.c interrupts.c io.c memory.c monitor.c registers.c
```

## Usage

### 1. Running the Simulator with Shell Scripts

To begin, create a directory for your program and place it inside the programs directory. 
Each program directory should contain the following three subdirectories:
1. asm_input: This is where the <program>.asm file should be stored.
2. sim_input: This directory will store the assembler's output. Ensure that diskin.txt and irq2in.txt are placed here before running the simulator.
3. sim_output: This is where the simulator's output files will be generated.

It's important to name the program directory and the corresponding .asm file with the same name.

For instance, to run the binomial coefficient program, use the following commands:

```bash
cd <simp_processor_simulator_path>
./run_asm.sh binom
./run_sim.sh binom
```

### 2. Running Manually via Command Line

If you prefer to manually assemble and run the simulator, follow these steps:

#### Step 1: Assemble the Program

Navigate to the directory containing the `.asm` file and run the assembler:

```bash
../asm/asm program.asm imemin.txt dmemin.txt
```

#### Step 2: Run the Simulator

After assembling, run the simulator with the necessary memory and I/O files:

```bash
../sim/sim imemin.txt dmemin.txt diskin.txt irq2in.txt dmemout.txt regout.txt trace.txt hwregtrace.txt cycles.txt leds.txt display7seg.txt diskout.txt monitor.txt monitor.yuv
```

## File Descriptions

| File              | Description                            |
|-------------------|----------------------------------------|
| `program.asm`     | Assembly source code                   |
| `imemin.txt`      | Instruction memory input (generated)   |
| `dmemin.txt`      | Data memory input (generated)          |
| `diskin.txt`      | Disk input file                        |
| `irq2in.txt`      | IRQ2 input file                        |
| `dmemout.txt`     | Data memory output after execution     |
| `regout.txt`      | Register values after execution        |
| `trace.txt`       | Execution trace                        |
| `hwregtrace.txt`  | Hardware register trace                |
| `cycles.txt`      | Number of execution cycles             |
| `leds.txt`        | LED output trace                       |
| `display7seg.txt` | 7-segment display output               |
| `diskout.txt`     | Disk output file                       |
| `monitor.txt`     | Monitor output                         |
| `monitor.yuv`     | Monitor graphical output in YUV format |

## Cleaning Up

To remove output files generated during simulation, run the following command:

```bash
rm *.txt
```

## Troubleshooting

- If you encounter permission issues, make sure the scripts are executable:

  ```bash
  cd <simp_processor_simulator_path>
  chmod +x run_asm.sh
  chmod +x run_sim.sh
  ```

- Ensure you have `gcc` installed by running:

  ```bash
  gcc --version
  ```

## Future Improvements

- Additional assembly instructions for enhanced functionality.
- GUI interface to visualize memory and register values.
- Performance optimizations.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Author

- Roy Sarafov and Yoav Dychtawald 
- Email: sarafov.roy@gmail.com & yoavhaid@mail.tau.ac.il
- GitHub: [github.com/roy-sarafov] [github.com/yoav-43]
