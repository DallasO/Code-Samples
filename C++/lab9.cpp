//---------------------------------------------------------------------
// DO_1: Enter your name and section here
// Name:    Dallas Opelt
//
// Course:  CS 143, Section 01, Fall 2011
//
// Purpose: This program prints a sales receipt based on the input 
//          sales information.
//
// Input:   The program will read from keyboard multiple sales record.
//          Each record includes the product ID, unit price and 
//          unit amount. The user will finish inputting with "X".
//
// Output:  The program will print out a receipt including every sales
//          record, the total sale, tax and total charges.
//---------------------------------------------------------------------

#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

const int   MAX_RECORDS = 10;
const float TAX_RATE = 0.055;
const float TAX_RATE_PER = 5.5;

//---------------------------------------------------------------------
// This class represents a sales record, including product ID, 
// unit price and unit amount. 
// --------------------------------------------------------------------
class Sale
{
private:
   string productID;
   float  unitPrice;
   float  unitCount;

public:
//---------------------------------------------------------------------
// Parameterized construcor: create a Sale object given the product id, 
// unit price and unit amount.
// Parameters: in, in, in
//---------------------------------------------------------------------
   Sale ( string id, float price, int count )
   {
      // DO_2: finish the constructor by assigning initial values to 
	  // productID, unitPrice and unitCount;
      productID = id;
      unitPrice = price;
      unitCount = count;
   }

//---------------------------------------------------------------------
// DO_3: finish method SaleAmount()
// Calculate and return the total sale amount of the sale object. 
//---------------------------------------------------------------------      
   float SaleAmount()
   {
       return unitCount * unitPrice;
   }

//---------------------------------------------------------------------
// Print the sale object on one line.
//---------------------------------------------------------------------   
   void printSale()
   {
      cout << fixed << showpoint << setprecision(2);
	  cout << setw(15) << productID << setw(7) << unitCount << " X " 
           << setw(10) << unitPrice << endl; 
   }
};

//---------------------------------------------------------------------
// This class represents a receipt, including all sale records.
// The printed receipt will also include the sale total, tax and 
// after tax charge. 
// --------------------------------------------------------------------
class Receipt
{
private:
   Sale  saleRecord[MAX_RECORDS];
   int   numSale;
   float total;

//---------------------------------------------------------------------
// Calculate the total sale for all sale records in this receipt.
//---------------------------------------------------------------------
   float TotalSale()
   {
      total = 0;
	  // DO_4: use a for loop to calculate the total cost of all 
	  // sale objects stored in the array saleReocrd
      for( int i = 0; i < numSale; i++ )
         total += saleRecord[i].SaleAmount();
	  
	  
      return total;
   }
   
public:
//---------------------------------------------------------------------
// Construcor: create a Receipt object and initialize the number of 
// sale records to 0.
//---------------------------------------------------------------------
   Receipt()
   {
      numSale = 0;
   }

//---------------------------------------------------------------------
// Read from keyboard multiple sale records, ending with "X".
//---------------------------------------------------------------------   
   void Read()
   {
      string id;
      float  price;
      float  amount;
            
      cout << "Please enter your product id, unit price and amount of unit "
           << endl << "[id price amount] and enter X to finish:" << endl;
      // DO_5: use a while loop to read in sales objects to saleRecord array
      cin >> id;
      while( id != "X" && numSale < MAX_RECORDS)
      {
         cin >> price >> amount;
         saleRecord[numSale] = Sale( id, price, amount );
         
         numSale++;
	  cin >> id;
      }
   }

//---------------------------------------------------------------------
// Print the receipt with every sale record, sale total, tax and 
// total charge.
//---------------------------------------------------------------------      
   void PrintReceipt()
   {
      cout << endl << "==============Receipt==============" << endl;
	  // DO_6: print every single sale record
      for( int i = 0; i < numSale; i++ )
         saleRecord[i].printSale();

	  
	  
      cout << setprecision(2) << fixed << showpoint
	       << endl << "sale total:" << setw(24) << TotalSale() << endl
           << "tax (" << TAX_RATE_PER << "%):"  << setw(23) 
		   << TotalSale() * TAX_RATE << endl    << "total charge:" 
		   << setw(22) << TotalSale() * ( 1 + TAX_RATE ) << endl;      
   }
   
};

int main()
{
   // DO_7: Declare a Receipt object
   Receipt purchaseList;
   // DO_8: Read sales objects and store them in the Receipt object
   purchaseList.Read();
   // DO_9: Print the receipt
   purchaseList.PrintReceipt();
   
   return 0;
}




