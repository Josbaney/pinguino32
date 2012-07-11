/*
  _____  _                   _             
 |  __ \(_)                 (_)            
 | |__) |_ _ __   __ _ _   _ _ _ __   ___  
 |  ___/| | '_ \ / _` | | | | | '_ \ / _ \ 
 | |    | | | | | (_| | |_| | | | | | (_) |
 |_|    |_|_| |_|\__, |\__,_|_|_| |_|\___/ 
                  __/ |                    
                 |___/                     

   _____ _                          __    ___  
  / ____| |                        /_ |  / _ \ 
 | |    | |__   ___ ___ ___  __   __| | | | | |
 | |    | '_ \ / _ | __/ __| \ \ / /| | | | | |
 | |____| | | |  __|__ \__ \  \ V / | |_| |_| |
  \_____|_| |_|\___|___/___/   \_/  |_(_)\___/ 
                                               
                                               
*//**

	Adapted by:		Régis Blanchot (Feb. 2012)
	Adapted from:		"Jeux d'ECHECS sur PIC18" - C. Dupaty - Académie d'Aix-MArseille 03/2004
	Calculation Engine:	PROTEUS VSM TINY CHESS (http://www.multipower-fr.com/cao/prod01.htm) 
	Tested on:		PIC32 Pinguino / Linux
	Output:			sudo minicom -o -D /dev/ttyACM0
	Todo:			- graphical output 
					- Pinguino vs. Pinguino	
**/

#define YES   1
#define NO    0
#define OK    0
#define ERR   -1

// Portability types:
typedef unsigned long FLAG;

// System Types
typedef unsigned char COORD;
typedef COORD LOC[2];
typedef unsigned char PIECE;
typedef unsigned char BOARD[8][8];
typedef void (*FUNCPTR) (LOC, BOOL);
typedef unsigned char MASK[8];

// Codes for chess piece tokens
#define EMPTY   0
#define PAWN    1
#define ROOK    2
#define KNIGHT  3
#define BISHOP  4
#define QUEEN   5
#define KING    6
#define WHITE   0
#define BLACK   8

//Play Control.
#define WH_PAWN_BASEROW 1
#define BL_PAWN_BASEROW 6
#define MAX_INDEX 63
#define MIN_INDEX 0
#define MAX_COL   7
#define MAX_ROW   7
#define MIN_COL   0
#define MIN_ROW   0

// CPU Move Types.
#define NO_MOVE     -1
#define NORMAL      1
#define SAFE        2
#define CAPTURE     3
#define SAFECAPTURE 4
#define ESCAPE      4

// Global Variables
BOARD	board;
BOOL	kingcapture;
MASK	validmovemask;
MASK	capturemask;
MASK	currcapturemask;
MASK	currmovemask;
LOC		wh_king_pos;
LOC		bl_king_pos;
LOC		opp_king_pos;
BOOL	kingcapture;

u16		movecount;
u8		wh_base_cont;
u8		bl_base_cont;
u8		movetype;
u8		rate;
u8		piecerate;
u8		lastmove;

// Translate coords into 0-based index.
#define getindex(r,c)		(((r) << 3) + (c));     
// Translate index into coords.      
#define getcoord(r,c,i)		r = (i) >> 3;		c = (i) - ((r) << 3);
// Determine the type of piece.
#define piecetype(p)		(p & 0x07)
//Boolean - True if piece is opponents, false if not.
#define is_opp_piece(r,c,p)	((((board[r][c] & 0x08) >> 3) ^ ((p & 0x08) >> 3)) && (board[r][c]))
//Boolean - True if move is valid, false if not.
#define is_valid_move(r,c)	(validmovemask[r] & (1 << c))

// Play Control.
void twoplay();
void cpuplay();

// Piece Validation Functions. These functions set bits in our 
// board mask array indicating valid moves for the specified piece.
void val_empty  (LOC from, BOOL piececolour);
void val_pawn   (LOC from, BOOL piececolour);
void val_bishop (LOC from, BOOL piececolour);
void val_knight (LOC from, BOOL piececolour);
void val_rook   (LOC from, BOOL piececolour);
void val_queen  (LOC from, BOOL piececolour);
void val_king   (LOC from, BOOL piececolour);

FUNCPTR validate[7] = { val_empty, val_pawn, val_rook, val_knight,val_bishop,val_queen,val_king};

// Directional Validation functions.
void val_north     (LOC from,BOOL piececolour,BOOL depth);
void val_south     (LOC from,BOOL piececolour,BOOL depth);
void val_west      (LOC from,BOOL piececolour,BOOL depth);
void val_east      (LOC from,BOOL piececolour,BOOL depth);
void val_northwest (LOC from,BOOL piececolour,BOOL depth);
void val_northeast (LOC from,BOOL piececolour,BOOL depth);
void val_southwest (LOC from,BOOL piececolour,BOOL depth);
void val_southeast (LOC from,BOOL piececolour,BOOL depth);

