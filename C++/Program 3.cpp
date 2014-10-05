//---------------------------------------------------------
// Name:    Dallas Opelt
//
// Course:  CS 143, Section 01, Fall 2011
//
// Purpose: The purpose of this program is to generate the
//          values of a series of numbers using different
//          base systems.
//
// Input:   The input will be an int for the base system
//          and a list of char's for the sequence to be used
//          in the calculations.
//
// Output:  Will include error messages for a wrong base or
//          a number entered that is outside the base's range.
//          And also the final output of the base entered
//          and the total of the numbers entered in the base
//          specified.
//---------------------------------------------------------
#include <iostream>
#include <cmath>
#include <iomanip>
using namespace std;

// Declaring of constants.
const int BASELOW = 2;         // Lower limit for the base.
const int BASEHIGH = 9;        // Higher limit for the base.
const char CHARCONVERT = 48;   // Constant to convert char's to int's.
const int IGNOREVARIABLE = 100;// Constant to be used for cin.ignore's.

// Function prototypes.
int readUntilValidBaseRead( );
int readNumbersReturningValue( int base );
int decimalValueOf( char chDigit );
bool isValid( char chDigit, int base );

int main( )
{
   int totalSum = 0; // Used to store the sum of all converted sequences
   int numberValue, base;//To store the number sequence and base entered.
   
   base = readUntilValidBaseRead( );   // Reading a valid base.
   while( !cin.eof( ) ) // Finding a valid number sequence and displaying
   {                    // errors or the converted sequence.
      cout << "For the given base " << base << ",";
      numberValue = readNumbersReturningValue( base );
      if( numberValue == -1)
      {
         cout << " the number is NOT valid!" << endl;
      }
      else
      {
         totalSum += numberValue;
         cout << " the decimal value of the input string is "
              << numberValue << "." << endl;
      }
      base = readUntilValidBaseRead( );
   }
   cout << endl << "The total sum of all valid values is " 
        << totalSum << "."; // Displaying the total of all converted
   return 0;                // valid sequences.
}

//---------------------------------------------------------------------
// This function reads bases until a valid base is read or eof occurs.
// If an invalid base is read, an error message is displayed and the 
// rest of the line is ignored and another attempt to read a base value
// will be attempted.
// -1 is returned if eof occurs otherwise a valid base value is 
// returned.
// params: none
//---------------------------------------------------------------------
int readUntilValidBaseRead( )
{
   int base; // To store the base to be tested and returned.
   cin >> base;
   while( !cin.eof() )
   {
      // Testing the base entered.
      if( base < BASELOW || base > BASEHIGH )
      {
         cin.ignore( IGNOREVARIABLE, '\n' );
         cout << "Invalid base given, "
              << "throwing away the rest of the line." << endl;
         cin >> base;
      }
      else
         return base; // Returning a valid base.
      
   }
   return -1; // Returned if end of file.
}
         
//---------------------------------------------------------------------
// This function reads in a sequence of characters that represent
// a number in the given base.  A valid sequence is given in a 
// "backwards" format such that the rightmost digit is given first,
// the second to the rightmost digit is next, etc. 
// This function returns the value of this sequence of characters if
// it is a valid sequence.  If it is not valid it returns -1. 
// params: in
//---------------------------------------------------------------------
int readNumbersReturningValue( int base )
{
   char chDigit; // To store the entered char to be converted.
   int stringTotal = 0; // To store the total converted sequence.
   int multiplier = 1; // The multiplier to use in the pow() function.
   cin >> chDigit;
   while( chDigit != '\n' )
   {
      if( isValid( chDigit, base ) )
      {
         stringTotal +=  decimalValueOf( chDigit ) * multiplier ;
         multiplier *= base;
      }
      else
         stringTotal = -1;
      cin.get( chDigit );
   }
   return stringTotal;
}

//---------------------------------------------------------------------
// This function returns the numeric value of the character digit that
// is stored in chDigit.
// params: in
//---------------------------------------------------------------------
int decimalValueOf( char chDigit )
{
   int intDigit = chDigit; // To store chDigit as an integer.
   intDigit -= CHARCONVERT;
   return intDigit;
}
   
//---------------------------------------------------------------------
// This function returns true if chDigit is a valid digit in the given
// base, it returns false otherwise.
// params: in, in
//---------------------------------------------------------------------
bool isValid( char chDigit, int base )
{ 
   int intDigit = chDigit; // To store chDigit as an integer.
   intDigit -= CHARCONVERT;
   if( intDigit < 0 || intDigit > base - 1 )
      return false; // Returned if invalid number in sequence.
   else
      return true; // Returned if valid number in sequence.
}
