//----------------------------------------------------------------------
//
// Name:    DO_01  Dallas Opelt
//
// Course:  CS 143, Section 01, Fall 2011     DO_02 Enter your section
//
// Purpose: This lab will give you practice using objects, arrays of 
//          objects as well as enumerated types. 
//
// Input:   The input is a list of seven cards represented as pairs of 
//          integers and characters, e.g., 2c => "Two of Clubs", 14s => 
//          "Ace of Spades", etc., with one card per line:
//
//          2c
//          8c
//          7s
//          10c
//          12h
//          7h
//          13s 
//          7d
//
// Output:  First, the cards in the hand are output according to the
//          specification of the Write function of the Card class.
//          Then, a message is displayed indicating if the hand of 
//          cards contains a two-of-a-kind (of any value/suit) or not.
//          Next, after all of the two's are discarded from the
//          hand, a message indicates how many cards were discarded. 
//          Finally, the cards in the hand are displayed. For example,
//          given the above input, this program would generated the
//          following output:
//
//          2 of Clubs
//          8 of Clubs
//          7 of Spades
//          10 of Clubs
//          Queen of Hearts
//          7 of Hearts
//          King of Spades
//          
//          I have a two-of-a-kind!
//          
//          I discarded 1 card(s).
//          
//          8 of Clubs
//          7 of Spades
//          10 of Clubs
//          Queen of Hearts
//          7 of Hearts
//          King of Spades
//----------------------------------------------------------------------

#include <iostream>
#include <cctype> // needed for tolower()

using namespace std;

const int MAX_CARDS = 7;
const int NOT_FOUND = -1;

enum Suit { Hearts, Clubs, Spades, Diamonds };

enum Value { Two = 2, Three, Four, Five, Six, Seven, Eight, Nine,
             Ten, Jack, Queen, King, Ace };

//----------------------------------------------------------------------
// A class that represents a single card from a standard deck of 
// playing cards. Each card has a suit and a value. Once an instance of
// Card is created, it cannot be changed, i.e., it is "immutable." 
//----------------------------------------------------------------------
class Card
{
private:
   Suit suit;
   Value value;

   //-------------------------------------------------------------------
   // Writes only the suit of a card to the standard output. This 
   // function is declared in the private section because it should
   // only be used as a "helper" function for Write().
   //-------------------------------------------------------------------
   void WriteSuit() const
   {
      switch (suit)
      {
         case Diamonds:
            cout << " Diamonds";
            break;
         case Spades:
            cout << " Spades";
            break;
         case Hearts:
            cout << " Hearts";
            break;
         default:
            cout << " Clubs";
            break;
      }
   } // END OF WriteSuit()
   
   //-------------------------------------------------------------------
   // Writes only the value of a card to the standard output. This 
   // function is declared in the private section because it should
   // only be used as a "helper" function for Write().
   //-------------------------------------------------------------------
   void WriteValue() const
   {
      switch (value)
      {
         case Jack:
            cout << "Jack";
            break;
         case Queen:
            cout << "Queen";
            break;
         case King:
            cout << "King";
            break;
         case Ace:
            cout << "Ace";
            break;
         default:
            cout << int(value); // converts the enum type Value to its
                                // integer value
            break;
      }
   } // END OF WriteValue()
   
public:

   //-------------------------------------------------------------------
   // The default constructor creates a new ace of spades.
   //-------------------------------------------------------------------
   Card()
   {
      suit = Spades;
      value = Ace;
   } // END OF Card()
   
   //-------------------------------------------------------------------
   // Parameterized constructor allows the client code to create any
   // new card. No error checking is performed.
   // Params: (in,in)
   //-------------------------------------------------------------------
   Card(Value inValue, Suit inSuit)
   {
      suit = inSuit;
      value = inValue;
   } // END OF Card()
   
   //-------------------------------------------------------------------
   // Returns the value of the card.
   //-------------------------------------------------------------------
   Value GetValue() const
   {
      return value;
   } // END OF GetValue()
   
   //-------------------------------------------------------------------
   // DO_03: Write a function called GetSuit that takes NO PARAMETERS.
   //        It should return the suit of this card.
   //        Hint: look at the GetValue function above and use it as
   //        a template for writing GetSuit. 
   //
   //        Don't forget to include the "const" keyword at the
   //        end of the header!
   //-------------------------------------------------------------------
   Suit GetSuit() const
   {
      return suit;
   } // END OF GetSuit()
   
