// Parker King-Fournier
// MUMT 307 Assignment 6 Question 2
// ass6q2.cpp

// Assuming the stk directory is on the Desktop (with compiled stk library in src/ sub-directory)
// and ass6q2.cpp file in the current directory, you can compile this with:
//  g++ -I/Users/me/Desktop/stk/include/ -L/Users/me/Desktop/stk/src/ -D__MACOSX_CORE__ ass6q1.cpp -lstk -lpthread -framework CoreAudio -framework CoreMIDI -framework CoreFoundation

//Here is my compile statement that I used while testing the code.
// g++ -I/Users/parkerking-fournier/Desktop/Assignment6/stk/include/ -L/Users/parkerking-fournier/Desktop/Assignment6/stk/src/ -D__MACOSX_CORE__ ass6q1.cpp -lstk -lpthread -framework CoreAudio -framework CoreMIDI -framework CoreFoundation

#include "stk/include/SineWave.h"
#include "stk/include/RtWvOut.h"
#include "stk/include/Envelope.h"
#include <vector>

using namespace stk;


int main(int argc, char **argv) {


	//This usage statement checks if all arguments are there and if they are valid
	//it also gives a suggestion, because the values are not straightforward in their 
	//relation to time
	if ( argc != 3 || atoi(argv[1]) == 0 || atoi(argv[2]) == 0) {

		std::cout<<"\nWARNING: usage: ./a.out note_duration program_duration\n";
		std::cout<<"Where note_duration and program_duration are parameters that are integers in milliseconds\n\n";
		std::cout<<"Try ./a.out 500 5000\n\n";
		exit(0);
	}

	//seed random generator
	srandomdev();

	//Set sample rate and show the warnings
	Stk::setSampleRate( 44100.0 );
	Stk::showWarnings( true );

	//Store all variables we will need 
	int note_duration = atoi(argv[1]) * 44100 / 1000;
	int program_duration = atoi(argv[2]) * 44100 / 1000;
	int time_left = 0;
	int cumulative_time = 0;
	int index = 0;

	//The assignment instructions just said 'a pentatonic scale' so this is
	//an array of frequencies that correspond to a one octave C pentatonic scale
	double pentatonic[6] = {261.63, 293.66, 329.63, 392.00, 440.00, 523.25};

	try {

		//Initiate the classes we are using
		//I chose a two channel output for simplicity
		SineWave sine;
		RtWvOut dac( 2 );
		Envelope env;
		env.setTime(5);
		//These nested for loops create as many full length notes as is possible
		//given the constraints. Each time iteration of the outer loop generates a random
		//frequency from the array 'pentatonic'
		for(cumulative_time = 0; cumulative_time + note_duration < program_duration; cumulative_time = cumulative_time + note_duration) {

			index = random() % 6;
			sine.setFrequency(pentatonic[index]);

			//Set the envelope target to 1
			env.keyOn();
			for (int i=0; i<note_duration; i++ ) {

				//Multiply the sine wave amplitude by the envelope
				dac.tick( sine.tick()*env.tick() );
			} 
			//Set the envelope current value and target to 0
			env.setValue(0);
		}

		//calculate the remaining time to make a non-full value note so that the
		//overall program duration is conserved. This wasn't addressed in the assignment
		//but it seemed like the best way to deal with it
		time_left = program_duration - cumulative_time;
		
		//play another last random note for the remaining time.
		index = random() % 6;
		sine.setFrequency(pentatonic[index]);

		//Set the envelope target to 1
		env.keyOn();
		for (int i=0; i<time_left; i++ ) {

			//Multiply the sine wave amplitude by the envelope
			dac.tick( sine.tick()*env.tick() );
		}
	}

	catch ( StkError & ) {

		std::cout<<"\nOh no, there was an error!\n\n";
		exit( 1 );
	}

	exit(0);
}