//Utility.
void updatekingpos(LOC to, BOOL piececolour);
int  getbestpiecemove(LOC from);
BOOL test_singlemove (LOC from,LOC to,PIECE p);
int rate_move(PIECE piece,LOC to, u8 posrate);

//void draw_move(LOC from, LOC to,PIECE p);
void init_board ();
void draw_move (LOC from, LOC to,PIECE p);
void draw_chessboard(void);
BOOL lit_coup_joueur (LOC from, LOC to);

/**	----------------------------------------------------------------------------
	Carriage Return Line Feed
	--------------------------------------------------------------------------*/

void CRLF(void)
{
	CDC.printf("\r\n");
}

/**	----------------------------------------------------------------------------
	Initialization
	--------------------------------------------------------------------------*/

void setup()
{ 
	movecount   = 1;
	kingcapture = FALSE;
	movetype = NO_MOVE;      
	init_board();
	
	// wait for a key to start
	while (CDC.getKey() != '\r');

	// title - author - usage
	CRLF();CRLF();
	CDC.println("Pinguino Chess v1.0");
	CDC.println("2012 - Regis Blanchot");
	CDC.println("usage : e2e4 <RETURN>");
}
 
/**	----------------------------------------------------------------------------
	Control Function for a single player game
	--------------------------------------------------------------------------*/

void loop()
{
	LOC from, to, cpufrom,cputo;
	PIECE p;
	u8 i = 0, j = 0;
	u8 movefrom, bestfrom, moveto, bestto; 
	u8 illegal = FALSE;

	// User Move (White).
	if ((movecount+1)%2 == 0)
	{ 
		draw_chessboard();
		CDC.printf("Your move : ");

		if (!illegal);
		else
			illegal = FALSE;   

		// Get the move.
		while (!lit_coup_joueur(from, to));
		p = board[from[0]][from[1]];
		//getindex(to[0],to[1]);

		// Get valid moves for given piece.
		validate[piecetype(p)] (from,WHITE);

		// Next, Verify that we can make the move and
		// deal with the King/Check logic.          
		if (is_valid_move(to[0],to[1]) && test_singlemove(from,to,board[from[0]][from[1]]))
		{ 
			draw_move(from,to,p);
			CRLF();
			CDC.printf("You play : ");
			CDC.write(from[1]+'a');
			CDC.write(from[0]+'1');
			CDC.printf(" -> ");
			CDC.write(to[1]+'a');
			CDC.write(to[0]+'1');
			CRLF();
			movecount++;
		}
		else
		{ 
			CRLF();
			CDC.printf ("Invalid Move !"); CRLF();
			illegal = TRUE;
		}

		// Finally, Clear our masks and reset bools.
		for (i = 0; i < 8;++i)
		{
			// Clear our mask.
			validmovemask[i] = 0;
			capturemask[i] = 0;
		}
	}

	// CPU move.
	else if ((movecount+1)%2 == 1)
	{
		bestfrom = bestto = NO_MOVE;
		rate = piecerate = 0;
		CDC.printf ("I think ");

		// For every black piece ... 
		for (i = 0; i < 8;++i)
		{
			for (j = 0;j < 8;++j)
			{
				if (board[i][j] & 0x08)
				{
					// Get possible moves.
					cpufrom[0] = i;
					cpufrom[1] = j;
					p = board[i][j];
					validate[piecetype(p)](cpufrom,BLACK);

					// Get best move for that piece. 
					moveto   = getbestpiecemove(cpufrom);
					movefrom = getindex(cpufrom[0],cpufrom[1]); 

					// Prevent consistent moving of the same piece.
					if (((board[cpufrom[0]][cpufrom[1]]&0x07) == lastmove) && (movetype < 3))
						piecerate -= 3;
	
					if (piecerate > rate)
					{
						rate     = piecerate;
						bestfrom = movefrom;
						bestto   = moveto;
					}

					moveto = movefrom = -1;
				}

				movetype = NO_MOVE;  
			}  
		}

		if (rate != 0) 
		{
			// We can move.
			getcoord (cpufrom[0],cpufrom[1],bestfrom);   
			getcoord (cputo[0],cputo[1],bestto);   
			p = board[(cpufrom[0])][(cpufrom[1])];
			draw_move(cpufrom,cputo,p);
			lastmove = (((p&0x07) != PAWN) && ((p&0x07) != KING)) ? p&0x07 : 0;
			CRLF();
			CDC.printf("I play ");
			CDC.write(cpufrom[1]+'a');
			CDC.write(cpufrom[0]+'1');
			CDC.printf(" -> ");
			CDC.write(cputo[1]+'a');
			CDC.write(cputo[0]+'1');
			CRLF();
			movecount++;
		}
		else
		{
			// Checkmate.
			CDC.println("Checkmate - you win !");
			movecount++;   
			//break;
		} 
	}

	else
	{
		// Stalemate.
		CDC.println("Stalemate - no winner.");
		//break;
	}
}

