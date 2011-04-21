/*	----------------------------------------------------------------------------
	A Tiny Basic Interpreter
	----------------------------------------------------------------------------
	author:				unknown
	modified by:		Régis Blanchot
	first release:		03/01/2011
	last update:		26/02/2011
	pinguino ide:		X
	pinguino board:	tested with UBW32
	compiler:			C32
	----------------------------------------------------------------------------
	TODO:
		- EDITOR
			- ADD numline line (add a line to the program)
			- DEL numline (delete a line in the program)
			- CLS (clear current screen)
			- HELP (list all Basic functions)
		- LANGUAGE		argument		comment
			- REM		 					(add comment to the program)
			- INPUT		numpin
			- OUTPUT		numpin
			- HIGH		numpin		(turn pin numpin to High) 
			- LOW			numpin		(turn pin numpin to Low)
			- PAUSE		ms				(delay for ms milliseconds)
			- TOGGLE		numpin
			- BUTTON		numpin		(read switch status)
			- POT			numpin
			- PULSIN		numpin, status, variable
			- PULSOUT	numpin, period
			- PWM			numpin, dutycycle, frequency
			- RANDOM
			- READ		numbyte 		(read byte number numbyte of eeprom)
			- WRITE		numbyte 		(write byte number numbyte of eeprom)
			- SERIN		variable
			- SEROUT		variable
			- I2CIN
			- I2COUT
	--------------------------------------------------------------------------*/







/*	----------------------------------------------------------------------------
	Define
	--------------------------------------------------------------------------*/

#define NUM_LAB	100
#define LAB_LEN	10 
#define FOR_NEST	25
#define SUB_NEST	25
#define PROG_SIZE 6184	

#define DELIMITER	1
#define VARIABLE	2
#define NUMBER		3
#define COMMAND 	4
#define STRING		5
#define QUOTE		6

#define PRINT 		1
#define _INPUT 	2
#define IF			3
#define THEN		4
#define FOR	 		5
#define NEXT		6
#define TO			7
#define GOTO		8
#define EOL			9
#define FINISHED	10
#define GOSUB 		11
#define RETURN 	12
#define LOAD 		13
#define RUN 		14
#define LIST 		15
#define ADD 		16
#define DEL 		17
#define REM 		18
#define END 		19

/*	----------------------------------------------------------------------------
	Typedef
	--------------------------------------------------------------------------*/

//
typedef struct
{
	char command[20];
	char tok;
} commands;

typedef struct
{
	char name[LAB_LEN];
	char *p;		// points to place to go in source file
} label;

typedef struct
{
	int var;		// counter variable
	int target;		// target value
	char *loc;
} for_stack;

/*	----------------------------------------------------------------------------
	Variables
	--------------------------------------------------------------------------*/

//
int variables[26] =
{
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,\
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,\
	0, 0, 0, 0, 0, 0
};

//
commands table[] =
{
	"print",		PRINT,\
	"input",		_INPUT,\
	"if",			IF,\
	"then",		THEN,\
	"goto",		GOTO,\
	"for",		FOR,\
	"next",		NEXT,\
	"to",			TO,\
	"gosub",		GOSUB,\
	"return",	RETURN,\
	"load",		LOAD,\
	"run",		RUN,\
	"list",		LIST,\
	"add",		ADD,\
	"del",		DEL,\
	"rem",		REM,\
	"end",		END,\
	"",			END				// mark end of table
};

char *prog;							// holds program expression to be analyzed
List *lines;						// holds program lines
jmp_buf e_buf;						// hold environment for longjmp()
char *token;						// holds token
char token_type;
char tok;
label label_table[NUM_LAB];
for_stack fstack[FOR_NEST];	// stack for FOR/NEXT loop
char *gstack[SUB_NEST];			// stack for gosub

int ftos;							// index to top of FOR stack
int gtos;							// index to top of GOSUB stack

/*	----------------------------------------------------------------------------
	Prototypes
	--------------------------------------------------------------------------*/

int  exec_load(void);
void exec_run(void);
void exec_list(void);
void exec_add(char *);
void exec_del(char *);

void exec_print(void);
void exec_goto(void);
void exec_if(void);
void exec_for(void);
void exec_next(void);
void exec_input(void);
void exec_gosub(void);
void exec_return(void);

