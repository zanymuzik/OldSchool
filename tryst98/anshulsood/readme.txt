 ***********************************************************************

                                TIC TAC TOE
                                -----------

      Anshul Sood, IIT Delhi.
      anshulsood@cyberjunkie.com
      Ankit Jain, DIT.
      ankit@cyberjunkie.com
      Ph. 6514835,6894315

      Contact Add: B 3/23 Azad Apts.
                   Hauz Khas,
                   New Delhi 110016
      For TRYST'98 Programming Contest.
      January 1998.

 ***********************************************************************

    SYSTEM REQUIREMENTS :
    ---------------------

        For speed : Pentium 100Mhz or above.
        ( For Patience evaluation use a 386 or below )
        Mouse.
        VGA Color Monitor.
        OS : Dos.

    FILES :
    -------

        Tictacto.exe
        egavga.bgi
        readme.txt ( this file )

    LOADING INSTRUCTIONS :
    ----------------------

        Run Tictacto.exe

    ALGORITHM :
    -----------

    Dimensions of board = nnx X nny ( 1..20 X 1..20 )
                                { nnx & nny can be different. }
    No. of X/O in a straight line to win = m ( 1 .. max ( nnx,nny ) )
    Level of foresight = mm ( 1.. nnx * nny / 2 )
    Draw value ( Use to determine Attacking through Defensive game strategy )
        = dv ( 0.00 ( totally attacking ) to 1.00 ( totally defensive ) )


    ASSUMPTIONS :
    -------------

        1) The user puts his piece ( X ) at the winning position if a single
        move will make him WIN, else the probability of his putting his
        piece at any valid position is equal.

        2) In case the level of foresight does not give a desicive result
        then at the last ( deepest ) level the value returned is 0.5
        - assuming equal probability of winning and losing.
           (Assumption no. 2 is not applicable in EXPERT mode since the
           levels are deep enough to decide the result ( lose / win / draw ))


    Steps in brief :

        1. Initialize the board by taking settings as user input.
           Alternatively, load a game situation from the board.
        *** Start the game ***
        2. If user has to move ( place a X ) take the move from the user.
        3. If computer has to place its ( O ) then
                a) check all the places you can put a ( O ).
                b) check the probability ( with assumptions 1 , 2 as given
                   above ) at that position ( see below ** ).
                        ³
                        ÀÄÄÄÄÄ-> this is a recursive process and a GAME TREE
                                 is formed which is 'mm' levels deep.
                c) check all such positions and place its piece where
                   probability is maximum.
                     ( If two or more positions have equal probabilities of
                     winning then it places the move at the last position
                     checked.)
        4. Check whether any player has won or lost or the game is drawn,
           else continue playing.
        5. Goto step 2.

    ** Evaluation of Probabilites ( of the computer winning ).

    A 'level' consists of a move by the user as well as a move by the
    computer.

        1. If the move ( in any level of the GAME TREE ) is made by the
           computer then the probability value of the node is the maximum
           of the probabilities of the nodes one further level down.
           This is done as on its next turn, the computer will make only the
           best move.
        2. If the move ( in any level of the GAME TREE ) is made by the user
           then the probability value of the node is the average of the
           probabilities of the nodes one further level down. However, if
           the user immediately wins in the next move, then the probability
           is taken to be absolutely zero.

 Partial Game tree :
 -------------------

 ( Sample only )

ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

                        Computer chooses 0.571 path
                    ÚÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÁÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄ¿
    Average -->   0.571 0.2  0.43  0.34 0.4 0.55 0.3  0.5
                    ³    ³    ³    ³    ³    ³    ³    ³      <-- Computer's
                    ³    .    .    .    .    ³    ³    ³          move
                    ³    .    .    .    .    .    .    .
                    ³    .    .    .    .    .    .    .
   ÚÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÁÄÄÂÄÄÄÄÂÄÄÄÄ¿                            <-- User's
  0.3  0.5  0.3  0.2  0.8  0.9  1.0  <-- Maximum                  move
   .    .    .    .    .    .    ³
   .    .    .    .    .    .    ³
                                 ³                            <-- Computer's
                          ÚÄÄÄÄÂÄÁÄÄ¿                             move
                          W    L    D
                          o    o    r
                          n    s    a
                        (1.0)  t    w
                             (0.0)  n
                                  (0.5)

ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


 Brief description of Functions and Procedures used :
 ----------------------------------------------------

 GRAPHICAL ROUTINES :
 --------------------

        void myrgb( int a,int r,int g,int b)

                changes the RGB palette

        void setpal1()

                sets the color palette

        char ggray(char n)

                graphical aid

        void dnot(int x1,int y1,int x2,int y2)

                draws a nought.

        void dcross(int x1,int y1,int x2,int y2)

                draws a cross.

        void msg(char s1[],char s2[],int i)

                displays a message on the message bar and gets an input if
                required.

        void getmove(int *x,int *y)

                gets the move from the player and handles the initiation of
                the command buttons

        void putit(int x,int y,int k)

                put a nought or a cross on the board.

        void drawbrd()

                draws the TIC-TAC-TOE board.

        void button(int x1,int y1,int x2,int y2,int mode)

                draws a button

        void viewscreen()

                draws the viewscreen.

        void start()

                initialises the screen.

        void sett1()

                displays the board settings

        void sett2(short n)

                display the setting for first move.

        void sett3(short n)

                displays the level of play

        void slide1(float f)

                display the game strategy settings.

        void settings()

                Calls all above 'sett#' procedures.

        void playnew(char s[])

                initialises a New game.

 CALCULATION ROUTINES :
 ----------------------

        char *getno(char *s,double *n)

                gets a no. from a string in 'n' and *getno returns as the
                pointer to the rest of the string.

        int round(float n)

                rounds a float to a int

        float pow2(float x,int n)

                returns x**n

        void bez(float u,ptar pr,pnt op)

                returns in 'op' a point lying on the Bezier curve defined
                by 'pr'

 GAME ROUTINES :
 ---------------

        short win( char x,char y)

                determines if the player who played last at (x,y) position
                has WON or not

        short  draw()

                checks if the game is a draw or not.

        int npv()

                evaluates the no. of possible moves left.

        float evalprob(char mx,char my,char mover,char step)

                evaluates what would be the probability of the 'mover'
                winning if the 'mover' plays at mx,my position.

        void play()

                Lets GO..........

        int main()

                Does the rest...............

 ****************************************************************************
