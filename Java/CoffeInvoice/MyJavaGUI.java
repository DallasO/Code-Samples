/**************************************
* Name: Dallas Opelt
*
* Purpose: Creates a GUI to use MyJava.java
*	   and help a user order coffee. 
*
* Date: 03/24/2012
*
* Comments: 09/23/14 - realized doesn't display correctly,
*             will update soon.
*
**************************************/

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.lang.Integer;

public class MyJavaGUI implements ActionListener
{
    /* Class Constants */
 
    /* Class Variables */
    
    // Objects frame
    
    private JFrame frame;
    
    // MyJava object
    
    public MyJava currentOrder;
    
    // TextFields
    
    public JTextField txtName;
    public JTextField txtBags;
    public JTextField txtStreetAddress;
    public JTextField txtAddress;
    
    // Buttons
    
    public JButton btnCreateInvoice;
    public JButton btnClear;
    public JButton btnPrint;
    public JButton btnExit;
    
    //  TextArea
    
    public JTextArea txaInvoiceArea;
    
    
    /* Constructors */
    
    public MyJavaGUI( )
    {
        frame = new JFrame( "MyJava Coffee Outlet" );
        currentOrder = new MyJava( );
    }
    
    
    /* Build the GUI */
    
    public void buildGUI( )
    {
        JPanel inputPanel = new JPanel( );
        inputPanel.setSize( new Dimension( 150, 200 ) );
        inputPanel.setLayout( new GridLayout( 3, 1 ) );
        
        Container contents = frame.getContentPane( );
        contents.setPreferredSize( new Dimension( 600, 450 ) );
        contents.setLayout( new FlowLayout(  ) );
        
        inputPanel.add( buildNameAndBagsPanel( ) );
        inputPanel.add( buildAddressPanel( ) );
        inputPanel.add( buildButtonPanel( ) );
        contents.add( inputPanel );
        contents.add( buildInvoiceArea( ) );
        
        frame.pack();
        frame.setVisible( true );
    }
    
    
    /*Build the Panels of the GUI */
    
       // Panel with name and bags label and texxt field
    
    public JPanel buildNameAndBagsPanel( )
    {
        JPanel nameAndBagsPanel = new JPanel( );
        nameAndBagsPanel.setLayout( new GridLayout( 1, 6 ) );
        nameAndBagsPanel.setPreferredSize( new Dimension( 600, 5 ) );
        
        JLabel lblBlankSpace= new JLabel( "" );
        
        JLabel lblName = new JLabel( "Name:   ", SwingConstants.RIGHT );
        txtName = new JTextField( 10 );
        
        JLabel lblBags = new JLabel( "Number of Bags:   ", SwingConstants.RIGHT );
        txtBags = new JTextField( 4 );
        
        nameAndBagsPanel.add( lblBlankSpace );
        nameAndBagsPanel.add( lblName );
        nameAndBagsPanel.add( txtName );
        nameAndBagsPanel.add( lblBags );
        nameAndBagsPanel.add( txtBags );
        nameAndBagsPanel.add( lblBlankSpace );
        
        return nameAndBagsPanel;
    }
    
       // Panel with the street address and address labels and text fields
    
    public JPanel buildAddressPanel( )
    {
        JPanel addressPanel = new JPanel( );
        addressPanel.setLayout( new GridLayout( 2, 2 ) );
        
        JLabel lblStreetAddress = new JLabel( "Street Address:   ", 
                                               SwingConstants.RIGHT );
        txtStreetAddress = new JTextField( 20 );
        
        JLabel lblAddress = new JLabel( "City, State Zip:   ", 
                                         SwingConstants.RIGHT );
        txtAddress = new JTextField( 20 );
        
        addressPanel.add( lblStreetAddress );
        addressPanel.add( txtStreetAddress );
        addressPanel.add( lblAddress );
        addressPanel.add( txtAddress );
        
        return addressPanel;
    }
    
       // Panel with the buttons
    
