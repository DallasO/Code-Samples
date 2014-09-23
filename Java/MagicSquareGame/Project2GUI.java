/********************
 * Purpose: GUI to run Project2
 * 
 * Author: Dallas Opelt
 * 
 * Comments: 
 ********************/

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;
import java.util.*;

public class Project2GUI extends JFrame implements ActionListener
{
    /*** Class Constants ***/
    
        // Constants for dialogBox titles
    
    private static final String ALERT = "Alert";
    private static final String MAGIC_SQUARE = "Magic Square Game";
    
        // For output to user
    
    private static final String IS_MAGIC_SQUARE = 
            "The numbers entered DO make a Magic Square!";
    private static final String IS_NOT_MAGIC_SQUARE =
            "The numbers entered do NOT make a Magic Square!";
    
        // Prompt to user
    
    private static final String ENTER_INPUT = "Enter input file";
    
        // Error messages
    
    private static final String INT_NOT_ENTERED =
            "All the numbers entered were not integers!";
    private static final String INVALID_NUMBER =
            "You have entered an invalid number!";
    
    /*** Class Variables ***/
    
    private JLabel lblTitle;
    private JTextField[ ] txtSquareMatrix;
    private JTextField txtInputFile;
    private JButton btnClear;
    private JButton btnExit;
    private JButton btnCheck;
    private JButton btnInputFile;
            
    /* Constructors */
    
    public Project2GUI( )
    {
            // Outer container
        
        Container outerContainer = new Container( );
        outerContainer = getContentPane( );
        outerContainer.setLayout( new BorderLayout( ) );
        
            // Title for program
        
        lblTitle = new JLabel( MAGIC_SQUARE );
        lblTitle.setFont( new Font( "Courier", Font.BOLD, 16 ) );
        
            // Panel to hold textFields
        
        JPanel textFieldPanel = new JPanel( );
        textFieldPanel.setLayout( new GridLayout( 3, 3 ) );
        
        txtSquareMatrix = new MyTextField[ 9 ];
        for( int i = 0; i < txtSquareMatrix.length; i++ )
        {
            txtSquareMatrix[ i ] = new MyTextField( 10 );
            textFieldPanel.add( txtSquareMatrix[ i ] );
        }
        
            // Panel to hold buttons
        
        JPanel buttonPanel = new JPanel( );
        buttonPanel.setLayout( new GridLayout( 1, 3, 2, 0 ) );
        
        btnCheck = new JButton( "Check" );
        btnCheck.addActionListener( this );
        
        btnClear = new JButton( "Clear" );
        btnClear.addActionListener( this );
        
        btnExit = new JButton( "Exit" );
        btnExit.addActionListener( this );
        
            // Panel to hold input file components
        
        JPanel inputFilePanel = new JPanel( );
        inputFilePanel.setLayout( new BorderLayout( ) );
        
        txtInputFile = new JTextField( ENTER_INPUT, 15 );
        btnInputFile = new JButton( "Read from file" );
        btnInputFile.addActionListener( this );
        
        inputFilePanel.add( "North", txtInputFile );
        inputFilePanel.add( "South", btnInputFile );
        
        buttonPanel.add( btnCheck );
        buttonPanel.add( btnClear );
        buttonPanel.add( btnExit );
        
        outerContainer.add( "North", lblTitle );
        outerContainer.add( "Center", textFieldPanel );
        outerContainer.add( "South", buttonPanel );
        outerContainer.add( "East", inputFilePanel );
        
        setTitle( "Magic Square Checker" );
        pack( );
        setVisible( true );
    }
    
    // Check that numbers entered are within range and 
    //    are not repeated.
    
    public void validNumbers( int[ ] test )throws Exception
    {
        int i = 0;
        int j;
        
        while( i < test.length )
        {
            if( test[ i ] < 1 || test[ i ] > 9 )
            {
                throw new Exception( "The number in spot " + ( i + 1 ) +
                                     " is out of range!" );
            }
            j = i + 1; // starts in textfield after i.
            while( j < test.length )
            {
                if( test[ i ] == test[ j ] )
                {
                    throw new Exception( "The values in spots " + (i + 1 ) +
                                         " and " + (j + 1 ) + 
                                         " are the same!" );
                }
                j++;
            }
            i++;
        }
    }
    
    // Calculate if the numbers entered makes a magic square
    
