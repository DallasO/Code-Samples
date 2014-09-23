/*********************************************************************
*
*  File: Lab13Driver.java
*
*  Purpose: Define the Lab13Driver application
* 
*  Author: DallasO
*
*  Comments:
*     For CPS 245 Spring 2012 Lab 13
*     Using inheritance & polymorphism
*
*********************************************************************/

import java.util.Scanner;
import java.text.DecimalFormat;
import employee.Employee;

public class Lab13Driver
{    
    /** Class Variables **/
    
    private Employee employeeList [ ];
    private int numOfEmployees;
    
    /** Constructors **/
    
    public Lab13Driver( )
    {
        employeeList = new Employee[ 8 ];
        for( int i = 0; i < employeeList.length; i++ )
            employeeList[ i ] = new Employee( "", "");
        numOfEmployees = 0;
    }
    
    /** Accessor Methods **/
    
    public Employee getEmployee( int index )
    {
        return employeeList[ index ];
    }
    
    public int getNumOfEmployees( )
    {
        return numOfEmployees;
    }
    
    public double calculatePay( Employee e)
    {
        return e.calculateWeeklyPay();
    }
    
    // Determines what type of employee user wants to hire
    
    private boolean calculateUserOption( String employeeToHire )
    {
        int currentIndex = getNumOfEmployees( );
        boolean isValidPosition = true;
        if( employeeToHire.equalsIgnoreCase( "employee" ) )
        {
            createEmployee( currentIndex );
        }
        else if( employeeToHire.equalsIgnoreCase( "productionworker" ) )
        {
            createProductionWorker( currentIndex );
        }
        else if( employeeToHire.equalsIgnoreCase( "shiftsupervisor" ) )
        {
            createShiftSupervisor( currentIndex );
        }
        else if( employeeToHire.equalsIgnoreCase( "teamleader" ) )
        {
            createTeamLeader( currentIndex );
        }
        else
            isValidPosition = false;
        return isValidPosition;
    }
    
    // checks if employee already exists
    
    public boolean alreadyExists( Employee temp )
    {
        boolean alreadyExists = false;
        for( int i = 0; i < employeeList.length; i++ )
        {
            if( employeeList[ i ].equals( temp ) )
                alreadyExists = true;
        }
        return alreadyExists;
    }
    
    /** Mutator Methods **/
   
    public void addAnEmployee( )
    {
        numOfEmployees += 1;
    }
    
    // Creates employee of type Employee
    