void prog2list(void);
void assignment(void);
void scan_labels(void);
void find_eol(void);
int  get_next_label(char *);
char *find_label(char *);
void label_init(void);
void fpush(for_stack);
for_stack fpop(void);
void gpush(char *);
char *gpop(void);
void get_exp(int *);
void serror(int);
char get_token(void);
void putback(void);
int  look_up(char *);
int  isdelim(char);
int  iswhite(char);
void level2(int *);
void level3(int *);
void level4(int *);
void level5(int *);
void level6(int *);
void primitive(int *);
void arith(char, int *, int *);
void unary(char, int *);
int  find_var(char *);

/*	----------------------------------------------------------------------------
	Programs examples (just uncomment the one you want to test)
	--------------------------------------------------------------------------*/

/*
const char program[] =
{
	"PRINT \"HELLO WORLD !\"\n"
};

const char program[] =
{
	"start\n"\
	"PRINT \"HELLO WORLD !\"\n"\
	"GOTO start\n"\
	"END\n"
};
*/

const char program[] =
{
//
	"FOR I=1 TO 10\n"\
	"PRINT \"HELLO WORLD !\"\n"\
	"NEXT I\n"\
	"END\n"
};

/*	----------------------------------------------------------------------------
	Setup (rblanchot@gmail.com)
	--------------------------------------------------------------------------*/

void setup()
{
	u8 i;

//
	debug();
//

//
	token = (char *) malloc(80);
	if (token == 0)
	{
		serial1printf("Error: allocation failure\n");
		exit(1);
	}
	 
//
	if(setjmp(e_buf))
		exit(1);

//
	for (i=0; i<30; i++)
		serial1printf("\n");
	
//
	serial1printf("***  PINGUINO 32 TINY BASIC V1.0  ***\n");
	serial1printf("512K RAM SYSTEM %u BASIC BYTES FREE\n", PROG_SIZE);
	serial1printf("\n");
	
//
	exec_load_from_memory();
}

/*	----------------------------------------------------------------------------
	Main loop (rblanchot@gmail.com)
	Wait for Editor commands
	- LIST
	- RUN
	- LOAD prog.bas
	- ADD numligne EXPRESSION -> shift right +1 all lines from numligne
	- DELLINE numligne -> shift left all lines -1 all lines from numligne
	- CLS
	--------------------------------------------------------------------------*/

void loop()
{
	serial1printf("READY\n");
	char *exp = serial1getstring();

	if ( strncmp(exp, "LIST", 4) == 0 || strncmp(exp, "list", 4) == 0 )
		exec_list();
	if ( strncmp(exp, "RUN", 3) == 0 || strncmp(exp, "run", 3) == 0 )
		exec_run();
/*
	if ( strncmp(exp, "LOAD", 4) == 0 )
		exec_load();
*/
	if ( strncmp(exp, "ADD", 3) == 0 || strncmp(exp, "add", 3) == 0 )
		exec_add(exp);
	if ( strncmp(exp, "DEL", 3) == 0 || strncmp(exp, "del", 3) == 0 )
		exec_del(exp);
}

/*	----------------------------------------------------------------------------
	List a program (rblanchot@gmail.com)
	--------------------------------------------------------------------------*/

void exec_list(void)
{
	u16 l, nbitems;
	char *item;

//
	nbitems = list_nb_item(lines);
//
	for (l = 0; l < nbitems; l++)
	{
		item = list_item(lines, l+1);
		if (item != NULL)
			serial1printf("%4d %s\n", l+1, item);
	}

/*	---version 1----------------------------------------------------------------
	u8 i;
	u16 l=0;
	char *car;
	
	car = prog;								// program's first character 
	
	while (car[0] != '\0')
	{
		serial1printf("%4u ", l);
		for (i = 0; car[i] != '\n'; i++)
			serial1printf("%c", car[i]);
		serial1printf("\n");
		car = car + i + 1;					// next line's first character
		l++;
	}
	--------------------------------------------------------------------------*/
}

/*	----------------------------------------------------------------------------
	Run a program (rblanchot@gmail.com)
	--------------------------------------------------------------------------*/

void exec_run(void)
{
	scan_labels(); 				// find the labels in the program
	ftos = 0; 					// initialize the FOR stack index
	gtos = 0; 					// initialize the GOSUB stack index

	do
	{
		token_type = get_token();

//
		if(token_type == VARIABLE)
		{
			putback();			// return the var to the input stream
			assignment(); 		// must be assignment statement
		}
		else // is command
		{
			switch(tok)
			{
				case PRINT:
					exec_print();
					break;
				case GOTO:
					exec_goto();
					break;
				case IF:
					exec_if();
					break;
				case FOR:
					exec_for();
					break;
				case NEXT:
					exec_next();
					break;
				case _INPUT:
					exec_input();
					break;
				case GOSUB:
					exec_gosub();
					break;
				case RETURN:
					exec_return();
					break;
				case REM:
					break;
				case END:
					exit(0);
			}
		}
	}
	while (tok != FINISHED);
}

