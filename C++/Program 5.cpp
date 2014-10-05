//---------------------------------------------------------------------
//
// Name:    Dallas Opelt
//
// Course:  CS 143, Section 01, Fall 2011
//
// Purpose: This program is to be used to process packages that are 
//          sent to different cities. 
//
// Input:   Input will be a string for the city name, the amount of
//          packages, and the total weight of the packages cities to
//          add, updates to existing cities, and which cities to 
//          delete from the list.
//
// Output:  Output will consist of each city with packages being
//          delivered to and the number of packages and total weight
//          of the packages to each individual city.
//---------------------------------------------------------------------
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;


const int MAX_CITIES = 5; // Stores max cities.
const int NOT_FOUND = -1; // Stores the "not found" variable.


// This class holds the information to a Destination.
class Destination
{
private:
   string city; // the name of the city where packages are to be sent
   int package_count;  // count of packages
   float total_weight; // total weight of all packages
   
public:
// This constructor initializes the city to name and 
// both the package count and total weight to 0.
// params: in
Destination( string name )
{
   city = name;
   package_count = 0;
   total_weight = 0;
}

// Adds numPackages and packageWeight to the package count and total
// weight, respectively.
// params: in, in
void RecordShipment( int numPackages, float packageWeight )
{
   package_count += numPackages;
   total_weight += packageWeight;
}

// Returns true if the object's city is the same as name; 
// false otherwise
// params: in
bool DestinationHasName( string name )
{
   return ( city == name );
}
// Zeroes the package count and total weight.
void ClearShipment( )
{
   package_count = 0;
   total_weight = 0.0;
}

// returns average weight of the packages in a shipment, 
// or 0.0 if there are no packages
float AverageWeight( )
{
   if( package_count == 0 )
      return float( package_count );
   else
      return total_weight / package_count;
}
};


// This class holds a list of Densination ojects.
class DestinationList
{
private:
   int num;                       // number of objects in the list
   Destination list[MAX_CITIES];  // array of destinations

// Searches city names to make sure there isn't another with same name.
int SearchCity( string name )
{ 
   int position = NOT_FOUND; // Store the position of the city.
   for( int i = 0; i < MAX_CITIES; i++ )
   {
      if( list[i].DestinationHasName( name ) )
         position = i;
   }
   return position;
}

public:
DestinationList ()
{
   num = 0; // Stores the total number of cities
}

// Adds a new city as a destination object at the end of the list of
// destinations.
void AddCity()
{
   string cityToAdd(); // Stores the city to add to the list.
   cin >> cityToAdd;
   
   if( num == MAX_CITIES )
      cout << cityToAdd << " not added. List is full." << endl;
   else
   {
      if( SearchCity( cityToAdd ) == NOT_FOUND )
      {
         Destination loc( cityToAdd ); // Object to store city as a
         list[num] = loc;              // Destination.
         cout << cityToAdd << " added to the list." << endl;
         num++;
      }
      else
         cout << cityToAdd << " is already in the list." << endl;
   }
}
      
// Displays the average package weight of a city and displays an 
// error if there is no such city.
void OutputCity()
{
   string cityToOutput; // Stores the city to output.
   cin >> cityToOutput;
   int position = SearchCity( cityToOutput ); // Sets the position of
   if( position == NOT_FOUND )                // the city to output.
      cout << "Cannot output. " << cityToOutput 
           << " is not in the list." << endl;
   else
      cout << "Average weight of all packages to " << cityToOutput 
           << ": " << list[position].AverageWeight() << endl;
}

// Updates a destinations package count and the total package weight.
// params: in, in
void UpdateCity()
{
   string cityToUpdate; // Stores the city to be updated.
   cin >> cityToUpdate;
   int position = SearchCity( cityToUpdate ); // Sets the position of
                                              // the city to be 
                                              // updated.
   int packageCount; // Stores the number of packages.
   float totalWeight; // Stores the total weight.
   
   if( position > NOT_FOUND )
   {
      cin >> packageCount >> totalWeight;
      list[position].RecordShipment( packageCount, totalWeight );
      cout << "Destination " << cityToUpdate << " updated with " 
           << packageCount << " packages weighing " << totalWeight 
           << " lbs." << endl;
   }
   else
      cout << "Cannot update. " << cityToUpdate 
           << " is not in the list." << endl;
}

// Clears the number of and weight of the packagesg going to a
// destination, but leaves the city name as is. Outputs error if
// there is no destination specified.
void ClearCity()
{
   string cityToClear; // Stores the city to be cleared.
   cin >> cityToClear;
   
   int position = SearchCity( cityToClear );
   if( position == NOT_FOUND )
      cout << "Cannot clear. " << cityToClear 
           << " is not in the list." << endl;
   else
      list[position].ClearShipment();
}
// Terminates the program.
void Quit()
{
   cout << "Normal termination.";
} 
};

int main()
{
   DestinationList delivery; // To make a Destination list object.
   string command; // Stores which command is being called.
   cout << fixed << showpoint << setprecision(2);
   
   cin >> command;
   
   while( command != "Quit" )
   {
       if( command == "Add" )
          delivery.AddCity();
       else if( command == "Update"  )
          delivery.UpdateCity();
       else if( command == "Output" )
          delivery.OutputCity();
       else if( command == "Clear" )
          delivery.ClearCity();
       
       cin >> command;
   }
   
   delivery.Quit();

   return 0;
}
    