/**	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void init_board () 
{
	COORD i, j;

	board[7][0] = board[7][7] = BLACK|ROOK;
	board[7][1] = board[7][6] = BLACK|KNIGHT;
	board[7][2] = board[7][5] = BLACK|BISHOP;
	board[7][3] = BLACK|QUEEN;
	board[7][4] = BLACK|KING;

	board[0][0] = board[0][7] = WHITE|ROOK;
	board[0][1] = board[0][6] = WHITE|KNIGHT;
	board[0][2] = board[0][5] = WHITE|BISHOP;
	board[0][3] = WHITE|QUEEN;
	board[0][4] = WHITE|KING;

	for (i=2; i<6; ++i)
	{
		for (j=0; j<8; ++j)
			board[i][j] = 0;
	}

	for (i=0; i<8; ++i)
	{
		board[6][i] = BLACK|PAWN;
		board[1][i] = WHITE|PAWN;
	}

	// Initialise our records of the kings position
	wh_king_pos[0] = 0;
	wh_king_pos[1] = 4;
	bl_king_pos[0] = 7;
	bl_king_pos[1] = 4;  

	// Base rows fully occupied.
	wh_base_cont = bl_base_cont = 0xFF;
}

/**	----------------------------------------------------------------------------
	Draw Chess Board
	--------------------------------------------------------------------------*/

void draw_chessboard(void)
{
	char i,j;

	CRLF();
	CDC.printf("  a b c d e f g h "); CRLF();
	CDC.printf(" +-+-+-+-+-+-+-+-+"); CRLF();
	for (i=7;i>=0;i--)
	{
		CDC.printf(" |");
		for(j=0;j<8;j++)
		{
			switch (board[i][j])
			{
				case 0:				CDC.printf(" "); break;
				case BLACK|PAWN:	CDC.printf("p"); break;
				case WHITE|PAWN:	CDC.printf("P"); break;
				case BLACK|ROOK:	CDC.printf("r"); break;
				case WHITE|ROOK:	CDC.printf("R"); break;
				case BLACK|KNIGHT:	CDC.printf("n"); break;
				case WHITE|KNIGHT:	CDC.printf("N"); break;
				case BLACK|BISHOP:	CDC.printf("b"); break;
				case WHITE|BISHOP:	CDC.printf("B"); break;
				case BLACK|QUEEN:	CDC.printf("q"); break;
				case WHITE|QUEEN:	CDC.printf("Q"); break;
				case BLACK|KING:	CDC.printf("k"); break;
				case WHITE|KING:	CDC.printf("K"); break;
				default:			CDC.printf(" "); break;
			}
			CDC.printf("|");
		}
		CDC.printf(" %d", i+1); CRLF();
		CDC.printf(" +-+-+-+-+-+-+-+-+"); CRLF();
	}
	CDC.printf("  a b c d e f g h"); CRLF();
	CRLF();
	CDC.printf("K,k for king - Q,q for queen - R,r for rook"); CRLF();
	CDC.printf("B,b for bishop - N,n for knight - P,p for pawn"); CRLF();
	CRLF();
}

/**	----------------------------------------------------------------------------
	Read Player Move on USB CDC port
	Return True
	--------------------------------------------------------------------------*/

BOOL lit_coup_joueur (LOC from, LOC to)
{ 
	u8 key, fdelay, fstate=0;
   	PIECE p;
	char* chaine;
   
	chaine = CDC.getString(); // recupere le coup jour de la forme e2e4* (* termine la chaine)

	// Store the 'from' position
	from[1] = chaine[0]-'a';
	from[0] = chaine[1]-'1';

	// Check moving correct piece.

	p = board[from[0]][from[1]];
	if (p == EMPTY || p & BLACK)
	{
		CRLF();
		CDC.printf("You play the black !");
		CRLF();
		return FALSE;
	}

	to[1] = chaine[2]-'a';
	to[0] = chaine[3]-'1'; 

	return from[0] != to[0] || from[1] != to[1];
}

/**	----------------------------------------------------------------------------
	Test all the valid moves for the specified piec
	Returns the index of the best move.
	--------------------------------------------------------------------------*/