/*	----------------------------------------------------------------------------
	Load a program from SD-card (rblanchot@gmail.com)
	if no name after LOAD -> search for a program in memory
	--------------------------------------------------------------------------*/

int exec_load_from_memory(void)
{
	int i=0;
	char *buffer;

//
	buffer = (char *) malloc(PROG_SIZE);
	if (buffer == 0)
	{
		serial1printf("Error: allocation failure\n");
		exit(1);
	}

//
	for (i = 0; i < PROG_SIZE && program[i] != '\0'; i++)
		buffer[i] = program[i];
	for (; i < PROG_SIZE; i++)
		buffer[i] = '\0';

	prog = buffer;
//
	prog2list();
}

int exec_load(void)
{
/*
	FILE *fp;

	int i=0;
	char *buffer;

//

	buffer = (char *) malloc(PROG_SIZE);
	if (buffer == 0)
	{
		serial1printf("Error: allocation failure\n");
		exit(1);
	}

//
	get_token();

//
	if(!(fp=fopen(token, "rb")))
		return 0;

	i = 0;

	do
	{
		*buffer = getc(fp);
		buffer++;
		i++;
	}
	while(!feof(fp) && i < PROG_SIZE);
	fclose(fp);

	*(buffer-2) = '\0'; // null terminate the program
	prog = buffer;
*/
}

/*	----------------------------------------------------------------------------
	Add a line (rblanchot@gmail.com)
	--------------------------------------------------------------------------*/

void exec_add(char *exp)
{
	u16 l;
	
	l = strchr(exp, "add");			// traiter le cas des majuscules
	serial1printf("%d\n", l);
}

/*	----------------------------------------------------------------------------
	Del a line (rblanchot@gmail.com)
	--------------------------------------------------------------------------*/

void exec_del(char *exp)
{
}

/*	----------------------------------------------------------------------------
	Make a list from program's lines (rblanchot@gmail.com)
	--------------------------------------------------------------------------*/

void prog2list(void)
{
	u16 l;
	char *car;
	char *temp;
	
	temp = (char *) malloc(80);
	if (temp == 0)
	{
		serial1printf("Error: allocation failure\n");
		exit(1);
	}

	car = prog;								// program's first character 

//
	if (!lines)
		list_free_full_simple(lines);
	else
		lines = list_new();
		
	while (car[0] != '\0')
	{
//
		for (l = 0; car[l] != '\n'; l++)
			temp[l] = car[l];
//
		temp[l++] = '\0';
//
		lines = list_append(lines, temp);
		car += l;					// next line's first character
	}
}

/*	----------------------------------------------------------------------------
	Assign a variable a value
	--------------------------------------------------------------------------*/

void assignment(void)
{
	int var, value;

//

//
	get_token();
	if(!isalpha(*token))
	{
		serror(4);
		return;
	}

	var = toupper(*token)-'A';
 
//
	get_token();
	if (*token != '=')
	{
		serror(3);
		return;
	}

//
	get_exp(&value);

//
	variables[var] = value;
}

/*	----------------------------------------------------------------------------
	Execute a simple version of the BASIC PRINT statement
	--------------------------------------------------------------------------*/

void exec_print(void)
{
	int answer;
	int len=0, spaces;
	char *str;
	char last_delim;

	serial1printf("*** entering exec_print() ***\n");

	do {
//
		get_token();
		
		if (tok == EOL || tok == FINISHED)
			break;
		
//
		if (token_type == QUOTE)
		{
			serial1printf(token);
			len += strlen(token);
			get_token();
		}
//
		else
		{
			putback();
			get_exp(&answer);
			get_token();
			len += sprintf(str, "%d", answer);
		}
		last_delim = *token; 

		if (*token == ';')
		{
//
			spaces = 8 - (len % 8); 
//
			len += spaces;
			while(spaces)
			{ 
				serial1printf(" ");
				spaces--;
			}
		}
//
		else if (*token == ',')
			;
		else if (tok != EOL && tok != FINISHED)
			serror(0);
			
	} while (*token == ';' || *token == ',');

	if (tok == EOL || tok == FINISHED)
	{
		if (last_delim != ';' && last_delim!=',')
			serial1printf("\n");
	}
	else
	{
		serror(0); // error is not , or ;
	}
}