   //-------------------------------------------------------------------
   // Returns true if rhs is equal to this card, i.e., the two cards
   // share the same value and suit, and false otherwise. 
   // Params: (in)
   //-------------------------------------------------------------------
   bool Equal(const Card & rhs) const
   {
      return (value == rhs.value && suit == rhs.suit);
   } // END OF Equal()
   
   //-------------------------------------------------------------------
   // Writes a card to the standard output. The format of the output
   // is "<value_of_card> of <suit_of_card>". For example, if the
   // instance of Card on which Write() is invoked represents a two
   // of clubs, then this function outputs: "Two of Clubs". If the
   // Card is a king of diamonds, then this function outputs:
   // "King of Diamonds".
   //-------------------------------------------------------------------
   void Write() const
   {
      WriteValue();
      cout << " of";
      WriteSuit();
   } // END OF Write()
   
}; // END OF CLASS Card

//----------------------------------------------------------------------
// A (container) class that holds a list of (instances of) Cards.
//----------------------------------------------------------------------
class Hand
{
private:
   Card cards[MAX_CARDS]; 
   int numCards; 
   
   //-------------------------------------------------------------------
   // DO_04: Complete the private helper function Find. Find should try 
   //        to find the given card in the list of cards. Find should 
   //        return the index of the first occurrence of card or it 
   //        should return NOT_FOUND if card is not in the list.
   // Params: (in)
   //-------------------------------------------------------------------
   int Find(const Card & card) const
   {
      int index = NOT_FOUND;

      
      for( int i = 0; i < MAX_CARDS; i++ )
      {
         if( card.Equal( cards[i] ) )
            index = i;
      }
      return index;

   } // END OF Find()

public:
   //-------------------------------------------------------------------
   // Default constructor. Creates an empty Hand
   //-------------------------------------------------------------------
   Hand()
   {
      numCards = 0;
   } // END OF Hand()
   
   //-------------------------------------------------------------------
   // Adds a Card to the end of the list if the list is not full.
   // Returns true if score is successfully added, false otherwise.
   // params: (in)
   //-------------------------------------------------------------------
   bool AddCard(const Card & cardToAdd)
   {
      if (numCards >= MAX_CARDS)
         return false;
      cards[numCards] = cardToAdd;
      numCards++;
      return true;
   } // END OF DealCard()
   
   //-------------------------------------------------------------------
   // Deletes the first occurrence of cardToDelete from the list, 
   // if it exists.  Moves all cards up, maintaining relative positions, 
   // if it is deleted.  Returns true if the card is successfully 
   // deleted, false otherwise.
   // params: (in)
   //-------------------------------------------------------------------
   bool Discard(const Card & cardToDelete)
   {
      int index = Find(cardToDelete);
      if (index >= 0)
      {
         --numCards;
         for (int i = index; i < numCards; i++)
            cards[i] = cards[i + 1];
         return true;
      }
      return false;
   } // END OF Discard()
   
   //-------------------------------------------------------------------
   // Returns true if the list has two cards of the same value, i.e.,
   // if the list has a pair, and false otherwise.
   //-------------------------------------------------------------------
   bool ContainsTwoOfAKind() const
   {
      for (int i = 0; i < numCards; i++)
      {
         //-------------------------------------------------------------
         // DO_05: Write a for loop that loops over all the cards in
         //        the hand that come *after* the i-th card and check
         //        to see if the value of each card is equal to the
         //        value of the i-th card. Hint: initialize j such that
         //        it is one more than the value of i and loop while
         //        j is less than the number of cards in the hand. 
         //-------------------------------------------------------------
         for (int j = i + 1; j < MAX_CARDS; j++)
         {
            if (cards[j].GetValue() == cards[i].GetValue() )
               return true;
         }
      }
      return false;
   } // END OF HasTwoOfAKind()

