// Parker King-Fournier
// MUMT 307 Assignment 6 Question 2
// ass6q2.cpp

// Assuming the stk directory is on the Desktop (with compiled stk library in src/ sub-directory)
// and ass6q2.cpp file in the current directory, you can compile this with:
//  g++ -I/Users/me/Desktop/stk/include/ -L/Users/me/Desktop/stk/src/ -D__MACOSX_CORE__ ass6q2.cpp -lstk -lpthread -framework CoreAudio -framework CoreMIDI -framework CoreFoundation

//Here is my compile statement that I used while testing the code.
// g++ -I/Users/parkerking-fournier/Desktop/Assignment6/stk/include/ -L/Users/parkerking-fournier/Desktop/Assignment6/stk/src/ -D__MACOSX_CORE__ ass6q2.cpp -lstk -lpthread -framework CoreAudio -framework CoreMIDI -framework CoreFoundation

#include "Asymp.h"
#include "SineWave.h"
#include "RtWvOut.h"

using namespace stk;

// WARNING: no error checking here!

int main(int argc, char **argv)
{

  //Usage statement
  if ( argc != 2 || atof(argv[1]) == 0.0 ) {

    std::cout<<"\nWARNING: usage: ./a.out note_frequency\n";
    std::cout<<"Where note_frequency is in Hz. \n\n";
    std::cout<<"Try ./a.out 440\n\n";
    exit(0);
  }


  //Variable Declarations
  int note_duration = 0.5 * 44100;
  double f_c = atof(argv[1]);
  double f_m = f_c * 2.0 / 3.0;
  int IMAX = 4;
  int IMIN = 2;

  // Set the global sample rate before creating class instances.
  Stk::setSampleRate( 44100.0 );

  // Create envelopes I decided to model the envelope F1
  // as two seperate envelopes that are represented by env1 and env3, env2 corresponds to F2
  Asymp env1;
  Asymp env2;
  Asymp env3;

  // Create looping wavetables with sine waveforms.
  SineWave carrier;
  SineWave tits;
  SineWave modulator;

  // Create a one-channel realtime output object.
  RtWvOut output;
  output.start();

  // Set our FM parameters.
  modulator.setFrequency(f_m);

  //envelope 1 is the first part of the F1 envelope and slopes up exponentially over a perdiod of 0.1 seconds
  env1.setTime(0.1);

  //envelope 2 is the first part of the F2 envelope and slopes down exponentially over a period of 0.5 seconds
  env2.setTime(0.5);

  //envelope 3 is the first part of the F1 envelope and slopes down exponentially over a perdiod of 0.1 seconds
  env3.setTime(0.1);

  env1.keyOn();
  env2.keyOn();
  env3.keyOn();

  //I couldnt figure out a way to get either of the decaying envelopes to decay. I had it working fine, then
  //they just stopped working. So frustrating. 
  // To remedy this I just used positively exponential envelopes and subtracted their values from one

  // Start the runtime loop.
  long counter = 0;
  while ( counter <= note_duration ) {

    //This statement does the whole 'right side' of the diagram
    //Here, since I couldnt get env2 to decay, I had to make it decay by subtracting it from 1.
    carrier.setFrequency( ((((1-env2.lastOut()) * (f_m * (IMAX - IMIN))) + (IMIN*f_m)) * modulator.tick()) + f_c);

    ////This if-statement multiplies the above signal by the first part of envelope 1 over the correct time period
    if( counter < 4410 ) {
      output.tick( env1.lastOut() * carrier.tick() );
      env1.tick();
    }

    //This if-statement multiplies the above signal by the 1 over the correct time period
    if( counter >= 4410 && counter < 17640) {
      output.tick( carrier.tick() );    
    }

    //This if-statement multiplies the above signal by the third part of envelope 1 over the correct time period
    //Here, since I couldnt get env3 to decay, I had to make it decay by subtracting it from 1.
    if( counter >= 17640 ) {
      output.tick( (1 - env3.lastOut()) * carrier.tick() );
      env3.tick();
    }

    env2.tick();

    //Turn envelopes off
    if ( counter++ == note_duration ) {
      env1.keyOff();
      env2.keyOff();
      env3.keyOff();
    }
  }

  return 0;
}