/*	----------------------------------------------------------------------------
	Find all labels
	--------------------------------------------------------------------------*/

void scan_labels(void)
{
	int addr;
	char *temp;		// address temp points on char

//

	label_init();	// zero all labels
	temp = prog;	// save pointer to top of program

//
	get_token();
	if (token_type == NUMBER)
	{
		strcpy(label_table[0].name, token);
		label_table[0].p = prog;
	}

	find_eol();
	do {		 
		get_token();
		if (token_type == NUMBER)
		{
			addr = get_next_label(token);
			if(addr==-1 || addr==-2)
			{
					(addr==-1)?serror(5):serror(6);
			}
			strcpy(label_table[addr].name, token);
			label_table[addr].p = prog;	// current point in program
		}
//
		if(tok!=EOL)
			find_eol();
	} while(tok != FINISHED);
//
	prog = temp;
}

/*	----------------------------------------------------------------------------
	Find the start of the next line
	--------------------------------------------------------------------------*/

void find_eol(void)
{
//

	while (*prog != '\n' && *prog != '\0')
		++prog;
	if (*prog)
		prog++;
}

/*	----------------------------------------------------------------------------
	Return index of next free position in label array. 
	 A -1 is returned if the array is full.
	 A -2 is returned when duplicate label is found.
	--------------------------------------------------------------------------*/

int get_next_label(char *s)
{
	register int t;

//

	for(t=0;t<NUM_LAB;++t)
	{
		if(label_table[t].name[0]==0)
			return t;
		if(!strcmp(label_table[t].name,s))
			return -2; // dup
	}
	return -1;
}

/*	----------------------------------------------------------------------------
	Find location of given label.	A null is returned if
	label is not found; otherwise a pointer to the position
	of the label is returned.
	--------------------------------------------------------------------------*/

char *find_label(char *s)
{
	register int t;

//

	for(t=0; t<NUM_LAB; ++t)
	{
		if(!strcmp(label_table[t].name,s))
			return label_table[t].p;
	}
	return '\0'; // error condition
}

/*	----------------------------------------------------------------------------
	Execute a GOTO statement
	--------------------------------------------------------------------------*/

void exec_goto(void)
{
	char *loc;

	serial1printf("*** entering exec_goto() ***\n");

//
	get_token();
//
	loc = find_label(token);
	if(loc=='\0')
		serror(7);			// label not defined
	else
		prog=loc;			// start program running at that loc
}

/*	----------------------------------------------------------------------------
	Initialize the array that holds the labels. 
	 By convention, a null label name indicates that
	 array position is unused.
	--------------------------------------------------------------------------*/

void label_init(void)
{
	register int t;

//

	for(t=0; t<NUM_LAB; ++t)
		label_table[t].name[0]='\0';
}

/*	----------------------------------------------------------------------------
	Execute an IF statement
	--------------------------------------------------------------------------*/

void exec_if(void)
{
	int x , y, cond;
	char op;

//
	get_exp(&x);
//
	get_token();
	if(!strchr("=<>", *token))
	{
//
		serror(0);
		return;
	}
	op = *token;
//
	get_exp(&y);
//
	cond = 0;
	switch(op)
	{
		case '<':
			if(x<y)
				cond=1;
			break;
		case '>':
			if(x>y)
				cond=1;
			break;
		case '=':
			if(x==y)
				cond=1;
			break;
	}
//
	if(cond)
	{
		get_token();
		if(tok!=THEN)
		{
			serror(8);
			return;
		}
	}
//
	else
	{
		find_eol();	// find start of next line
	}
}

/*	----------------------------------------------------------------------------
	Execute a FOR loop
	--------------------------------------------------------------------------*/

void exec_for(void)
{
	for_stack i;
	int value;

	serial1printf("*** entering exec_for() ***\n");

//
	get_token();
	if(!isalpha(*token))
	{
		serror(4);
		return;
	}
//
	i.var=toupper(*token)-'A';
//
	get_token();
	if(*token!='=')
	{
		serror(3);
		return;
	}
//
	get_exp(&value);

	variables[i.var]=value;

	get_token();
//
	if(tok!=TO)
		serror(9);
//
	get_exp(&i.target);
//
	if(value>=variables[i.var])
	{ 
		i.loc = prog;
		fpush(i);
	}
//
	else
	{
		while(tok!=NEXT)
			get_token();
	}
}