int getbestpiecemove(LOC from)
{
	u8 chaine[6];
   u8 i,j,k;
   u8 tmp;
   LOC to;
   u8 move,bestmove,curr_pos_rate;
   bestmove = NO_MOVE;
   piecerate = tmp = 0;

   // validmovemask and capturemask at this point
   // refer to our piece. That is, pieces we can take
   // and moves we can make with the current piece.
   // We need to take a copy and then clear these masks
   // prior to testing for opponents positions/captures.
   for (i = 0; i < 8;++i)
    { currmovemask[i]    = validmovemask[i];
      currcapturemask[i] = capturemask[i];
      validmovemask[i] = 0;
      capturemask[i] = 0;
    }

   for (i = 0; i < 8; ++i)
    { for (j = 0; j < 8; ++j)
       { if (currmovemask[i] & 0x01)
          { // Test a Valid Move.
            to[0] = i;
            to[1] = j; 
            if (test_singlemove(from,to,board[from[0]][from[1]]))
             { // At this point the validmovemask and capturemask
               // refer to our opponents pieces. Of interest to us is
               // the capturemask as it tells us if we are moving into danger.
               move = getindex(to[0],to[1]);
               movetype = NORMAL;  
               if ((validmovemask[from[0]] >> from[1]) & 1)            
                { // Piece can be taken - add some weight to escape. 
                  tmp = (board[from[0]][from[1]] & 0x07)/2;
                }
   
               if((!((capturemask[i] >> j) & 1)) && ((currcapturemask[i] >> j) & 1))
                { // Best Case Scenario - We can Capture a piece and cannot be
                  // captured in turn.
                  movetype = SAFECAPTURE;
                }
               else if ((currcapturemask[i] >> j) & 1)
                { // Can Capture a piece.
                  movetype = CAPTURE;
                }
               else if (!((capturemask[i] >> j) & 1))
                { // Safe move.
                  movetype = SAFE;
                }  
                              

               // Rate the position of the move against our designates ideal pos.(3,3).
               curr_pos_rate  = (to[0] > 3)? to[0]-3 : 3-to[0];
               k  = (to[1] > 3)? to[1]-3 : 3-to[1];
               curr_pos_rate += k;      
               
               // Rate the move.               
               tmp += rate_move((board[from[0]][from[1]]),to,curr_pos_rate);

               if (tmp > piecerate)
                { // A better move that any so far with this piece.
                  piecerate = tmp;
                  bestmove = move;
                }   
               tmp = 0;  
             }
            for (k = 0; k < 8; ++k)
             { // Reset Masks.
               validmovemask[k] = 0;
               capturemask[k]   = 0;
             }
          }
         currmovemask[i] = currmovemask[i] >> 1;
       }
    }
  if (bestmove != NO_MOVE) 
		{
// possibilité d'afficher les recherches du meilleur coup du moteur d'echecs
/*			CDC.printf("Meilleur coup : ");
			putstsci(btoa(chaine,bestmove));
			CDC.printf(",de : ");
			CDC.write(from[0]+'0');
			CDC.write(from[1]+'0');
			CDC.printf(",taux : ");
			putstsci(btoa(chaine,piecerate));
			CDC.printf(",type de mouvement : ");
			putstsci(btoa(chaine,movetype));
			CRLF();			
*/
// sinon des .
			CDC.write('.');
		}
 return bestmove;
 }

/**	----------------------------------------------------------------------------
	When a piece can move into a position we check whether
	that violates rules such as check, castling.
	Return true if move ok, false otherwise.
	--------------------------------------------------------------------------*/

BOOL test_singlemove (LOC from,LOC to,PIECE p)
{
	int i = 0,j = 0; 
   LOC opp_pos;
   PIECE opp_piece,tmpdest;

   // If a king has moved update our internal record.
   if ((p & 0x07) == KING) updatekingpos(to,(p & 0x08));

   // Take a copy of the destination contents in case our
   // move is invalid.
   tmpdest = board[to[0]][to[1]];

   // Update our internal matrix with the move.
   board[from[0]][from[1]] = EMPTY;
   board[to[0]][to[1]] = p;
    
           
   // Test our opponents pieces to see if any can capture our king.
   kingcapture = FALSE;
   i = j = 0;
   while ((i < 8) && (!kingcapture))
    { // scan rows.
      while ((j < 8) && (!kingcapture))
       { // scan columns.
         if (is_opp_piece(i,j,(p&0x08)))
          { // Opponents Piece - Get valid moves.
            opp_pos[0] = i, opp_pos[1] = j,opp_piece = board[i][j];
            validate[piecetype(opp_piece)] (opp_pos,(opp_piece & 0x08));
          }
         j++;
        }
       j = 0;
       i++;
    }
   // Finished Testing - Restore our internals. 
   board[to[0]][to[1]] = tmpdest;
   board[from[0]][from[1]] = p;
   if ((p & 0x07) == KING) updatekingpos(from,(p & 0x08));

   return (kingcapture) ? FALSE : TRUE;
 }

