/*********************************************************************
*
*  File: ProductionWorker.java
*
*  Purpose: Define the ProductionWorker subclass for workers in a company
* 
*  Author: DallasO
*
*  Comments:
*     For CPS 245 Spring 2012 Lab 12
*     Using inheritance & polymorphism
*
*********************************************************************/

import employee.Employee;
import java.text.DecimalFormat;

public class ProductionWorker extends Employee
{
   /***************************************/
   //        Class Constants
   /***************************************/

   private static final double NIGHT_SHIFT_BONUS = 1.00;
   private static final double MIN_WAGE = 7.25;
   
   private static final int DEFAULT_SHIFT = 1;
   private static final int DEFAULT_HOURS_WORKED = 0;
   
   private static final int DAY_SHIFT = 1;
   private static final int NIGHT_SHIFT = 2;
   private static final int UNDERTIME_HOURS = 40;

   /***************************************/
   //        Instance Variables
   /***************************************/
   
   private int shift;
   private int hoursWorked;
   private double hourlyPayRate;

   /***************************************/
   //        Constructors
   /***************************************/
   
   public ProductionWorker( )
   {
       super( new String( "SocSecNum" ),
              new String( "Default ProductionWorker" ) );
       setShift( DEFAULT_SHIFT );
       setHoursWorked( DEFAULT_HOURS_WORKED );
       setHourlyPayRate( MIN_WAGE );
   }
   
   public ProductionWorker( String socSecNum, String name )
   {
       super( socSecNum, name );
       setShift( DEFAULT_SHIFT );
       setHoursWorked( DEFAULT_HOURS_WORKED );
       setHourlyPayRate( MIN_WAGE );
   }
   
   public ProductionWorker( String socSecNum, String name,
                            int newShift, double newHourlyPayRate )
   {
       super( socSecNum, name );
       setShift( newShift );
       setHoursWorked( DEFAULT_HOURS_WORKED );
       setHourlyPayRate( newHourlyPayRate );
   }

   /***************************************/
   //        Accessor Methods
   /***************************************/
   
   public int getShift( )
   {
       return shift;
   }
   
   public int getHoursWorked( )
   {
       return hoursWorked;
   }
   
   public double getHourlyPayRate( )
   {
       return hourlyPayRate;
   }

   /***************************************/
   //        Mutator Methods
   /***************************************/
   
   public void setShift( int newShift )
   {
       if( newShift == DAY_SHIFT || newShift == NIGHT_SHIFT )
       {
           shift = newShift;
       }
       else
           shift = DEFAULT_SHIFT;
   }
   
   public void setHoursWorked( int numHoursWorked )
   {
       if( numHoursWorked >= 0 )
       {
           hoursWorked = numHoursWorked;
       }
       else
           hoursWorked = DEFAULT_HOURS_WORKED;
   }
   
   public void  setHourlyPayRate( double newPayRate )
   {
       if( newPayRate >= MIN_WAGE )
       {
           hourlyPayRate = newPayRate;
       }
       else 
           hourlyPayRate = MIN_WAGE;
   }
   
   /***************************************/
   //        Helper Methods
   /***************************************/

     /************************************
      * This method is to calculate the  *
      * weekly pay check of the empolyee,*
      * and also adds overtime.          *
      ***********************************/
   
   public double calculateWeeklyPayCheck( )
   {
       // Local Variables
       
       double calcPayRate;
       double overTimePayRate;
       int overtimeHours = DEFAULT_HOURS_WORKED;
       DecimalFormat df = new DecimalFormat( "#.##" );
       String paycheck;
       
       // Determining Night Bonus
       
       if( shift == NIGHT_SHIFT )
           calcPayRate = getHourlyPayRate( ) + NIGHT_SHIFT_BONUS;
       else
           calcPayRate = getHourlyPayRate( );
       
       overTimePayRate = calcPayRate * 0.5;
       
       // Calculating overtime hours
       if( getHoursWorked( ) > UNDERTIME_HOURS )
           overtimeHours = getHoursWorked( ) - UNDERTIME_HOURS;
      
       paycheck =  df.format( calcPayRate * getHoursWorked( ) + 
              ( overTimePayRate * overtimeHours ) );
       
       return Double.parseDouble( paycheck );
   }
   
   public String toString()
   {
       return super.toString( ) + 
               "\n  Hourly pay rate: $" + getHourlyPayRate( ) +
               "\n  Shift: " + getShift( ) +
               "\n  Hours worked: " + getHoursWorked( ) + " hour(s)";
   }
   
   public static void main( String args [ ] )
   {
       ProductionWorker test[ ] = new ProductionWorker[ 3 ];
       
       for( int i = 0; i < test.length; i++ )
       {
           System.out.println( "\n -- Testing test: " + ( i + 1 ) + " --");
           test[ i ] = new ProductionWorker( "123456789", 
                                             "test number " + ( i + 1 ),
                                             i, MIN_WAGE + i );
           test[ i ].setHoursWorked( UNDERTIME_HOURS + i );
           System.out.println( test[ i ].toString( ) );
           System.out.println( "Test" + ( i + 1 ) + " weekly pay check: $" +
                               test[ i ].calculateWeeklyPayCheck() );
       }
   }
}