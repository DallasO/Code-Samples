//------------------------------------------------------------------------
// Names:        Dallas Opelt
//
// Course:      CS143, Section 01,  Used Fall 2009 with
//              structs, revised Fall 2011 with classes
//
// Description: This program reads in person objects; 
//              sorts them in ascending order by birthday via
//              a Selection Sort Method; prints out
//              sorted array.
//
// Input:       This program reads in person info into 
//              an array of objects where reading is terminated by 
//              end of file.
//
// Output:      This program outputs the unsorted & sorted list 
//              of people in ascending order by birthday. 
//             
//------------------------------------------------------------------------

#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

const int MAXPEOPLE = 10;

// Class for a date (month, day and year) such as a birthday
class Date
{
private:
   int month;
   int day;
   int year;
public:
   
   // Construct a Date object
   // params: none
   Date( )
   {
      month = 0;
      day = 0;
      year = 0;
   }
   
   // A method to read in data to a Date object:
   // a month, a slash, a day, a slash , and a year
   // Params: none
   void ReadDate( )
   {
      char slash;
      
      cin >> month >> slash
	   >> day   >> slash
	   >> year;
    }

   // Method to write out a date as month/day/year
   // Params: none
   void WriteDate( ) const
   {
       cout << month << '/'
            << day   << '/'
            << year;
   }
   
   // Tests to see if two dates are equal;
   // for the dates to be equal the months, days and years of each date 
   // must be correspondingly equal.
   // params: in
   bool Equals ( const Date & d1 ) const
   {
      //DO_07: Write C++ code to return true if the two dates,
      //       d1 and d2 are equal, false otherwise.
     return ( day == d1.day && month == d1.month 
            && year == d1.year );
     
     
   }
   
   // Compares two dates such that it returns 0 if the 2 dates are equal;
   // returns -1 if the first date is less than the second date;
   // returns  1 if the first date is greater than the second date;
   // params: in
   int CompareDate ( const Date  & d1) const
   {
      if ( Equals(d1) )
         return 0;
      if ( year < d1.year )
         return -1;
      if ( year > d1.year )
         return 1;
      if ( month < d1.month )
         return -1;
      if ( month > d1.month )
         return 1;
      if ( day < d1.day )
         return -1;
      return 1;
}
};


// Class that contains a first name, middle initial and last name
class FullName
{
private:
   string firstName;
   string lastName;
   char middleInitial;
public:
   
   // Construct a FullName object which
   // includes a first name, an middle initial, and
   // a last name
   FullName( )
   {
      firstName = " ";
      middleInitial = ' ';
      lastName = " ";
   }
   
   // Method to read in a name from cin
   // params: none
   void ReadFullName()
   {
      cin >> firstName  
          >> middleInitial
          >> lastName;
   }
   
   // Method to write the full name information which
   // includes the first name, middle initial, and last 
   // name.
   // params: none
   void WriteFullName( ) const
   {
      cout << setw(20) << lastName
           << setw(3)  << middleInitial
           << setw(20) << firstName;
   }
};

// Class for a person which contains a date object for birthday and a 
// FullName object for a persons name.

class Person
{
private:
      
    Date     birthday; 
    FullName fullname;
    
public:
   
   // Read in a birthday and a full name
   // Params: none;
   void ReadPerson( )
   {
      birthday.ReadDate( );
      fullname.ReadFullName( );
   }
    
   // Write the person information which includes
   // the person's full name and birthday.
   // params: none
   void WritePerson( ) const
   {
      fullname.WriteFullName( );
      birthday.WriteDate( );
   }
   
   // Compares two birthdays returning an int. This method calls CompareDate.  
   // params: in
   int BirthdayCompare( const Person & person1 ) const
   {
   // DO_08:  complete this method
      return birthday.CompareDate( person1.birthday );

   }
};

// Class which contains an array of Person objects and how many persons
// are in the array.
class People
{
private:
   Person people[MAXPEOPLE];
   int peopleCount;
      
   // Exchange/swap the info in two objects
   // params  in/out, in/out
   void SwapPersons ( Person & person1, Person & person2  )
   {
      // DO_03: Write code to swap values of person1 and person2.
      Person temp = person1;
      person1 = person2;
      person2 = temp;      
      
   }
      
public:
   
   // Construct an People Object for a list of persons
   // Params: none
   People( )
   {
       peopleCount = 0;
   }
   // Method to load up array with birthdays and people
   // Params: none
   void LoadList()
   {
       Person newperson;
       newperson.ReadPerson();
       while (!cin.eof( ) && peopleCount < MAXPEOPLE )
       {
           people[peopleCount] = newperson;
           peopleCount++;
           newperson.ReadPerson();
       }
   }

   // Write information for a list of persons
   // params: none
   void WritePeople( ) const
   {
      cout.setf( ios::left );
      cout << setw(20) << "Last Name"
           << setw(3)  << "MI"
           << setw(20) << "First Name"
           << "Birthday"
           << endl;
      for (int i = 0; i < peopleCount; i++)
      {
         people[i].WritePerson( );
         cout << endl;
      }
   }
     
   // Sorts the person list in ascending order by birthday.
   // params  none
   void SelectionSort( )
   {
       for (int pass = 0; pass < peopleCount - 1; pass++)
       {
          // DO_04: Set a minimum index variable to pass
          int minIndex = pass;
         
          for (int count = pass + 1; count < peopleCount; count++)
          {
             // DO_05: Write a complete if-test to compare the birthday of 
             //        the person at index, count, versus the person at
             //        index, minIndex; use the function birthdayCompare
             //        to do the comparison and if the value returned is
             //        -1, then change minIndex to count
             if( people[count].BirthdayCompare( people[minIndex] ) == -1 )
                minIndex = count;
             
          } 
       //DO_06: Call the swapPersons function to exchange the objects in
       //       the personList at indices, minIndex and pass.
       SwapPersons( people[minIndex], people[pass] );
       
       }
   }
};

int main()
{
   People personList;
   personList.LoadList();
   cout << endl << "Unsorted list of people follows." << endl;
   personList.WritePeople( );
   cout << endl << endl;
   personList.SelectionSort( );
   
   cout << "After sorting by birthday, list of people follows." << endl;
   personList.WritePeople( );
   return 0;
}