/**	----------------------------------------------------------------------------
	Calculate the relative worth of making a move.
	Based on the type of move, piece being moved,
	position moved to and subsequent danger.
	posrate is a level between 0-8  indicating closeness to
	the center of the board. Some manual 'fudging' is
	involved here to improve performance.
	--------------------------------------------------------------------------*/

int rate_move(PIECE piece, LOC to,u8 posrate)
{
	u8 tmp, value, rating;
   
   // We dont want our king charging down the board...
   value = ((piece & 0x07)== KING) ? 0 : (piece&0x07);    

   switch (movetype)
    { case NORMAL     : // Move low value pieces if possible.
                        rating = (6-value) + posrate/2;  
                        break;
      case SAFE       : // Manouver better pieces to better positions.
                        rating = (value)+((8-posrate));      
                        break;
      case SAFECAPTURE: // Capture safely if possible.
                        rating = 14;                            
                        break;
      case CAPTURE    : // Take an opponents piece here if it is better than our own.
                        // Values are arbitrary.
                        tmp = (board[to[0]][to[1]]&0x07)-(value);
                        rating = (tmp < 249) ? 12 : 4;
                        break; 
      default         : rating = 0;
                        break;
    }
   return rating;
 }

/**	----------------------------------------------------------------------------
	Update the panel with a move.
	--------------------------------------------------------------------------*/

void draw_move (LOC from, LOC to,PIECE p)
{
	u8 *basemask,baserow;
   basemask = (p & 0x08) ? &bl_base_cont : &wh_base_cont;
   baserow = (p & 0x08) ? 7 : 0;

   if (piecetype(p) == KING) 
    { // King Move.
      updatekingpos(to,(p&0x08));
      board[from[0]][from[1]] = EMPTY;
      board[to[0]][to[1]] = p;
      if (((to[1] - from[1]) != 1) && ((from[1] - to[1]) != 1))
       { // Castle Move.
         if (((*basemask) & 0x1F)== 0x11)
          { 
//			draw_chessboard();
            board[to[0]][0] = EMPTY;
            board[to[0]][3] = ((p&0x08)|ROOK);
            CDC.printf("Queenside Castle\n");
          }
        else if (((*basemask) & 0xF0) == 0x90)
          { 
//			draw_chessboard();
            board[to[0]][7] = EMPTY;
            board[to[0]][5] = ((p&0x08)|ROOK);
            CDC.printf("Kingside Castle\n");
          }
       }
    }
   else if (((p == 0x09) && (to[0] == 0)) || ((p == 1) && (to[0] == 7)))
    {// Queening a pawn.
     board[from[0]][from[1]] = EMPTY;
     board[to[0]][to[1]] = QUEEN |(p&0x08);
    }       
   else
    { // Normal move.

      if (board[to[0]][to[1]] != EMPTY);

      board[from[0]][from[1]] = EMPTY;
      board[to[0]][to[1]] = p;
    }

   if ((from[0] == baserow) && ((*basemask) & (1 << from[1])))
    { // Reflect any changes in the base row. After a Castle this
      // becomes superflous.
      (*basemask) &= ~(1 << from[1]);
    }
 }

/**	----------------------------------------------------------------------------
	Update our record of the kings position.
	--------------------------------------------------------------------------*/

void updatekingpos(LOC to, BOOL piececolour)
 { if (!piececolour)
    { wh_king_pos[0] = to[0];
      wh_king_pos[1] = to[1];
    }
   else
    { bl_king_pos[0] = to[0];
      bl_king_pos[1] = to[1];
    }
 }

/**	----------------------------------------------------------------------------
	Piece Validation Functions
	--------------------------------------------------------------------------*/

void val_empty(LOC from,BOOL piececolour)
 {// Do nothing...
  from = from;
  piececolour = piececolour;
 }


void val_pawn(LOC from,BOOL piececolour)
// Find all Valid moves for a pawn.
 { COORD row = from[0],col = from[1];
   BOOL piecefound = FALSE;
 
  // Get the opponents king position.
  if (piececolour == WHITE)
   { opp_king_pos[0] = bl_king_pos[0];
     opp_king_pos[1] = bl_king_pos[1];
   }
  else
   { opp_king_pos[0] = wh_king_pos[0];
     opp_king_pos[1] = wh_king_pos[1];
   }
   
   // Increment the row towards the opponents pieces. 
   if (piececolour == WHITE)
      row++;
   else
      row--;

   // We can move into an empty square directly in front of us.
   if (board[row][col] == EMPTY)
    { validmovemask[row] |= (1<<col);
    }
   else
    piecefound = TRUE;


   // We can diagonally take an opponents piece.
   if ((is_opp_piece(row,col-1,piececolour)) && (col > MIN_COL))
     { //left
        validmovemask[row] |= (1<<(col - 1));
        capturemask[row]   |= (1<<(col - 1));
        if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
     }

   if ((is_opp_piece(row,col+1,piececolour)) && (col < MAX_COL))
     { //right
        validmovemask[row] |= (1<<(col + 1));
        capturemask[row]   |= (1<<(col + 1));
        if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
     }

   // If a pawn is on it's base row it can move two squares.
   if ((piececolour == BLACK  && from[0] == BL_PAWN_BASEROW) || (piececolour == WHITE && from[0] == WH_PAWN_BASEROW))
     {  if (piececolour == WHITE)
           row++;
        else
           row--;
        if ((board[row][col] == EMPTY) && (piecefound ==FALSE))
         { validmovemask[row] |= (1<<col);
         }
     }

 }