    public void createEmployee( int index )
    {
        Scanner keyboard = new Scanner( System.in );
        String socialSecurityNumber;
        String employeeName;
        Employee temp;
        
        System.out.print( "Enter new employee's Social " +
                            "Security Number: " );
        socialSecurityNumber = keyboard.next( );
        temp = new Employee( socialSecurityNumber, "" );
        if( alreadyExists( temp ) )
            System.out.println( "This employee already exists!" );
        else if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            System.out.print( "Enter new employee's name: " );
            employeeName = keyboard.next( );
            addAnEmployee( );
            employeeList[ index ] = new Employee( socialSecurityNumber,
                                                  employeeName );
        }
        else
        {
            System.out.println( "Invalid SSN!" );
        }
    }
    
    // Creates employee of type Productionworker
    
    public void createProductionWorker( int index )
    {
        Scanner keyboard = new Scanner( System.in );
        String socialSecurityNumber;
        String employeeName;
        int shift;
        double hourlyWage;
        Employee temp;
        
        System.out.print( "Enter new employee's Social " +
                            "Security Number: " );
        socialSecurityNumber = keyboard.next( );
        temp = new Employee( socialSecurityNumber, "" );
        if( alreadyExists( temp ) )
            System.out.println( "This employee already exists!" );
        else if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            System.out.print( "Enter new employee's name: " );
            employeeName = keyboard.next( );
            employeeName.trim( );
            System.out.print( "Will " + employeeName + " be working the " +
                              "day(1) or night(2) shift? " );
            shift = keyboard.nextInt( );
            System.out.print( "Enter wage rate: $" );
            hourlyWage = keyboard.nextDouble( );
            addAnEmployee( );
            employeeList[ index ] = 
                new ProductionWorker( socialSecurityNumber, employeeName,
                                      shift, hourlyWage );
        }
        else
        {
            System.out.println( "Invalid SSN!" );
        }
    }
    
    // Creates employee of type ShiftSupervisor
    
    public void createShiftSupervisor( int index )
    {
        Scanner keyboard = new Scanner( System.in );
        String socialSecurityNumber;
        String employeeName;
        double annualSalary;
        double annualBonus;
        Employee temp;
        
        System.out.print( "Enter new employee's Social " +
                            "Security Number: " );
        socialSecurityNumber = keyboard.next( );
        temp = new Employee( socialSecurityNumber, "" );
        if( alreadyExists( temp ) )
            System.out.println( "This employee already exists!" );
        else if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            System.out.print( "Enter new employee's name: " );
            employeeName = keyboard.next( );
            employeeName.trim( );
            System.out.print( "Enter annual salary: $" );
            annualSalary = keyboard.nextDouble( );
            System.out.print( "Enter annual Bonus: $" );
            annualBonus = keyboard.nextDouble( );
            addAnEmployee( );
            employeeList[ index ] = 
                new ShiftSupervisor( socialSecurityNumber, employeeName,
                    annualSalary, annualBonus );
        }
        else
        {
            System.out.println( "Invalid SSN!" );
        }
    }
    
    // Creates employee of type TeamLeader
    
    public void createTeamLeader( int index )
    {
        Scanner keyboard = new Scanner( System.in );
        String socialSecurityNumber;
        String employeeName;
        int trainingHours;
        Employee temp;
        
        System.out.print( "Enter new employee's Social " +
                            "Security Number: " );
        socialSecurityNumber = keyboard.next( );
        temp = new Employee( socialSecurityNumber, "" );
        if( alreadyExists( temp ) )
            System.out.println( "This employee already exists!" );
        else if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            System.out.print( "Enter new employee's name: " );
            employeeName = keyboard.next( );
            employeeName.trim( );
            System.out.print( "Enter number of training hours: " );
            trainingHours = keyboard.nextInt( );
            addAnEmployee( );
            employeeList[ index ] = 
                new TeamLeader( socialSecurityNumber, employeeName,
                                trainingHours );
        }
        else
        {
            System.out.println( "Invalid SSN!" );
        }
    }
    
    /** Helper Methods **/
    
    // Prompts user for initial input and gives errors,
    //    as well as displaying the information of each
    //    employee given
    
    public void gatherUserInput( )
    {
        boolean validJobTitle = true;
        String userOption = new String( "" );
        Scanner keyboard = new Scanner( System.in );
        
        //Gathering user input
        
        do
        {
            System.out.println( "Would you like to hire " +
                    "an Employee, ProductionWorker, " +
                    "ShiftSupervisor, or a TeamLeader? " +
                    "\n(Enter nothing to exit)" );
            userOption = keyboard.nextLine( );
            userOption.trim( );
            if( userOption.equals( "" ))
                break;
            else if( !userOption.equals( "" ) )
                validJobTitle = calculateUserOption( userOption );
            if( !validJobTitle )
                System.out.println( "Invalid job description, try again." );
        }while( !userOption.equals( "" ) );
        
        System.out.println( "   --Displaying employee Info--");
        for( int i = 0; i < numOfEmployees; i++ )
        {
            System.out.println( ( i + 1 ) + ". " + displayEmployeeInfo( 
                                              employeeList[ i ] ) );
        }
    }
    
    public String displayEmployeeInfo( Employee e )
    {
        return e.toString( ) + "\nWeekly pay: $" + 
               e.calculateWeeklyPay( );
    }
    /** Main Method **/
    
    public static void main( String args[ ] )
    {
        // Local Variables
        Lab13Driver test = new Lab13Driver( );
        test.gatherUserInput( );
    }
}