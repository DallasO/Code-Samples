/*********************************************************************
*
*  File: TeamLeader.java
*
*  Purpose: Define the TeamLeader subclass for workers in a company
* 
*  Author: DallasO
*
*  Comments:
*     For CPS 245 Spring 2012 Lab 13
*     Using inheritance & polymorphism
*
*********************************************************************/

import java.text.DecimalFormat;

public class TeamLeader extends ProductionWorker
{
    /** Class Constants **/
    
    public static final double BONUS_PERCENT = 0.05;
    public static final int DEFAULT_NUM_OF_TRAINING_HOURS = 0;
    
    /** Class Variables **/
    
    private int numOfTrainingHours;
    
    /** Constructors **/
    
    public TeamLeader( )
    {
        super( "SecSecNum", "Default Team Leader" );
        
        numOfTrainingHours = DEFAULT_NUM_OF_TRAINING_HOURS;
    }
    
    public TeamLeader( String SocSecNum, String name  )
    {
        super( SocSecNum, name );
        
        numOfTrainingHours = DEFAULT_NUM_OF_TRAINING_HOURS;
    }
    
    public TeamLeader( String SocSecNum, String name, int trainingHours )
    {
        super( SocSecNum, name );
        
        setNumOfTrainingHours( trainingHours );
    }
    
    /** Mutator Methods **/
    
    public void setNumOfTrainingHours( int trainingHours )
    {
        if( trainingHours > DEFAULT_NUM_OF_TRAINING_HOURS )
            numOfTrainingHours = trainingHours;
    }
    
    /** Accessor Methods **/
    
    public int getNumOfTrainingHours( )
    {
        return numOfTrainingHours;
    }
    
    public double calculateWeeklyPay( )
    {
        DecimalFormat df = new DecimalFormat( "##.##" );
        double payCheck = super.calculateWeeklyPayCheck( );
        
        return Double.parseDouble( df.format( payCheck * 
                                              BONUS_PERCENT + 
                                              payCheck ) );
    }
    
    public String toString( )
    {
        return super.toString( ) + "\n  Number of Traning Hours: " +
               getNumOfTrainingHours( );
    }
    
    /** Main Method **/
    
    public static void main( String args[ ] )
    {
        System.out.println( "  -- Testing TeamLeader --" );
        
        // Testing test 1
        
        System.out.println( "\n   Test 1 " );
        TeamLeader test1 = new TeamLeader( );
        test1.setHoursWorked( 10 );
        System.out.println( test1.toString( ) );
        System.out.println( "\n Changing training hours to 15" );
        test1.setNumOfTrainingHours( 15 );
        System.out.println( test1.toString( ) );
        
        // Testing test 2
        
        System.out.println( "\n   Test 2" );
        TeamLeader test2 = new TeamLeader( "8675309",
                                                     "Alex" );
        test2.setHoursWorked( 10 );
        System.out.println( test2.toString( ) );
        System.out.println( "\nChanging training hours to 30" );
        test2.setNumOfTrainingHours( 30 );
        System.out.println( test2.toString( ) );
        
        // Testing test 3
        
        System.out.println( "\n   Test 3" );
        TeamLeader test3 = new TeamLeader( "555443771", "Zach", 0);
        test3.setHoursWorked( 10 );
        System.out.println( test3.toString( ) );
        System.out.println( "\nTrying to change to invalid values!" );
        test3.setNumOfTrainingHours( -25 );
        System.out.println( test3.toString( ) );
        
        // Displaying the paychecks for the three tests
        
        System.out.println( "\n\t-Paychecks for each test: " + 
                            "\ttest1: $" + test1.calculateWeeklyPay( ) +
                            "\ttest2: $" + test2.calculateWeeklyPay( ) +
                            "\ttest3: $" + test3.calculateWeeklyPay( ) );
    }
}
