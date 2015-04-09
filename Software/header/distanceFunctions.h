
#include <stdio.h>
#include <io.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <time.h>
#include <stdbool.h>


#define classifier_core_base (volatile int *) 0x2400
#define euclidean_adder_core_base (volatile int *) 0x2c00

unsigned int encode(short int address, unsigned short int value);

