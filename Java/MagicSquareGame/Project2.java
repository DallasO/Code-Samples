/********************
 * Purpose: To find "Magic Squares"
 * 
 * Author: Dallas Opelt
 * 
 * Comments: 
 ********************/

import java.math.*;
public class Project2 
{
    private int[ ] numList;
    
    /* Constructors */
    
    public Project2( int n, int[ ] list )
    {
        numList = new int[ n ];
        
        for( int i = 0; i < numList.length; i++ )
        {
            numList[ i ] = list[ i ];
        }
    }
    
    /* Accessor Methods */
    
    public int[ ] getNumList( )
    {
        return numList;
    }
    
    /* Mutator Methods */
    
    public void setNumList( int[ ] newList )
    {
        numList = newList;
    }
}