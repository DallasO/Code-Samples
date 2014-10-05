//----------------------------------------------------------------
// Name:    Dallas Opelt
//
// Course:  CS 143, Section 01,  Fall 2011
//
// Purpose: This Program is to be used for grading multiple-choice,
//          including true/false, questions for exams given to  
//          one or more sections of a class.
//
// Input :  int number of questions of the exam.
//          char the answers to the answer key.
//          int number of sections.
//          int number of students in the current section.
//          char the answers from a student and that students
//               last name.
//
// Output:  Each students name and corresponding correct answers
//          and whether they passed or failed the exam from each
//          section. Then the number of students that passed the
//          exam are shown. After all sections are shown the number
//          of questions in the exam are shown, how many sections
//          there were, and the total that passed out of the total
//          that took the test.
//----------------------------------------------------------------
#include <iostream>
#include <string>
#include <iomanip>
#include <cctype>
using namespace std;

const int MAX_QUESTIONS  = 40; // For max number of questions.
const float PASS_PERCENT = 0.7;  // For the percent needed to pass.

void  ReadAnswers(char answers[], int numQuestions);
void  ProcessAnswer(const char keys[], const char answers[], 
                    int numQuestion, int& correct, bool& pass);
void  UpdateTotal(int& totalStudents, int& totalPassed, 
                  int numStudents, int passed);
void  ProcessOneSection(int& numStudents, int& Passed, 
                        int numQuestion, const char keys[]);

int main( )
{
   int numQuestions, sections; // Number of questions and sesctions.
   int totalPassed = 0, totalStudents = 0;// Total passed and students
   char keys[MAX_QUESTIONS]; // TO store answer key.
   cin >> numQuestions;
   ReadAnswers( keys, numQuestions );
   cin >> sections;
   for( int i = 0; i < sections; i++ )// Looping for each section.
   {
      int numStudents = 0, passed = 0;// Number of students and passed.
      cout << setw(9) << "Name" << setw(25) << "Correct Answers" 
        << setw(15) << "PASS/FAIL" << endl;
      cout << setw(15) << "---------------" << setw(19) 
        << "---------------" << setw(15) << "---------" << endl;
      ProcessOneSection( numStudents, passed, numQuestions, keys );
      UpdateTotal( totalStudents, totalPassed, 
                   numStudents, passed );
      cout << endl << passed << " out of " << numStudents 
           << " students of section " << i + 1 << " passed the exam." 
           << endl << endl << endl;
   }
   cout << "There are " << numQuestions 
        << " questions in the exam." << endl << "There are " 
        << sections << " sections, and " << totalPassed << " out of " 
        << totalStudents << " students passed the exam.";
   return 0;
}

// The function reads in numQuestions answers into array answers.
// Parameters: (out, in)
void  ReadAnswers(char answers[], int numQuestions)
{
   for( int i = 0; i < numQuestions ; i++ )// Looping for input.
      {
      cin >> answers[i];
      }
}

// The function compares a student's answers against the answer 
//     keys and passes back the number of correct answers and 
//     whether the student passed the exam.
// Parameters: (in, in, in, out, out)
void  ProcessAnswer(const char keys[], const char answers[], 
                    int numQuestion, int& correct, bool& pass)
{
   correct = 0; // Storing number of correct answers.
   for( int i = 0; i < numQuestion; i++ )// To find num corrrect.
   {
      if( toupper( answers[i] ) == toupper( keys[i] ) )
         correct++;
   }
   if( float( correct ) / numQuestion >= PASS_PERCENT )
      pass = true;
   else
      pass = false;
}

// This function processes one section at a time as the information
// is entered and displays information.
void  ProcessOneSection(int& numStudents, int& Passed, 
                        int numQuestion, const char keys[])
{
   char answers[MAX_QUESTIONS];// To store students answers.
   string lastName; // Store students last name.
   int correct; // Stores number of correct answers.
   bool pass; // If the student passed the exam.
   cin >> numStudents;
   for( int i = 0; i < numStudents; i++ ) // For each student.
   {
      ReadAnswers( answers, numQuestion );
      cin >> lastName; 
      ProcessAnswer( keys, answers, numQuestion, correct, pass );
      
      cout << setw( 15 ) << lastName << setw( 12 ) << correct 
           << setw( 20 );
      if( pass )
      {
         cout << "PASS" << endl;
         Passed += 1;
      }  
      else
         cout << "FAIL" << endl;
   }
}

// This function updates the total number of students that took the
//    exam and the total number of students that passed the exam.
// Params: in/out, in/out, in, in
void  UpdateTotal(int& totalStudents, int& totalPassed, 
                  int numStudents, int passed)
{
   totalStudents += numStudents;// Adding to total of students.
   totalPassed += passed;// Adding to total passing grades.
}
