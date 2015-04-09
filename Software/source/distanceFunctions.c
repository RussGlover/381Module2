#include "classifier_core.h"
//Calculates the distance between the sample and each entry in the library
//Library is a 2d [library size]*8 array containing the 8 short int values of each bin value for the library of songs
//Each row represents a song and each column represents a bin value
//Sample is an 8 bit array of short ints that has the bin data for the current sample
//Distances is an array of [library size] to return the summed distances between the sample and each library entry
//Length is the number of elements in the library (must be a factor of 64 for now?)
void getDistances(short int** library, short int* sample, int* distances, int length)
{
	//Indexes
	int i,j,k;

	// Array to store intermediate distance values for each bin
	int binDistances[8][64];

	//This loop goes through the entire library, 64 songs at a time.
	//K represents the index of the first element in the current 64 songs
	for(k = 0; k < length ; k += 64)
	{
		//This loop computes the distance between a specific bin of each of the 64 songs and the sample
		//i indexes the current bin (row)
		for(i = 0; i < 8; i++)
		{
			printf("Resetting core \n");
			//Reset core
			IOWR_32DIRECT(classifier_core_base,0,0);
			printf("Core reset \n");

			//This loop loads the bin values into the euclidean_single_bin interface
			//J indexes the current sample [row]
			for( j = 0; j < 64; j++)
				{
					//In this command, encode translate 2 16 bit values into a 32 bit value
					//The first value, j, represents the index of a specific bin
					//The second value provides the value of the bin.
					//i is constant, and selects the bin
					//j+k indexes the song within the library
					IOWR_32DIRECT(classifier_core_base,4,encode(j, library[(j+k)][i]));
				}

			// This command writes the current bin of the sample
			IOWR_32DIRECT(classifier_core_base,8,sample[i]);


			//This loop reads the distance between the current bin of each library song and the sample
			// and stores it vertically in the 2D bin distances array
			//J indexes the library song
			for(j = 0; j < 64 ; j++)
				{
					binDistances[i][j] = IORD_32DIRECT(classifier_core_base,j);
				}
		}

		//These two loops load the distance of each bin for a sample into the adder and sums them
		//I indexes the current library song
		//J indexes the current bin
		for(i = 0; i < 64; i++)
		{
			for(j = 0; j <  8; j++)
			{
				//This command writes the value to the adder
				//j is the bin(row) and i is the sample (column)
				IOWR_32DIRECT(euclidean_adder_core_base,4*j, binDistances[j][i]);
			}
			//This command reads the sum of the bin distances from a library song and stores them in the distances array
			//I represents the current sample
			distances[(k+i)] = IORD_32DIRECT(euclidean_adder_core_base,0);
		}
	}
}


unsigned int encode(short int address, unsigned short int value)
{
	unsigned int temp = 0;
	temp = temp | address;
	temp <<= 16;
	temp = temp | value;
	return temp;
}
