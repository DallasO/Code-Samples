/*********************************************************************
*
*  File: Lab14Driver.java
*
*  Purpose: Define the Lab14Driver application
* 
*  Author: DallasO
*
*  Comments:
*     For CPS 245 Spring 2012 Lab 14
*     Using inheritance & polymorphism
*
*********************************************************************/

import java.util.Scanner;
import java.text.DecimalFormat;
import java.util.*;
import employee.Employee;

public class Lab14Driver
{    
    /** Class Variables **/
    
    private Employee employeeList [ ];
    private int numOfEmployees;
    
    /** Constructors **/
    
    public Lab14Driver( )
    {
        employeeList = new Employee[ 6 ];
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
        if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            if( alreadyExists( temp ) )
                System.out.println( "This employee already exists!" );
            else
            {
            System.out.print( "Enter new employee's name: " );
            employeeName = keyboard.next( );
            employeeName.trim( );
            addAnEmployee( );
            employeeList[ index ] = new Employee( socialSecurityNumber,
                                                  employeeName );
            }
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
        if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            if( alreadyExists( temp ) )
                System.out.println( "This employee already exists!" );
            else
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
        if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            if( alreadyExists( temp ) )
                System.out.println( "This employee already exists!" );
            else
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
        if( Employee.isValidSSN( socialSecurityNumber ) )
        {
            if( alreadyExists( temp ) )
                System.out.println( "This employee already exists!" );
            else
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
        }
        else
        {
            System.out.println( "Invalid SSN!" );
        }
    }
    
    /** Helper Methods **/
    
    public String displayEmployeeInfo( )
    {
        String employeeInfo = new String( "" );
        Employee e;
        
        for( int i = 0; i < numOfEmployees; i++ )
        {
            e = employeeList[ i ];
            employeeInfo += e.toString( ) + 
                            "\nWeekly pay: $" + e.calculateWeeklyPay( );
        };
        return employeeInfo;
    }
    
    public void displayMenu( )
    {
        Scanner keyboard = new Scanner( System.in );
        int currentIndex;
        int userInput = 0; 
        do
        {
            System.out.println( "\n\t1. Employee (non-paid volunteer)" +
                    "\n\t2. Production Worker" +
                    "\n\t3. Shift Supervisor" +
                    "\n\t4. Team Leader" +
                    "\n\t5. Exit" );
            System.out.print( "Your selection: " );
        
            currentIndex = getNumOfEmployees( );
            try
            {
                userInput = keyboard.nextInt( );
                switch( userInput )
                {
                    case 1: createEmployee( currentIndex );
                            System.out.println( "Employee Created! " );
                            break;
                    case 2: createProductionWorker( currentIndex );
                            System.out.println( "Employee Created! " );
                            break;
                    case 3: createShiftSupervisor( currentIndex );
                            System.out.println( "Employee Created! " );
                            break;
                    case 4: createTeamLeader( currentIndex );
                            System.out.println( "Employee Created! " );
                            break;
                    case 5: break;
                    default: System.out.println( " wrong choice entered!" );
                }
            }
            catch( InputMismatchException ime )
            {
                keyboard.next( );
                System.out.print( "Invalid option! Select 1-5: " );
            }
        }while( userInput != 5 );
            
        System.out.println( displayEmployeeInfo( ) );
        System.exit( 0 );
    }
    
    /** Main Method **/
    
    public static void main( String args[ ] )
    {
        // Local Variables
        Lab14Driver test = new Lab14Driver( );
        test.displayMenu( );
    }
}