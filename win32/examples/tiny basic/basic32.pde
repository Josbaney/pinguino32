// test basic interpreter on Pinguino
// Jean-Pierre Mandon 2011

#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#define NUM_LAB 100
#define LAB_LEN 10 
#define FOR_NEST 25
#define SUB_NEST 25
#define PROG_SIZE 10000

#define DELIMITER  	1
#define VARIABLE  	2
#define NUMBER    	3
#define COMMAND   	4
#define STRING	  	5
#define QUOTE	  	6

#define EOL   		9
#define FINISHED  	10

#define PRINT 		1
#define INP 		2
#define IF    		3
#define THEN  		4
#define FOR   		5
#define NEXT  		6
#define TO    		7
#define GOTO  		8
#define EOL   		9
#define FINISHED  	10
#define GOSUB 		11
#define RETURN 		12
#define END 		13

struct commands 
	{ 
	char command[20];
	char tok;
	};

const struct commands table[12]
 = {
	{"print", PRINT},
	{"input", INP},
	{"if", IF},
	{"then", THEN},
	{"goto", GOTO},
	{"for", FOR},
	{"next", NEXT},
	{"to", TO},
	{"gosub", GOSUB},
	{"return", RETURN},
	{"end", END},
	{"", END}
	};

struct for_stack 
	{
	int var; 	// counter variable
	int target; // target value 
	char *loc;
	} fstack[FOR_NEST]; // stack for FOR/NEXT loop

struct for_stack fpop();

char token[80];
char token_type, tok=0;

int ftos;  // index to top of FOR stack
int gtos;  // index to top of GOSUB stack


char *prog;
const char programme[]={"PRINT \"BONJOUR\"\0"};

/*
int variables[26]= {    // 26 user variables,  A-Z
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0
};
*/

//void get_exp(int *result);
//int find_var(char *s);
//void level2(int *result), level3(int *result), level4(int *result), level5(int *result), level6(int *result), primitive(int *result);
//void unary(char o, int *r), arith(char o, int *r, int *h);
//void fpush(struct for_stack i);
/*
// function atoi here because of a bug in Pinguino 9-05
int atoi(char * s)
{
  int rv=0; 
  char sign = 0;

     while (*s) {
	if (*s <= '9' && *s >= '0')
		break;
	if (*s == '-' || *s == '+') 
		break;
	s++;
     } 	  

     if(*s == '-')sign=1;

     if (*s == '-' || *s == '+') s++;

     while (*s && *s >= '0' && *s <= '9') {
	rv = (rv * 10) + (*s - '0');
        s++;
     }
     if(sign)return (-rv);
     else return (rv);
}
*/
// display an error message
void basicerror(u8 error)
{
  const char *e[]= {   
    "syntax error", 
    "unbalanced parentheses", 
    "no expression present",
    "equals sign expected",
    "not a variable",
    "Label table full",
    "duplicate label",
    "undefined label",
    "THEN expected",
    "TO expected",
    "too many nested FOR loops",
    "NEXT without FOR",
    "too many nested GOSUBs",
    "RETURN without GOSUB"
  }; 
  Serial.printf("%s\n\r", e[error]); 
}

// check if space or tab
iswhite(char c)
{
  if(c==' ' || c=='\t') return 1;
  else return 0;
}

// check if delimiter
isdelim(char c) 
{
  if(strchr(" ;,+-<>/*%^=()", c) || c==9 || c=='\r' || c==0) 
    return 1;  
  return 0;
}

// Look up a a token's internal representation in the token table.
look_up(char *s)
{
  int i;
  char *p;

  /* convert to lowercase */
  p = s;
  while(*p){ *p = tolower(*p); p++; }

  /* see if token is in table */
  for(i=0; *table[i].command; i++)
      if(!strcmp(table[i].command, s)) return table[i].tok;
  return 0; /* unknown command */
}

// analyse token
get_token()
{

  register char *temp;

  token_type=0; tok=0;
  temp=token;

  // check end of file
  if(*prog=='\0') { 
    *token=0;
    tok = FINISHED;
    return(token_type=DELIMITER);
  }

  while(iswhite(*prog)) ++prog;  

  if(*prog=='\r') { 
    ++prog; ++prog;
    tok = EOL; *token='\r';
    token[1]='\n'; token[2]=0;
    return (token_type = DELIMITER);
  }

  if(strchr("+-*^/%=;(),><", *prog)){ 
    *temp=*prog;
    prog++; 
    temp++;
    *temp=0; 
    return (token_type=DELIMITER);
  }
    
  if(*prog=='"') { 
    prog++;
    while(*prog!='"'&& *prog!='\r') *temp++=*prog++;
    if(*prog=='\r') basicerror(1);
    prog++;*temp=0;
    return(token_type=QUOTE);
  }
  
  if(isdigit(*prog)) { 
    while(!isdelim(*prog)) *temp++=*prog++;
    *temp = '\0';
    return(token_type = NUMBER);
  }

  if(isalpha(*prog)) { 
    while(!isdelim(*prog)) *temp++=*prog++;
    token_type=STRING;
  }

  *temp = '\0';

  if(token_type==STRING) {
    tok=look_up(token);
    if(!tok) token_type = VARIABLE;
    else token_type = COMMAND;
  }    
  return token_type;
}
/*
// Return a token to input stream.
void putback() 
{

  char *t; 

  t = token; 
  for(; *t; t++) prog--; 
}

// Entry point into parser.
void get_exp(int *result)
{
  get_token();
  if(!*token) 
	{
    basicerror(2);
    return;
	}
  level2(result);
  putback(); // return last token read to input stream
}
*/
/*
// Assign a variable a value.
void assignment()
{
  int var, value;

  // get the variable name
  get_token();
  if(!isalpha(*token)) {
    basicerror(4);
    return;
  }

  var = toupper(*token)-'A';
 
  // get the equals sign
  get_token();
  if(*token!='=') {
    basicerror(3);
    return;
  }

  // get the value to assign to var
  get_exp(&value);

  // assign the value
  variables[var] = value;
}
*/

