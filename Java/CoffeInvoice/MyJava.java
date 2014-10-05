/**************************************
* Name: Dallas Opelt
*
* Purpose: To be used to display an invoice
*	         for a customers order.
*
* Date: 03/24/2012
*
* Comments: Demonstrates having a class used
*           by a separate GUI class.
*
**************************************/

import java.util.Calendar;

public class MyJava
{
   /* Class Constants */

   // Default Values
   
   private static String DEFAULT_NAME = new String( "No Name Given" );
   private static int DEFAULT_BAGS_ORDERED = 0;
   private static Calendar DEFAULT_DATE = Calendar.getInstance( );
   private static String DEFAULT_ADDRESS = new String( "007 Default Lane" );
   
   // Box Amounts
   
   public static int LARGE_BOX = 20;
   public static int MEDIUM_BOX = 10;
   public static int SMALL_BOX = 5;

   // Box Costs
   
   public static double LARGE_BOX_COST = 1.80;
   public static double MEDIUM_BOX_COST = 1.00;
   public static double SMALL_BOX_COST = 0.60;

   // Cost per Coffe bag
   
   public static double COFFEE_BAG_COST = 5.50;

   // expected time of delivery
   
   public static final int EXPECTED_TIME = 14;

   /* Class Variables */

   // Name of customer
   
   private String customerName = "No Name";

   // Number of bags and boxes
   
   private int bagsOrdered;
   private int numLargeBoxes;
   private int numMediumBoxes;
   private int numSmallBoxes;

   // Calendars for date ordered and expected
   
   private Calendar dateOrdered;
   private Calendar dateExpected;

   // Addresses
   
   private String shippingAddress;
   private String address;

   
   /* Constructors */

   public MyJava( )
   {
      customerName = DEFAULT_NAME;
      bagsOrdered = DEFAULT_BAGS_ORDERED;
      dateOrdered = DEFAULT_DATE;
      dateExpected = DEFAULT_DATE;
      shippingAddress = DEFAULT_ADDRESS;
      address = DEFAULT_ADDRESS;
      
      numLargeBoxes = DEFAULT_BAGS_ORDERED;
      numMediumBoxes = DEFAULT_BAGS_ORDERED;
      numSmallBoxes = DEFAULT_BAGS_ORDERED;
   }

   
   /* Mutator Methods */
   
   public void setName( String newName )
   {
       customerName = newName;
   }
   
   public void setBagsOrdered( int amtBagsOrdered )
   {
       bagsOrdered = amtBagsOrdered;
   }
   
   public void setDates( )
   {
       dateOrdered = Calendar.getInstance( );
       dateExpected.set( dateOrdered.get( Calendar.YEAR ), 
                         dateOrdered.get( Calendar.MONTH ), 
                         dateOrdered.get( Calendar.DAY_OF_MONTH ) );
       calculateExpectedDate( );
   }
   
   public void setShippingAddress( String streetAddress )
   {
       shippingAddress = streetAddress;
   }
   
   public void setAddress( String newAddress )
   {
       address = newAddress;
   }
   
   
   /* Accessor Methods */

   public String getCustomerName( )
   {
      return customerName;
   }

   public int getBagsOrdered( )
   {
      return bagsOrdered;
   }

   public int getNumLargeBoxes( )
   {
      return numLargeBoxes;
   }

   public int getNumMediumBoxes( )
   {
      return numMediumBoxes;
   }

   public int getNumSmallBoxes( )
   {
      return numSmallBoxes;
   }
   
   public Calendar getDateOrdered( )
   {
       return dateOrdered;
   }
   
   public Calendar getDateExpected( )
   {
      return dateExpected;
   }
   
      // Get the current date
   public String getDate( Calendar date )
   {
      String month;
      String stringDate;

      month = calculateMonth( date );
      
      stringDate = month + " " + 
                   date.get( Calendar.DATE ) + ", " + 
                   date.get( Calendar.YEAR );

      return stringDate;
   }

   public String getShippingAddress( )
   {
      return shippingAddress;
   }

   public String getAddress( )
   {
      return address;
   }

   public double returnSubtotal( )
   {
      return bagsOrdered * COFFEE_BAG_COST;
   }

   public double totalLargeCost( )
   {
      return getNumLargeBoxes( ) * LARGE_BOX_COST;
   }

   public double totalMediumCost( )
   {
      return getNumMediumBoxes( ) * MEDIUM_BOX_COST;
   }

   public double totalSmallCost( )
   {
      return getNumSmallBoxes( ) * SMALL_BOX_COST;
   }

   public double totalBoxCost( )
   {
      return numLargeBoxes * LARGE_BOX_COST
             + numMediumBoxes * MEDIUM_BOX_COST
             + numSmallBoxes * SMALL_BOX_COST;
   }

   public double returnTotal( )
   {
      return returnSubtotal( ) + totalBoxCost( );
   }

   /* Calculations */

      // Finds the number of boxes need to fulfill order
   
   public void calculateNumBoxes( )
   {
      int numBagsLeft = bagsOrdered;

      while( numBagsLeft > 0 )
      {
         if( numBagsLeft >= LARGE_BOX )
         {
            numLargeBoxes++;
            numBagsLeft -= LARGE_BOX;
         }

         else if( numBagsLeft > SMALL_BOX )
         {
            numMediumBoxes++;
            numBagsLeft -= MEDIUM_BOX;
         }

         else
         {
            numSmallBoxes++;
            numBagsLeft -= SMALL_BOX;
         }
      }
   }
   
   
   /* Helper Methods */
   
      // Returns the month as a String
   private String calculateMonth( Calendar date )
   {
      String month;
      
      switch( date.get( Calendar.MONTH ) )
      {
         case 0: month = "January";
                 break;
         case 1: month = "February";
                 break;
         case 2: month = "March";
                 break;
         case 3: month = "April";
                 break;
         case 4: month = "May";
                 break;
         case 5: month = "June";
                 break;
         case 6: month = "July";
                 break;
         case 7: month = "August";
                 break;
         case 8: month = "September";
                 break;
         case 9: month = "October";
                 break;
         case 10: month = "November";
                  break;
         default: month = "December";
                  break;
      }
       
      return month;
   }
   
      // Calculates the expected date of arrival
   
   public void calculateExpectedDate( )
   {
       int year = dateExpected.get( Calendar.YEAR );
       
       int month = dateExpected.get( Calendar.MONTH );
       
       int currentDate = dateExpected.get( Calendar.DAY_OF_MONTH );
       
       int expectedDate = currentDate + EXPECTED_TIME;
       
       dateExpected.set( year, month, expectedDate );
   }
}