void val_bishop(LOC from,BOOL piececolour)
// Find all valid moves for a bishop. We look at
// all 4 directions and travel until either the 
// edge of the board or until a piece is encountered.
 { 
   // Get the opponents king position.
   if (piececolour == WHITE)
    { opp_king_pos[0] = bl_king_pos[0];
      opp_king_pos[1] = bl_king_pos[1];
    }
   else
    { opp_king_pos[0] = wh_king_pos[0];
      opp_king_pos[1] = wh_king_pos[1];
    }

   // Check Valid Moves.
   val_northeast (from,piececolour,-1);
   val_northwest (from,piececolour,-1);
   val_southeast (from,piececolour,-1);
   val_southwest (from,piececolour,-1);
 }

void val_knight(LOC from,BOOL piececolour)
// Find all valid moves for a knight.We use a mask unsigned char
// to flag available rows and columns.
//  |    0    |     1    |    2    |    3     |     4    |     5    |      6    |     7     |
//  | +1r_up  |  +2r_up  | +1r_dwn |  +2r_dwn | +1col_lft| +2col_lft| +1col_rgt | +2col_rgt |
 { u8 mask = 0,i = 0;
   COORD row = 0,col = 0;

   // Set up row and column offsets for the various knight moves. All moves are initialised to zero.
   int move[] = {0, 2, 1, 0, 2, -1, 0, 1, 2, 0, 1, -2, 0, -1, 2, 0, -1, -2, 0, -2, -1, 0, -2, 1};
 
   // Get the opponents king position.
   if (piececolour == WHITE)
    { opp_king_pos[0] = bl_king_pos[0];
      opp_king_pos[1] = bl_king_pos[1];
    }
   else
    { opp_king_pos[0] = wh_king_pos[0];
      opp_king_pos[1] = wh_king_pos[1];
    }

   // Set Bits to indicate how many rows we can move up or down.
   switch (from[0])
    { case 0 : mask |=  0x03;   break; // Two up  - None down.
      case 1 : mask |=  0x07;   break; // Two up  - One down.
      case 6 : mask |=  0x0D;   break; // One up  - Two down.
      case 7 : mask |=  0x0C;   break; // None up - Two down.
      case 2 :
      case 3 :
      case 4 :
      case 5 : mask |=  0x0F;   break; // Two up  - Two down.
    }

   // Set Bits to indicate how many columns we can move left or right.
   switch (from[1])
    { case 0 : mask |=  0xC0;   break; // None left - Two right.
      case 1 : mask |=  0xD0;   break; // One left  - Two right.
      case 6 : mask |=  0x70;   break; // Two left  - One right.
      case 7 : mask |=  0x30;   break; // Two left  - None right.
      case 2 :
      case 3 :
      case 4 :
      case 5 : mask |=  0xF0;   break; // Two left  - Two right.
    }

   // Define Boolean tests for each possible knight move.
   #define up2_rgt1  ((mask & 0x40) && (mask & 0x02))
   #define up2_lft1  ((mask & 0x10) && (mask & 0x02))
   #define up1_rgt2  ((mask & 0x80) && (mask & 0x01))
   #define up1_lft2  ((mask & 0x20) && (mask & 0x01))
   #define dwn1_rgt2 ((mask & 0x80) && (mask & 0x04))
   #define dwn1_lft2 ((mask & 0x20) && (mask & 0x04))
   #define dwn2_lft1 ((mask & 0x10) && (mask & 0x08))
   #define dwn2_rgt1 ((mask & 0x40) && (mask & 0x08))

   // Set Valid moves in our array.  
   move[0]  = up2_rgt1;
   move[3]  = up2_lft1;
   move[6]  = up1_rgt2;
   move[9]  = up1_lft2;
   move[12] = dwn1_rgt2;
   move[15] = dwn1_lft2;
   move[18] = dwn2_lft1;
   move[21] = dwn2_rgt1;
  
   // Deal with all the possibles.
   for (i = 0; i <= 21; i += 3)
    { if (move[i])
       { // Valid Move.
         row = (from[0] + move[i+1]);
         col = (from[1] + move[i+2]);
         if (board[row][col] == EMPTY)
          { // Empty Square.
            validmovemask[row] |= (1<<col);
          }
         else if (is_opp_piece(row,col,piececolour))
          { // Opponents Piece.
            validmovemask[row] |= (1<<col);
            capturemask[row]   |= (1<<col);
            if (capturemask[opp_king_pos[0]] & (1 << opp_king_pos[1])) kingcapture = TRUE;
          }
       }
    }
  }