/*	----------------------------------------------------------------------------
	Execute a NEXT statement
	--------------------------------------------------------------------------*/

void exec_next(void)
{
	for_stack i;

//

//
	i = fpop();
//
	variables[i.var]++;
	if(variables[i.var]>i.target)
		return;	// all done
	fpush(i);	// otherwise, restore the info
	prog = i.loc;	// loop
}

/*	----------------------------------------------------------------------------
	Push function for the FOR stack
	--------------------------------------------------------------------------*/

void fpush(for_stack i)
{
//

	if(ftos>FOR_NEST)
		serror(10);

	fstack[ftos]=i;
	ftos++;
}

for_stack fpop(void)
{
	ftos--;
	if(ftos<0)
		serror(11);
	return(fstack[ftos]);
}

/*	----------------------------------------------------------------------------
	Execute a simple form of the BASIC INPUT command
	--------------------------------------------------------------------------*/

void exec_input(void)
{
	char str[80], var;
	int i;

	get_token(); // see if prompt string is present

	if(token_type==QUOTE)
	{
		serial1printf(token); // if so, print it and check for comma
		get_token();
		if(*token!=',') serror(1);
		get_token();
	}
	else
		serial1printf("? ");	// otherwise, prompt with /

	var = toupper(*token)-'A'; // get the input var

	scanf("%d", &i); // read input and place it at address from i

	variables[var] = i; // store it
}

/*	----------------------------------------------------------------------------
	Execute a GOSUB command
	--------------------------------------------------------------------------*/

void exec_gosub(void)
{
	char *loc;

	get_token();
//
	loc = find_label(token);
	if(loc=='\0')
		serror(7); // label not defined
	else
	{
		gpush(prog);	// save place to return to
		prog = loc;		// start program running at that loc
	}
}

/*	----------------------------------------------------------------------------
	Return from GOSUB
	--------------------------------------------------------------------------*/

void exec_return(void)
{
	 prog = gpop();
}

/*	----------------------------------------------------------------------------
	GOSUB stack push function
	--------------------------------------------------------------------------*/

void gpush(char *s)
{
	gtos++;

	if(gtos==SUB_NEST)
	{
		serror(12);
		return;
	}

	gstack[gtos]=s;
}

/*	----------------------------------------------------------------------------
	GOSUB stack pop function
	--------------------------------------------------------------------------*/

char *gpop(void)
{
	if(gtos==0)
	{
		serror(13);
		return 0;
	}

	return(gstack[gtos--]);
}

/*	----------------------------------------------------------------------------
	Entry point into parser
	--------------------------------------------------------------------------*/

void get_exp(int *result)
{
//
	get_token();
	if(!*token)
	{
		serror(2);
		return;
	}
	level2(result);
	putback(); // return last token read to input stream
}

/*	----------------------------------------------------------------------------
	display an error message
	--------------------------------------------------------------------------*/

