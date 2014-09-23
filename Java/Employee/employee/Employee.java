/*********************************************************************
*
*  File: Employee.java
*
*  Purpose: Define the Employee Superclass for workers in a oompany
*
*  Comments:
*     For CPS 245 Spring 2012 Lab 12
*     Using inheritance & polymorphism
*
*  ***** Main method was written by me, to test this class *****
*  ***** The rest was given for the assignment             *****
*********************************************************************/

package employee;

public class Employee
{
   /***************************************/
   //        Instance Variables
   /***************************************/

   private String 	            employeeName;
   private String 	            SSN;
   public static final int     SSN_SIZE = 9;
   private static final String DEFAULT_EMPLOYEE_NAME = "NO NAME GIVEN";
   private static final String DEFAULT_SSN           = "999999999";

   /***************************************/
   //           Constructors
   /***************************************/

   public Employee( String socSecNum )
   {
      this.setEmployeeSSN( socSecNum );
      this.setEmployeeName( "" );
   }

   public Employee( String socSecNum, String name )
   {
      this.setEmployeeSSN(socSecNum);
      this.setEmployeeName(name);
   }

   /***************************************/
   //    Transformers or Mutators
   /***************************************/

   public void setEmployeeSSN( String socSecNum )
   {
      if ( isValidSSN( socSecNum ) )
         SSN = socSecNum;
      else
         SSN = DEFAULT_SSN;
   }


   public void setEmployeeName( String name )
   {
      //*** check validity of name and set accordingly  ***

      if (name.length()>0)
         employeeName = name;
      else
         employeeName = DEFAULT_EMPLOYEE_NAME;

   }

   /***************************************/
   //        Accessors
   /***************************************/

   public String getEmployeeSSN()
   {
      return SSN;
   }

   public String getEmployeeName()
   {
      return employeeName;
   }

   public String toString()
   {
      return "\Employee --> SSN: " + this.getEmployeeSSN()  +
             "  Name: " + this.getEmployeeName();
   }

   public double calculateWeeklyPay()
   {
      //This returns 0 because it MUST be overridden in subclasses
      // of Employee. Company has some employees who volunteer, thus
      // they get no pay.

      return 0;
   }

   public boolean equals( Employee e )
   {
      // if SSNs are equal, then Employees are equal

      if ( SSN.equals( e.getEmployeeSSN() ) )
         return true;

      else
         return false;
   }

   /***************************************/
   //        Helper Methods
   // Can be called by class or client code
   /***************************************/

    public static boolean isValidSSN( String socSecNum )
   {
      //*** check validity of SSN ***

   boolean validSSN = true;
   int counter = 0;

   if (socSecNum.length() == SSN_SIZE)     // correct size
   {	// loop to check that all are digits
      while ( validSSN && counter < socSecNum.length() )
      {
          if ( !Character.isDigit(socSecNum.charAt( counter ) ) )
              validSSN = false;			// didn't find a digit
          counter++;
      }
   }
   else				//not valid - incorrect size
       validSSN = false;
   
   return validSSN;
   }
        
    public static void main( String [ ] args )
    {
        Employee test1 = new Employee( "SocNum" );
        Employee test2 = new Employee( new String( "123456789" ),
                                       new String( "test2" ) );
            
        System.out.println( "  ***  Testing  ***" );
            
        /*********************
         * Testing test1     *
         *********************/
           
        System.out.println( "\n        Test1" );
        System.out.println( " test1: " + test1.toString( ) );
        System.out.println( "\n     --Changing name to David-- " );
        test1.setEmployeeName( new String( "David" ));
        System.out.println( " test1: " + test1.toString( ) );
        System.out.println( "\n     --Changing SSN to 012345678-- " );
        test1.setEmployeeSSN( new String( "012345678" ) );
        System.out.println( " test1: " + test1.toString( ) );
            
        /*********************
         * Testing test2     *
         *********************/
           
        System.out.println( "\n        Test2" );
        System.out.println( " test2: " + test2.toString( ) );
        System.out.println( "\n     --Changing name to Zach-- " );
        test1.setEmployeeName( new String( "Zach" ));
        System.out.println( " test2: " + test2.toString( ) );
        System.out.println( "\n     --Changing SSN to 987654321-- " );
        test1.setEmployeeSSN( new String( "987654321" ) );
        System.out.println( " test2: " + test2.toString( ) );
            
        /*********************
        * Testing test1     *
        * and test2 equality*
         *********************/
        
        System.out.print( "\n Are test1 and test2 equal? " );
        if( test1.equals( test2 ) )
            System.out.println( " Yes!" );
        else
            System.out.println( " No!" );
    }
}