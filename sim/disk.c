#define _CRT_SECURE_NO_WARNINGS
#include "disk.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void init_disk(const char *input_filename, const char *output_filename, Disk *disk) {
	disk->timer = 0;

	// Open input and output files
	FILE *input_file = fopen(input_filename, "r");
	FILE *output_file = fopen(output_filename, "w");

	if (!input_file || !output_file) {
		printf("Error: Could not open disk input or output file.\n");
		if (input_file) fclose(input_file);
		if (output_file) fclose(output_file);
		return;
	}

	char line[9]; // Buffer for 8 hex digits + null terminator
	int word_count = 0;

	// Read words from the input file and write to the output file
	while (fgets(line, sizeof(line), input_file)) {
		line[strcspn(line, "\r\n")] = '\0'; // Remove newline characters

		// Validate line length and content
		if (strlen(line) != 8) {
			continue;
		}

		// Write the word to the output file without padding errors
		fprintf(output_file, "%s\n", line);
		word_count++;

		// Stop processing if the disk size is reached
		if (word_count >= (NUM_OF_SECTORS * SECTOR_SIZE) / 4) {
			break;
		}
	}

	fclose(input_file);
	fclose(output_file);
}



// Functionality: Handle a read sector operation from the disk file.
void read_sector(Memory *memory, const IORegisters *io, const char *output_filename) {
	uint32_t sector = io->IORegister[DISKSECTOR];
	uint32_t buffer = io->IORegister[DISKBUFFER];

	FILE *disk_file = fopen(output_filename, "r");
	if (!disk_file) {
		printf("Error: Could not open disk output file for reading.\n");
		return;
	}

	// Seek to the correct sector
	fseek(disk_file, sector * SECTOR_SIZE, SEEK_SET);

	char line[9];
	for (int i = 0; i < SECTOR_SIZE / 4; i++) { // Read SECTOR_SIZE / 4 words (32-bit each)
		if (!fgets(line, sizeof(line), disk_file)) {
			break;
		}

		int32_t word = (int32_t)strtol(line, NULL, 16);
		write_data(memory, buffer + i, word); // Write the word directly into memory
	}

	fclose(disk_file);
}


// Functionality: Handle a write sector operation to the disk file.
void write_sector(const Memory *memory, const IORegisters *io, const char *output_filename) {
	uint32_t sector = io->IORegister[DISKSECTOR];
	uint32_t buffer = io->IORegister[DISKBUFFER];

	FILE *disk_file = fopen(output_filename, "r+");
	if (!disk_file) {
		printf("Error: Could not open disk output file for writing.\n");
		return;
	}

	// Seek to the correct sector
	fseek(disk_file, sector * SECTOR_SIZE, SEEK_SET);

	for (int i = 0; i < SECTOR_SIZE / 4; i++) { // Write SECTOR_SIZE / 4 words (32-bit each)
		int32_t word = read_data(memory, buffer + i);
		fprintf(disk_file, "%08X\n", word); // Write the word as a hex string
	}

	fclose(disk_file);
}


// Functionality: Handle the disk command and update DMA/IRQ as needed.
void handle_disk_command(Memory *memory, IORegisters *io, Disk *disk, const char *output_filename) {
	if (io->IORegister[DISKSTATUS] == 1) {
		if (disk->timer > 0) {
			disk->timer--;

			if (disk->timer == 0) {
				io->IORegister[DISKCMD] = 0; // Clear diskcmd
				io->IORegister[DISKSTATUS] = 0; // Disk ready
				io->IORegister[IRQ1STATUS] = 1; // Raise IRQ1
			}
		}
		return;
	}

	if (io->IORegister[DISKCMD] != 0) {
		switch (io->IORegister[DISKCMD]) {
		case 1: // Read sector
			read_sector(memory, io, output_filename);
			break;

		case 2: // Write sector
			write_sector(memory, io, output_filename);
			break;

		default:
			break;
		}

		disk->timer = 1024; // Start 1024-cycle countdown
		io->IORegister[DISKSTATUS] = 1; // Disk is busy
	}
}