void val_rook(LOC from,BOOL piececolour)
// Get all valid moves for a rook. We look
// at all 4 possible directions and extend until 
// a piece is encountered. 
 { // Get the opponents king position.
   if (piececolour == WHITE)
    { opp_king_pos[0] = bl_king_pos[0];
      opp_king_pos[1] = bl_king_pos[1];
    }
   else
    { opp_king_pos[0] = wh_king_pos[0];
      opp_king_pos[1] = wh_king_pos[1];
    }

   // Get all valid Moves.
   val_north (from,piececolour,-1);
   val_south (from,piececolour,-1);
   val_east  (from,piececolour,-1);
   val_west  (from,piececolour,-1);
 }

void val_queen(LOC from,BOOL piececolour)
// Calculate all valid moves for a queen.
// The Queen is in effect a rook and a bishop
// combined so all that is necessary here is to
// call all the directional validation functions.
 {
   // Get the opponents king position.
   if (piececolour == WHITE)
    { opp_king_pos[0] = bl_king_pos[0];
      opp_king_pos[1] = bl_king_pos[1];
    }
   else
    { opp_king_pos[0] = wh_king_pos[0];
      opp_king_pos[1] = wh_king_pos[1];
    }

   // Get all Valid Moves.
   val_north      (from,piececolour,-1);
   val_south      (from,piececolour,-1);
   val_east       (from,piececolour,-1);
   val_west       (from,piececolour,-1);
   val_northeast  (from,piececolour,-1);
   val_northwest  (from,piececolour,-1);
   val_southeast  (from,piececolour,-1);
   val_southwest  (from,piececolour,-1);
 }

void val_king(LOC from,BOOL piececolour)
// Calculate the possible valid moves for a King.
 { u8 tmp,row;
   
   // Get the opponents king position.
   if (piececolour == WHITE)
    { opp_king_pos[0] = bl_king_pos[0];
      opp_king_pos[1] = bl_king_pos[1];
    }
   else
    { opp_king_pos[0] = wh_king_pos[0];
      opp_king_pos[1] = wh_king_pos[1];
    }
   
   // King can move in any direction but
   // only by 1 square. 
   val_north      (from,piececolour,1);
   val_south      (from,piececolour,1);
   val_east       (from,piececolour,1);
   val_west       (from,piececolour,1);
   val_northeast  (from,piececolour,1);
   val_northwest  (from,piececolour,1);
   val_southeast  (from,piececolour,1);
   val_southwest  (from,piececolour,1);

   // King Castle.
   if (piececolour & 0x08) 
    { tmp = bl_base_cont;
      row = MAX_ROW;
    }
   else
    { tmp = wh_base_cont;
      row = MIN_ROW;
    }

   if ((tmp & 0x1F)== 0x11)
    { // Can Castle QueenSide.
      validmovemask[row] |= 0x04;
    }   

   if ((tmp & 0xF0)==0x90) 
    {// Can Castle KingSide.
      validmovemask[row] |= 0x40;
    }
 }

/**	----------------------------------------------------------------------------
	Directional Validation Functions
	--------------------------------------------------------------------------*/

