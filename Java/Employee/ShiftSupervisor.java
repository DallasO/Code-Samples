/*********************************************************************
*
*  File: ShiftSupervisor.java
*
*  Purpose: Define the ShiftSupervisor subclass for workers in a company
* 
* Author: DallasO
*
*  Comments:
*     For CPS 245 Spring 2012 Lab 13
*     Using inheritance & polymorphism
*
*********************************************************************/

import java.text.*;
import employee.Employee;

public class ShiftSupervisor extends Employee
{
    /** Class Constants **/
    
    public static final double DEFAULT_SALARY = 0.00;
    public static final double DEFAULT_BONUS = 0.00;
    
    private static final DecimalFormat DECIMAL_FORMAT = 
                                       new DecimalFormat( "##.##" );
    
    /** Class Variables **/
    
    private double annualSalary;
    private double annualBonus;
    
    /** Constructors **/
    
    public ShiftSupervisor( )
    {
        super( new String( "SocSecNum" ), 
               new String( "Default Shift Supervisor" ) );
        
        annualSalary = DEFAULT_SALARY;
        
        annualBonus = DEFAULT_BONUS;
    }
    
    public ShiftSupervisor( String socSecNum, String name, double salary )
    {
        super( socSecNum, name );
        
        setAnnualSalary( salary );
        
        annualBonus = DEFAULT_BONUS;
    }
    
    public ShiftSupervisor( String socSecNum, String name, 
                            double salary, double bonus )
    {
        super( socSecNum, name );
        
        setAnnualSalary( salary );
        
        setAnnualBonus( bonus );
    }
    
    /** Mutator Methods **/
    
    public void setAnnualSalary( double newSalary )
    {
        if( newSalary > DEFAULT_SALARY )
            annualSalary = Double.parseDouble( 
                               DECIMAL_FORMAT.format( newSalary ) );
    }
    
    public void setAnnualBonus( double newBonus )
    {
        if( newBonus > DEFAULT_BONUS )
            annualBonus = Double.parseDouble( 
                               DECIMAL_FORMAT.format( newBonus ) );
    }
    
    /** Accessor Methods **/
    
    public double getAnnualSalary( )
    {
        return annualSalary;
    }
    
    public double getAnnualBonus( )
    {
        return annualBonus;
    }
    
    public String toString( )
    {
        return super.toString( ) + "\n   --Shift Supervisor--" +
               "\n  Annual Salary: $" + getAnnualSalary( ) +
               "\n   -Weekly Check: $" + calculateWeeklyPay( ) +
               "\n  Annual Production Bonus: $" + getAnnualBonus( );
    }
    
    public double calculateWeeklyPay( )
    {
        int weeksPerYear;
        double weeklyCheck;
        
        weeksPerYear = 52;
        
        weeklyCheck = ( getAnnualSalary( ) / weeksPerYear );
        
        return  Double.parseDouble( 
                               DECIMAL_FORMAT.format( weeklyCheck ) );
    }
    
    /** Main Method **/
    
    public static void main( String args[ ] )
    {
        System.out.println( "  -- Testing ShiftSupervisor --" );
        
        // Testing test 1
        
        System.out.println( "\n   Test 1 " );
        ShiftSupervisor test1 = new ShiftSupervisor( );
        System.out.println( test1.toString( ) );
        System.out.println( "\n Changing salary to $100,000.00:" );
        test1.setAnnualSalary( 100000.00 );
        System.out.println( test1.toString( ) );
        
        // Testing test 2
        
        System.out.println( "\n   Test 2" );
        ShiftSupervisor test2 = new ShiftSupervisor( "8675309",
                                                     "Alex",
                                                     65000.00 );
        System.out.println( test2.toString( ) );
        System.out.println( "\nChanging bonus to $25,000.00" );
        test2.setAnnualBonus( 25000.00 );
        System.out.println( test2.toString( ) );
        
        // Testing tetst 3
        
        System.out.println( "\n   Test 3" );
        ShiftSupervisor test3 = new ShiftSupervisor( "555443771",
                                                     "Zach",
                                                     42000.00,
                                                     500.00 );
        System.out.println( test3.toString( ) );
        System.out.println( "\nTrying to change to invalid values!" );
        test3.setAnnualSalary( -25.00 );
        test3.setAnnualBonus( -100.00 );
        System.out.println( test3.toString( ) );
    }
}