void serror(int error)
{
	static char *e[]= {	 
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
	serial1printf("%s\n", e[error]); 
//
	longjmp(e_buf, 1);
}

/*	----------------------------------------------------------------------------
	Get a token
	--------------------------------------------------------------------------*/

char get_token(void)
{
	register char *temp;

//
	token_type = 0;
	tok = 0;
	temp = token;		// address temp = address token

//
	if (*prog == '\0')
	{
//
		*token = 0;
		tok = FINISHED;
		return(token_type = DELIMITER);
	}

	while (iswhite(*prog))
		++prog;	// skip over white space

//
	if (*prog == '\r')
	{
//
		++prog;
		++prog;
		tok = EOL;
		*token = '\r';
		token[1] = '\n';
		token[2] = 0;
		return (token_type = DELIMITER);
	}

//
	if (strchr("+-*^/%=;(),><", *prog))
	{
//
		*temp=*prog;
		prog++; // advance to next position
		temp++;
		*temp=0; 
		return (token_type=DELIMITER);
	}
		
//
	if (*prog == '\"')
	{
//
		prog++;
		while (*prog != '"' && *prog != '\r')
			*temp++ = *prog++;
		if (*prog == '\r')
			serror(1);
		prog++;
		*temp = 0;
		return(token_type = QUOTE);
	}
	
//
	if (isdigit(*prog))
	{
//
		while (!isdelim(*prog))
			*temp++ = *prog++;
		*temp = '\0';
		return(token_type = NUMBER);
	}

//
	if (isalpha(*prog))
	{
//
//
		char i=0;
		while (!isdelim(*prog))
		{
//
			*temp++ = *prog++; 					// variable à l'adresse  temp = variable à l'adresse prog 
		}
//
		token_type = STRING;
//
	}

	*temp = '\0';

//
	if (token_type == STRING)
	{
//
		tok = look_up(token); // convert to internal rep
		if(!tok)
			token_type = VARIABLE;
		else
			token_type = COMMAND; // is a command
	}

//
	return token_type;
}

/*	----------------------------------------------------------------------------
	Return a token to input stream
	--------------------------------------------------------------------------*/

void putback(void) 
{
	char *t; 

	t = token; 
	for(; *t; t++)
		prog--; 
}

/*	----------------------------------------------------------------------------
	Look up a a token's internal representation in the token table
	--------------------------------------------------------------------------*/

int look_up(char *s)
{
	register int i,j;
	char *p;

//
	p = s;
	while(*p)
	{
		*p = tolower(*p);
		p++;
	}

//
	for(i=0; *table[i].command; i++)
		if(!strcmp(table[i].command, s))
			return table[i].tok;

	return 0; // unknown command
}

/*	----------------------------------------------------------------------------
	Return true if c is a delimiter
	--------------------------------------------------------------------------*/

isdelim(char c) 
{
	if ( strchr(" ;,+-<>/*%^=()", c) || c==9 || c=='\r' || c==0 )
		return 1;
	return 0;
}

/*	----------------------------------------------------------------------------
	Return 1 if c is space or tab
	--------------------------------------------------------------------------*/

int iswhite(char c)
{
	if (c==' ' || c=='\t')
		return 1;
	else
		return 0;
}

/*	----------------------------------------------------------------------------
	Add or subtract two terms
	--------------------------------------------------------------------------*/

void level2(int *result)
{
	register char	op; 
	int hold; 

	level3(result); 
	while((op = *token) == '+' || op == '-')
	{
		get_token(); 
		level3(&hold); 
		arith(op, result, &hold);
	}
}

/*	----------------------------------------------------------------------------
	Multiply or divide two factors
	--------------------------------------------------------------------------*/

void level3(int *result)
{
	register char	op; 
	int hold;

	level4(result); 
	while((op = *token) == '*' || op == '/' || op == '%')
	{
		get_token(); 
		level4(&hold); 
		arith(op, result, &hold); 
	}
}

/*	----------------------------------------------------------------------------
	Process integer exponent
	--------------------------------------------------------------------------*/

void level4(int *result)
{
	int hold; 

	level5(result); 
	if(*token == '^')
	{
		get_token(); 
		level4(&hold); 
		arith('^', result, &hold); 
	}
}

/*	----------------------------------------------------------------------------
	Is a unary + or -
	--------------------------------------------------------------------------*/

void level5(int *result)
{
	register char op; 

	op = 0; 
	if((token_type==DELIMITER) && *token=='+' || *token=='-')
	{
		op = *token; 
		get_token(); 
	}
	level6(result); 
	if(op)
		unary(op, result); 
}

/*	----------------------------------------------------------------------------
	Process parenthesized expression
	--------------------------------------------------------------------------*/

void level6(int *result)
{
	if((*token == '(') && (token_type == DELIMITER))
	{
		get_token(); 
		level2(result); 
		if(*token != ')')
			serror(1);
		get_token(); 
	}
	else
		primitive(result);
}

/*	----------------------------------------------------------------------------
	Find value of number or variable
	--------------------------------------------------------------------------*/

void primitive(int *result)
{
	switch(token_type)
	{
		case VARIABLE:
			*result = find_var(token);
			get_token(); 
			return; 
		case NUMBER:
			*result = atoi(token);
			get_token();
			return;
		default:
			serror(0);
	}
}

/*	----------------------------------------------------------------------------
	Perform the specified arithmetic
	--------------------------------------------------------------------------*/

void arith(char o, int *r, int *h)
{
	register int t, ex;

	switch(o)
	{
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
			if(*h==0)
			{
				*r = 1; 
				break; 
			}
			for(t=*h-1; t>0; --t)
				*r = (*r) * ex;
			break;			 
	}
}

/*	----------------------------------------------------------------------------
	Reverse the sign
	--------------------------------------------------------------------------*/

void unary(char o, int *r)
{
	if (o=='-')
		*r = -(*r);
}

/*	----------------------------------------------------------------------------
	Find the value of a variable
	--------------------------------------------------------------------------*/

int find_var(char *s)
{
	if(!isalpha(*s))
	{
//
		return 0;
	}
	return variables[toupper(*token)-'A'];
}