void val_north (LOC from,BOOL piececolour,BOOL depth)
// Validate Squares directly above the current position.
 { COORD row = from[0],col = from[1];
   BOOL piecefound = FALSE;
   while ((row++ < MAX_ROW) && (!piecefound) && (depth--))
    { if (board[row][col] == EMPTY)
       { // Empty Square.
         validmovemask[row] |= (1<<col);
       }
      else if (is_opp_piece(row,col,piececolour))
       { // Opponents Piece.
         validmovemask[row] |= (1<<col);
         capturemask[row]   |= (1<<col);
         if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
         piecefound = TRUE;
       }
      else
       { //Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_south (LOC from,BOOL piececolour,BOOL depth)
 { // Validate directly down from the current location.
   char row = from[0], col = from[1];
   BOOL piecefound = FALSE;
   while ((row-- > MIN_ROW) && (!piecefound) && (depth--))
    { if (board[row][col] == EMPTY)
       { // Empty Square.
         validmovemask[row] |= (1<<col);
       }
      else if (is_opp_piece(row,col,piececolour))
       { // Opponents Piece.
         validmovemask[row] |= (1<<col);
         capturemask[row]   |= (1<<col);
         if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
         piecefound = TRUE;
       }
      else
       { //Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_east (LOC from,BOOL piececolour,BOOL depth)
 { // Validate directly to the right of the current location.
   COORD row = from[0],col = from[1];
   BOOL piecefound = FALSE;
   while ((col++ < MAX_COL) && (!piecefound) && (depth--))
    { if (board[row][col] == EMPTY)
       { // Empty Square.
         validmovemask[row] |= (1<<col);
       }
      else if (is_opp_piece(row,col,piececolour))
       { // Opponents Piece.
         validmovemask[row] |= (1<<col);
         capturemask[row]   |= (1<<col);
         if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
         piecefound = TRUE;
       }
      else
       { //Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_west (LOC from,BOOL piececolour,BOOL depth)
 { // Validate directly to the left of the current location.
   char row = from[0],col = from[1];
   BOOL piecefound = FALSE;
   while ((col-- > MIN_COL) && (!piecefound) && (depth--))
    { if (board[row][col] == EMPTY)
       { // Empty Square.
         validmovemask[row] |= (1<<col);
       }
      else if (is_opp_piece(row,col,piececolour))
       { // Opponents Piece.
         validmovemask[row] |= (1<<col);
         capturemask[row]   |= (1<<col);
         if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
         piecefound = TRUE;
       }
      else
       { //Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_northwest (LOC from,BOOL piececolour,BOOL depth)
 { // Validate diagonally left and up from the current location.
   // This corresponds to an index increment of 7.
   COORD row = from[0], col = from[1];
   BOOL piecefound = FALSE;
   while ((col-- > MIN_COL) && (row++ < MAX_ROW) && (!piecefound) &&  (depth--))
    { // We haven't found a piece, are still in scope and within search depth.
      if (board[row][col] == EMPTY)
       {// Empty Square.
        validmovemask[row] |= (1<<col);
       }
      else if ((board[row][col] & 0x08) ^ piececolour)
       {// Opponents Piece.
        validmovemask[row] |= (1<<col);
        capturemask[row]   |= (1<<col);
        if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
        piecefound = TRUE;
       }
      else
       {// Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_northeast(LOC from,BOOL piececolour,BOOL depth)
 { // Validate diagonally right and up from the current location.
   // This corresponds to an index increment of 9;
   COORD row = from[0], col = from[1];
   BOOL piecefound = FALSE;
   while ((col++ < MAX_COL) && (row++ < MAX_ROW) && (!piecefound) && (depth--))
    { // We haven't found a piece, are still in scope and within search depth.
      if (board[row][col] == EMPTY)
       {// Empty Square.
        validmovemask[row] |= (1<<col);
       }
      else if ((board[row][col] & 0x08) ^ piececolour)
       {// Opponents Piece.
        validmovemask[row] |= (1<<col);
        capturemask[row]   |= (1<<col);
        if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
        piecefound = TRUE;
       }
      else
       {// Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_southeast (LOC from,BOOL piececolour,BOOL depth)
 { // Validate diagonally right and down from the current location.
   // This translates as an index decrement of 7.
   COORD row = from[0], col = from[1];
   BOOL piecefound = FALSE;
   while ((col++ < MAX_COL) && (row-- > MIN_ROW) && (!piecefound) && (depth--))
    { // We haven't found a piece, are still in scope and within search depth.
      if (board[row][col] == EMPTY)
       {// Empty Square.
        validmovemask[row] |= (1<<col);
       }
      else if ((board[row][col] & 0x08) ^ piececolour)
       {// Opponents Piece.
        validmovemask[row] |= (1<<col);
        capturemask[row]   |= (1<<col);
        if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
        piecefound = TRUE;
       }
      else
       {// Our Piece.
         piecefound = TRUE;
       }
    }
 }

void val_southwest(LOC from,BOOL piececolour,BOOL depth)
 {// Validate Left and Down from the current location.
   // This corresponds to an index subtraction of 9.
   COORD row = from[0], col = from[1];
   BOOL piecefound = FALSE;
   while ((col-- > MIN_COL) && (row-- > MIN_ROW) && (!piecefound) && (depth--))
    {  // We haven't found a piece, are still in scope and within search depth.
      if (board[row][col] == EMPTY)
       {// Empty Square.
        validmovemask[row] |= (1<<col);
       }
      else if ((board[row][col] & 0x08) ^ piececolour)
       {// Opponents Piece.
        validmovemask[row] |= (1<<col);
        capturemask[row]   |= (1<<col);
        if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
        piecefound = TRUE;
       }
      else
       {// Our Piece.
         piecefound = TRUE;
       }
    }
 }