   //-------------------------------------------------------------------
   // Writes all of the cards to the standard output. 
   //-------------------------------------------------------------------
   void Write() const
   {
      for (int i = 0; i < numCards; i++)
      {
         cards[i].Write();
         if (i < numCards - 1)
            cout << endl;
      }
   } // END OF Write()
  
}; // END OF CLASS Hand

// function prototypes:
void DealSomeCards(Hand & hand, int howMany);
Suit CharToSuit(char input_char);

int main()
{
   Hand hand;

   //-------------------------------------------------------------------
   // DO_06: Declare four instances of Cards: two of clubs, two of 
   //        diamonds, two of spades and two of hearts. Name them
   //        twoOfClubs, twoOfDiamonds, twoOfSpades and twoOfHearts
   //        respectively. Hint: use the parameterized constructor of
   //        the Card class. 
   //-------------------------------------------------------------------
   Card twoOfClubs( Two, Clubs );
   Card twoOfDiamonds( Two, Diamonds );
   Card twoOfSpades( Two, Spades );
   Card twoOfHearts( Two, Hearts );

   int discard_count = 0;
   
   DealSomeCards(hand, MAX_CARDS);
   hand.Write();
   cout << endl << endl;
   
   //-------------------------------------------------------------------
   // DO_07: Determine if the hand that is declared up above contains
   //        a two-of-a-kind. Hint: call the appropriate member
   //        function.
   //
   //        If the hand contains a two-of-a-kind, output the message:
   //        
   //        "I have a two-of-a-kind!"
   //
   //        otherwise, if the hand does not contain a two-of-a-kind,
   //        output the message:
   //
   //        "I do not have a two-of-a-kind.";
   //-------------------------------------------------------------------
   if ( hand.ContainsTwoOfAKind() )
      cout << "I have a two-of-a-kind!";
   else
      cout << "I do not have a two-of-a-kind.";
   cout << endl << endl;
      
   // If the two of clubs can be discarded, increment the current number
   // of cards that have been discarded:
   if (hand.Discard(twoOfClubs) == true)
      discard_count++;
      
   //-------------------------------------------------------------------
   // DO_08: Increment discard_count if you were able to successfully
   //        discard the two of diamonds.
   //-------------------------------------------------------------------
   if ( hand.Discard( twoOfDiamonds ) == true )
      discard_count++;
      
   //-------------------------------------------------------------------
   // DO_09: Increment discard_count if you were able to successfully
   //        discard the two of spades.
   //-------------------------------------------------------------------
   if ( hand.Discard( twoOfSpades ) == true )
      discard_count++;
      
   //-------------------------------------------------------------------
   // DO_10: Increment discard_count if you were able to successfully
   //        discard the two of hearts.
   //-------------------------------------------------------------------
   if ( hand.Discard( twoOfHearts ) == true )
      discard_count++;
      
   cout << "I discarded " << discard_count << " card(s)." << endl << endl;
   
   //-------------------------------------------------------------------
   // DO_11: Write the hand to the standard output.
   //-------------------------------------------------------------------
   hand.Write();
      
   return 0;
} // END OF main()

//----------------------------------------------------------------------
//
// STOP! DO NOT MODIFY ANY OF THE CODE THAT FOLLOWS!
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// Reads in howMany cards from the standard input and stores them in
// hand. 
// Params: (inout, in)
//----------------------------------------------------------------------
void DealSomeCards(Hand & hand, int howMany)
{
   Suit suit;
   Value value;
   char input_char;
   int input_int;

   for (int i = 0; i < howMany; i++)
   {
      cin >> input_int;
      cin >> input_char;
      suit = CharToSuit(input_char);
      value = Value(input_int); // expclit typecast from int to Value
      Card card(value, suit);
      if (hand.AddCard(card) == false)
         cout << "Could not deal new card." << endl;
   }
} // END OF DealSomeCards()

//----------------------------------------------------------------------
// Converts a character to the corresponding suit.
// Params: (in)
//----------------------------------------------------------------------
Suit CharToSuit(char input_char)
{
   input_char = tolower(input_char);
   Suit suit;
   switch (input_char)
   {
      case 'd':
         suit = Diamonds;
         break;
      case 'h':
         suit = Hearts;
         break;
      case 's':
         suit = Spades;
         break;
      default:
         suit = Clubs;
		 break;
   }
   return suit;
} // END OF CharToSuit()