// Execute a simple version of the BASIC PRINT statement
void basicprint()
{
  int answer;
  int len=0, spaces;
  char last_delim;

  do {
    get_token();
    if(tok==EOL || tok==FINISHED) break;
    if(token_type==QUOTE) 
		{
		Serial.printf("%s\r",token);
		len += strlen(token);
		get_token();
		}
/*				
    else 
		{ // is expression
		putback();
		get_exp(&answer);
		get_token();
		len += printf("%d", answer);
		}				
*/		
    last_delim = *token; 

    if(*token==';') 
		{
		spaces = 8 - (len % 8); 
		len += spaces;
		while(spaces) 
			{ 
			Serial.printf(" ");
			spaces--;
			}
		}
    else if(*token==',');
    else if(tok!=EOL && tok!=FINISHED) basicerror(0); 
	} while (*token==';' || *token==',');

	if(tok==EOL || tok==FINISHED) 	{
									if(last_delim != ';' && last_delim!=',') Serial.printf("\n");
									}
	else basicerror(0);

}
/*
// Execute a FOR loop.
void exec_for()
{
  struct for_stack i;
  int value;

  get_token(); // read the control variable
  if(!isalpha(*token)) {
    basicerror(4);
    return;
  }

  i.var=toupper(*token)-'A'; // save its index

  get_token(); // read the equals sign
  if(*token!='=') {
    basicerror(3);
    return;
  }

  get_exp(&value); // get initial value 

  variables[i.var]=value;

  get_token();
  if(tok!=TO) basicerror(9); // read and discard the TO

  get_exp(&i.target); // get target value 

  // if loop can execute at least once, push info on stack 
  if(value>=variables[i.var]) { 
    i.loc = prog;
    fpush(&i);
  }
  else  // otherwise, skip loop code altogether 
    while(tok!=NEXT) get_token();
}

// Push function for the FOR stack.
void fpush(struct for_stack i)
{
   if(ftos>FOR_NEST)
    basicerror(10);

  fstack[ftos]=&i;
  ftos++;
}
*/

void setup()
{
//Serial.begin(9600);
}

void loop()
{
//prog=&programme;
  do {
    token_type = get_token();
    /*
    // check for assignment statement
    
    if(token_type==VARIABLE) {
      putback(); 		// return the var to the input stream
      assignment(); 	// must be assignment statement 
    }
    else // is command
    */
      switch(tok) {
        case PRINT:		basicprint();
						break;
						
        case GOTO: 		exec_goto();
						break;
		case IF:		exec_if();
						break;						
		case FOR:		exec_for();
						break;
		case NEXT:		next();
						break;						
		case INP:		input();
						break;
        case GOSUB:		gosub();
						break;
		case RETURN:	greturn();
						break;
						
        case END:		while(1); // should give the pointer to the user here
      }
  } while (tok != FINISHED);
while(1);  
}

/*
//  Add or subtract two terms.
void level2(int *result)
{
  register char  op; 
  int hold; 

  level3(result); 
  while((op = *token) == '+' || op == '-') {
    get_token(); 
    level3(&hold); 
    arith(op, result, &hold);
  }
}

// Multiply or divide two factors.
void level3(int *result)
{
  register char  op; 
  int hold;

  level4(result); 
  while((op = *token) == '*' || op == '/' || op == '%') {
    get_token(); 
    level4(&hold); 
    arith(op, result, &hold); 
  }
}

// Process integer exponent.
void level4(int *result)
{
  int hold; 

  level5(result); 
  if(*token== '^') {
    get_token(); 
    level4(&hold); 
    arith('^', result, &hold); 
  }
}

// Is a unary + or -.
void level5(int *result)
{
  register char  op; 

  op = 0; 
  if((token_type==DELIMITER) && *token=='+' || *token=='-') {
    op = *token; 
    get_token(); 
  }
  level6(result); 
  if(op)
    unary(op, result); 
}

// Process parenthesized expression.
void level6(int *result)
{
  if((*token == '(') && (token_type == DELIMITER)) {
    get_token(); 
    level2(result); 
    if(*token != ')')
      basicerror(1);
    get_token(); 
  }
  else
    primitive(result);
}

// Find value of number or variable.
void primitive(int *result)
{

  switch(token_type) {
  case VARIABLE:
    *result = find_var(token);
    get_token(); 
    return; 
  case NUMBER:
    *result = atoi(token);
    get_token();
    return;
  default:
    basicerror(0);
  }
}

// Perform the specified arithmetic.
void arith(char o, int *r, int *h)
{
  register int t, ex;

  switch(o) {
    case '-':
      *r = *r-*h; 
      break; 
    case '+':
      *r = *r+*h; 
      break; 
    case '*':  
      *r = *r * *h; 
      break; 
    case '/':
      *r = (*r)/(*h);
      break; 
    case '%':
      t = (*r)/(*h); 
      *r = *r-(t*(*h)); 
      break; 
    case '^':
      ex = *r; 
      if(*h==0) {
        *r = 1; 
        break; 
      }
      for(t=*h-1; t>0; --t) *r = (*r) * ex;
      break;       
  }
}

// Reverse the sign.
void unary(char o, int *r)
{
  if(o=='-') *r = -(*r);
}

// Find the value of a variable.
int find_var(char *s)
{
  if(!isalpha(*s)){
    basicerror(4); // not a variable
    return 0;
  }
  return variables[toupper(*token)-'A'];
}
*/