    public void calculateMagicSquare( int[ ] userInput )
    {
        int magicNum;
        int numToCompare = 0;
        boolean isMagicSquare = true;
        
        // Finding the value of first row
        
        magicNum = userInput[ 0 ] + userInput[ 1 ] + userInput[ 2 ];
        
        // Finding value of second and third rows
        
        numToCompare = userInput[ 3 ] + userInput[ 4 ] + userInput[ 5 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        numToCompare = userInput[ 6 ] + userInput[ 7 ] + userInput[ 8 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        // Finding the value of diagnals
        
        numToCompare = userInput[ 0 ] + userInput[ 4 ] + userInput[ 8 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        numToCompare = userInput[ 2 ] + userInput[ 4 ] + userInput[ 6 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        // Finding the value of the columns
        
        numToCompare = userInput[ 0 ] + userInput[ 3 ] + userInput[ 6 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        numToCompare = userInput[ 1 ] + userInput[ 4 ] + userInput[ 7 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        numToCompare = userInput[ 2 ] + userInput[ 5 ] + userInput[ 8 ];
        if( magicNum != numToCompare )
            isMagicSquare = false;
        
        // Displaying result to user
        
        if( isMagicSquare )
            displayMessage( MAGIC_SQUARE, IS_MAGIC_SQUARE );
        else
            displayMessage( MAGIC_SQUARE, IS_NOT_MAGIC_SQUARE );
    }
    
    // Checks that the numbers entered are numbers
    
    public void checkUserInput( ) throws Exception
    {
        Scanner sc;
        int[ ] userInput = new int[ 9 ];
        int count = 0;
        boolean hasInt = true;
            
        while( count < txtSquareMatrix.length && hasInt )
        {
            sc = new Scanner( txtSquareMatrix[ count ].getText( ) );
               
            count++;
            if( !sc.hasNextInt( ) )
                throw new IOException( "Number in spot " +
                                       count +" is not an integer!" );
        }
            
        if( hasInt )
        {
            for( int i = 0; i < txtSquareMatrix.length; i++ )
            {
                userInput[ i ] =
                        Integer.parseInt(
                            txtSquareMatrix[ i ].getText( ) );
            }
            try
            {
                validNumbers( userInput );
                calculateMagicSquare( userInput );
            }
            catch( Exception exc )
            {
                displayMessage( ALERT, exc.getMessage( ) );
            }
        }
        else
        {
            throw new Exception( INT_NOT_ENTERED );
        }
    }
    
    // Display message box to user
    
    public void displayMessage( String title, String message )
    {
        JOptionPane.showMessageDialog( null, message, 
                                       title, WIDTH, null);
    }
    
            // Adapted from lab 13
    
    private void readTextFile( String fileName )
    {
        int count;
        StringTokenizer currentRecord;
        
        try
        {
            BufferedReader inStream
                = new BufferedReader ( new FileReader( fileName ) );
            String line = inStream.readLine();
            while( line != null )
            {
                count = 0;
                currentRecord = new StringTokenizer( line, " \n\t" );
                
                while( currentRecord.hasMoreTokens() && 
                       count < txtSquareMatrix.length )
                {
                    txtSquareMatrix[ count ].setText( 
                            currentRecord.nextToken( ) );
                    count++;
                }
                
                try
                {
                    checkUserInput( );
                }
                catch( IOException IOE )
                {
                    displayMessage( ALERT, IOE.getMessage( ) );
                }
                catch( Exception e )
                {
                    displayMessage( ALERT, e.getMessage( ) );
                }
                
                line = inStream.readLine();
            }
            displayMessage( ALERT, "No more records!" );
            
            inStream.close();
        }
        catch( NullPointerException NPE )
        {
            displayMessage( ALERT, "The file was empty!" );
        }
        catch ( FileNotFoundException e )
        {
            displayMessage( ALERT, "IO ERROR: File NOT Found: " +
                                   fileName + "\n" );
        }
        catch ( IOException e )
        {
            displayMessage( ALERT, "IOERROR: " + e.getMessage() + "\n" );
        }
    }
    
    public void actionPerformed( ActionEvent e )
    {
        if( e.getSource ( ) == btnClear )
        {
            for( int i = 0; i < txtSquareMatrix.length; i++ )
            {
                txtSquareMatrix[ i ].setText( "" );
            }
        }
        else if( e.getSource( ) == btnExit )
        {
            System.exit( 0 );
        }
        else if( e.getSource( ) == btnCheck )
        {
            try
            {
                checkUserInput( );
            }
            catch( IOException IOE )
            {
                displayMessage( ALERT, IOE.getMessage( ) );
            }
            catch( Exception ex )
            {
                displayMessage( ALERT, ex.getMessage( ) );
            }
        }
                
        else if( e.getSource( ) == btnInputFile )
        {
            String fileName = txtInputFile.getText( );
            readTextFile(  fileName );
        }
            
    }
        
    public static void main( String args[ ] )
    {
        Project2GUI test = new Project2GUI( );
    }
}