    public JPanel buildButtonPanel( )
    {
        JPanel buttonPanel = new JPanel( );
        buttonPanel.setLayout( new GridLayout( 1, 4 ) );
        
        btnCreateInvoice = new JButton( "Create Invoice" );
        btnCreateInvoice.addActionListener( this );
       
        btnClear = new JButton( "Clear" );
        btnClear.addActionListener( this );
        
        btnPrint = new JButton( "Print" );
        btnPrint.addActionListener( this );
        
        btnExit = new JButton( "Exit" );
        btnExit.addActionListener( this );
        
        buttonPanel.add( btnCreateInvoice );
        buttonPanel.add( btnClear );
        buttonPanel.add( btnPrint );
        buttonPanel.add( btnExit );
        
        return buttonPanel;
    }
    
       // Create the Invoice text area
    
    public JTextArea buildInvoiceArea( )
    {
        txaInvoiceArea = new JTextArea( 1, 5 );
        txaInvoiceArea.setEditable( false );
        txaInvoiceArea.setPreferredSize( new Dimension( 500, 300) );
        txaInvoiceArea.setFont( new Font( "Courier", Font.PLAIN, 12 ) );
        
        return txaInvoiceArea;
    }
    
      // Take the users inout and set values to the MyJava object
    
    public void setValues( )
    {
       currentOrder.setName( txtName.getText( ) );
       currentOrder.setBagsOrdered( Integer.valueOf( txtBags.getText( ) ) );
       currentOrder.setDates();
       currentOrder.setShippingAddress( txtStreetAddress.getText( ) );
       currentOrder.setAddress( txtAddress.getText( ) );
       currentOrder.calculateNumBoxes();
    }
    
       // returns the invoice to print out
    
    public String createPrintOut( )
    {
        return "                 Customer Name:    " + 
               currentOrder.getCustomerName() + 
               "\n  Number of Bags Ordered:    " +
               currentOrder.getBagsOrdered() + 
               "\n                    Purchase Price:                            $ " + 
               currentOrder.returnSubtotal() +
               "\n\n                          Boxes Used:" +
               "\n                                              Large:   " + 
               currentOrder.getNumLargeBoxes( ) +"   Cost: $   " + 
               currentOrder.totalLargeCost( ) +
               "\n                                          Medium:   " + 
               currentOrder.getNumMediumBoxes( ) + "   Cost: $   " +
               currentOrder.totalMediumCost( ) +
               " \n                                              Small:   " + 
               currentOrder.getNumSmallBoxes() +"   Cost: $   " + 
               currentOrder.totalSmallCost( ) + "\n\n\n" + 
               "                            Total Cost:                             $ " 
               + currentOrder.returnTotal( ) +
               "\n\n                      Date of Order:   " + 
               currentOrder.getDate( currentOrder.getDateOrdered( ) ) +
               "\n    Expected Date of Arrival:   " + 
               currentOrder.getDate( currentOrder.getDateExpected( ) ) +
               "\n\n    Shipping Address:      " +
               currentOrder.getShippingAddress() + 
               "\n                                            " +
               currentOrder.getAddress();
    }
    
       // Action performed method
    
    public void actionPerformed( ActionEvent e )
    {
        if( e.getSource() == btnCreateInvoice )
        {
            setValues( );
            txaInvoiceArea.setText( createPrintOut( ) );
        }
        else if( e.getSource() == btnClear )
        {
            txtName.setText( "" );
            txtBags.setText( "" );
            txtStreetAddress.setText( "" );
            txtAddress.setText( "" );
            txaInvoiceArea.setText( "" );
        }
        else if( e.getSource() == btnPrint )
        {
            setValues( );
            System.out.print( createPrintOut( ) );
        }
        else if( e.getSource() == btnExit )
        {
            System.exit( 0 );
        }
    }
    
       // Main method
    public static void main( String [ ] args )
    {
        MyJavaGUI openGUI = new MyJavaGUI( );
        
        openGUI.buildGUI( );
    }
}