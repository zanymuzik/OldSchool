program Zero_Kata_O_X;
{  A TIC-TAC-TOE playing Game.
   Uses the Concept of Game Tree.

   Programmers      :  Mohit Agarwal
                            &
                       Gaurav Jain.

   for Software Development Contest , " CYBERSPACE "
       of TRYST'98 . IIT - Delhi.

   For further Assistance please contact :      Mohit  @ 6493187
                                                Gaurav @ 2927834        }

uses crt,graph;

const nmax = 20;

type boardtype = -1..1;

var
   board                     :array[1..nmax,1..nmax] of boardtype;
   {  array to store the position of the board.
      1 Denotes a X , -1 Denotes a O and 0 denotes an empty space.}

   gd,gm,m,n,rad             :integer;
   choice                    :char;
   lookaheads                :integer;
   totalspace                :integer;
   intelligence              :integer;
   s                         :string;
   dummy3,dummy1,dummy2      :boolean;
procedure initialize; {   Sets the Board Empty for a fresh game}
var i,j   :integer;
begin
     rad:=400 div n;
     for i := 1 to n do
         for j := 1 to n do
             board[i,j]:=0;
end;


function max(a,b    :integer):integer;{       max of ((a)) and ((b))  }
begin
     if a>b then max:=a else max:=b;
end;


function min(a,b    :integer):integer;{       min of ((a)) and ((b))  }
begin
     if a<b then min:=a else min:=b;
end;


procedure beep;        { To Generate a sound for Events}
begin
        sound(800);delay(200);
        sound(1000);delay(200);
        sound(600);delay(200);
        nosound;
end;


function spacesleft:integer;
{   Calculate the spaces left on the board .
    Needed to calculate the dynamic lookaheads in the game.             }
var i,j   :integer;
    space :integer;
begin
     space:=0;
     for i:= 1 to n do
         for j:= 1 to n do
             if board[i,j]=0 then space:=space+1;
     spacesleft:=space;
end;



function needtoeval(i,j :integer):boolean;
{      Checks is there another piece in the adjacent squares to ((i,j))
       The game tree at that point ((i,j)) is made only if needtoeval(i,j)  }
var dummy       :boolean;
    a,b         :integer;

begin
     dummy:=false;
     for a:=max(i-1,1) to min(i+1,n) do { Check all valid points        }
     for b:=max(j-1,1) to min(j+1,n) do { around the point ((i,j))      }
     if board[a,b] <> 0 then dummy:=true;
     needtoeval:=dummy;
end;

function whogotit(a,b   :integer):boolean;forward;  { dummy declaration }

procedure putmove(x,y   :integer;  whosemove:boardtype);
{         Puts the piece of player(whosemove) on the position x,y       }

begin
     setlinestyle(solidln,0,thickwidth);

     board[x,y]:=whosemove;
     if whosemove =1 then dummy1:=whogotit(x,y)  {global variables.will be used later}
                     else dummy2:=whogotit(x,y);

     if whosemove = 1 then begin        { Make the Cross Graphically    }
                           setcolor(blue);
                           line(120+(y-1)*rad+2,(x-1)*rad+2,120+y*rad-2,x*rad-2);
                           line(120+(y-1)*rad+2,x*rad-2,120+y*rad-2,(x-1)*rad+2);
                           end;
     if whosemove= -1 then begin        { Make the Circle Graphically   }
                           setcolor(red);
                           circle(120+ y*rad -(rad div 2),x*rad-(rad div 2),rad div 2 -2);
                           floodfill(120+y*rad-(rad div 2), x*rad-(rad div 2),red);
                           end;
end;


procedure welcome;{     Generate Welcome Screen          }
begin
     setbkcolor(lightblue);
     setcolor(red);
     settextstyle(5,0,8);
     outtextxy(55,30,'TIC-TAC-TOE');
     settextstyle(5,0,4);
     outtextxy(330,135,'for TRYST''98');
     setcolor(yellow);
     settextstyle(6,0,3);
     outtextxy(60,250,'Developed By:');
     settextstyle(3,0,4);
     outtextxy(170,300,'Gaurav Jain   Mohit Agarwal');
     settextstyle(3,0,3);
     outtextxy(340,340,'II Year');
     outtextxy(185,370,'Electrical Engineering Department');
     outtextxy(170,400,'Indian Institute of Technology - Delhi');
     readkey;
end;



procedure setbody;
{   Initializes the Graphics , Get in the values of n & m from user,
    and get the intelligence level of the user which decides
    the lookaheads of the current position.                             }

var a,b   :integer;

begin
     gd:=detect;    gm:=0;
     initgraph(gd,gm,'');

     welcome;

     repeat            { Gets n                 }
           cleardevice;
           outtextxy(100,200,'Key in the value of n(3..20) =');
           a:=ord(readkey)-48;str(a,s);
           if (a<0) or (a>9) then s:='&%#@';
           outtextxy(450,200,s);
           b:=ord(readkey)-48;
           if b=-35 then n:=a
                    else n:=a*10+b;
           beep;
     until (n<=nmax) and (n>2);

     repeat          {   Gets m                 }
           cleardevice;
           outtextxy(100,200,'Key in the value of m(3..  ) =');
           str(n,s);outtextxy(382,200,s);
           a:=ord(readkey)-48;str(a,s);
           if (a<0) or (a>9) then s:='@*%&';
           outtextxy(450,200,s);
           b:=ord(readkey)-48;
           if b=-35 then m:=a
                    else m:=a*10+b;
           beep;
     until ((m>2) and (m<=n));

     cleardevice;  {  Gets the Intelligence level of the user ->intelligence}
     outtextxy(25,100,'Press the Number Key for the level you want to play:');
     outtextxy(100,150,'1.   Novice.   <- As they call it - PUPPY !!');
     outtextxy(100,190,'2.   Trainee.  <- Suggested for Most.');
     outtextxy(100,230,'3.   Moderate.<- A Test of Brain & Patience.');
     outtextxy(100,270,'4.   Expert.   <- Give it all you Have.');
     repeat
           intelligence:=ord(readkey)-48;
     until (intelligence>0) and (intelligence<5);

     beep;cleardevice;
end;


procedure showboard;{   Displays the board        }
var i     :integer;
begin
                    setcolor(yellow);
                    settextstyle(3,0,6);
                    outtextxy(25,50,'TIC');
                    outtextxy(15,110,'TAC');
                    outtextxy(15,170,'TOE');

                    setcolor(lightgray);
                    settextstyle(3,0,5);
                    outtextxy(20,230,'n=');
                    str(n,s);outtextxy(70,230,s);
                    outtextxy(5,265,'m=');
                    str(m,s);outtextxy(70,265,s);

                    setcolor(lightred);
                    settextstyle(6,0,1);
                    outtextxy(2,310,'Use Arrow Keys');
                    outtextxy(7,330,'and ENTER to');
                    outtextxy(12,350,'Select Move.');

                    setcolor(red);
                    settextstyle(3,0,3);
                    outtextxy(530,20,'Developed');
                    outtextxy(570,40,'By');

                    setcolor(lightblue);
                    outtextxy(545,90,'Gaurav');
                    outtextxy(560,115,'Jain');
                    outtextxy(575,147,'&');
                    outtextxy(555,180,'Mohit');
                    outtextxy(540,205,'Agarwal');

                    setcolor(green);
                    outtextxy(550,250,'II Year');
                    outtextxy(537,280,'Electrical');
                    outtextxy(523,300,'Engineering');
                    outtextxy(545,340,'IIT-Delhi.');

                    setcolor(cyan);
                    setlinestyle(solidln,0,thickwidth);
                    for i:= 1 to n+1 do
                    begin
                         line(120+(i-1)*rad,0,120 + (i-1)*rad,400);
                         line(120,(i-1)*rad,520,(i-1)*rad);
                    end;
end;

procedure getusermove;
var       x,y,r       :integer;
          a           :char;

procedure makecursor;
begin
     line(120+y*rad-4*r,x*rad-4*r,120+y*rad-3*r,x*rad-2*r);
     line(120+y*rad-4*r,x*rad-4*r,120+y*rad-2*r,x*rad-3*r);
     line(120+y*rad-3*r,x*rad-2*r,120+y*rad-2*r,x*rad-3*r);
     line(120+y*rad-(11*r)div 4,x*rad-(9*r)div 4,120+y*rad-(11*r)div 4+r,x*rad-(9*r)div 4+r);
     line(120+y*rad-(9*r)div 4,x*rad-(11*r)div 4,120+y*rad-(9*r)div 4+r,x*rad-(11*r)div 4+r);
     line(120+y*rad-(9*r)div 4+r,x*rad-(11*r)div 4+r,120+y*rad-(11*r)div 4+r,x*rad-(9*r)div 4+r);
end;

begin
        x:=1;y:=1;
        repeat
              a:=readkey;
              r:=rad div 8;
              setcolor(black);
              makecursor;
              if board[x,y]<>0 then putmove(x,y,board[x,y]);
              if (a=chr(72)) and (x>1) then x:=x-1;
              if (a=chr(80)) and (x<n) then x:=x+1;
              if (a=chr(75)) and (y>1) then y:=y-1;
              if (a=chr(77)) and (y<n) then y:=y+1;
              setcolor(green);
              makecursor;
              until ((a=chr(13)) and (board[x,y]=0)) or (a=chr(27));
        if a=chr(27)
        then begin
             clrscr;
             closegraph;
             writeln('You have chosen to EXIT .....');
             writeln('Have a nice day !!');
             halt;
             end;
        putmove(x,y,-1);
        beep;
end;

function whogotit(a,b   :integer):boolean;
{       Checks whether placing the point makes the player win or not?    }
var whose               :boardtype;
    i,count1,count2     :integer;
    dummy               :boolean;

begin
     whose:=board[a,b];
     dummy:=false;
{if ((totalspace-spacesleft) > (2*m-2))  {ie places occupied are more than 2m-2}
 {  then} begin
        count1:=0;count2:=0;i:=-n;
        repeat
        if (a+i>0) and (a+i<=n) and (b+i>0) and (b+i<=n)
        then if board[a+i,b+i]=whose then count1:=count1+1
                                     else count1:=0;
        if (a+i>0) and (a+i<=n) and (b-i>0) and (b-i<=n)
        then if board[a+i,b-i]=whose then count2:=count2+1
                                     else count2:=0;
        if (count1=m) or (count2=m) then dummy:=true;
        i:=i+1;
        until (dummy=true) or (i>n);

        if not(dummy) then
        begin
          count1:=0;count2:=0;i:=0;
          repeat
          i:=i+1;
          if board[i,b]=whose then count1:=count1+1
                              else count1:=0;
          if board[a,i]=whose then count2:=count2+1
                              else count2:=0;
          if (count1=m) or (count2=m) then dummy:=true;
          until (dummy=true) or (i=n);
        end;
        end;
     whogotit:=dummy;

end;

function speedcheck:boolean;  {sees to it that if there is any point where
                               compu wins thens it plays there immediately
                               and if there is a place where it should play
                               else it will lose then it plays there.}
var      i,j       :integer;
         dumb     :boolean;
begin
    dumb:=false;
    for i:=1 to n do
    for j:=1 to n do
    begin
    if not(dumb) and (board[i,j]=0) then
       begin
       board[i,j]:=1;
       if (whogotit(i,j)) then dumb:=true;
       board[i,j]:=0;
       if dumb then putmove(i,j,1);
       end;
    end;
    if not(dumb) then
       for i:=1 to n do
       for j:=1 to n do
       begin
         if not(dumb) and (board[i,j]=0) then
            begin
            board[i,j]:=-1;
            if not(dumb) and (whogotit(i,j)) then dumb:=true;
            board[i,j]:=0;
            if dumb then putmove(i,j,1);
            end;
       end;
    speedcheck:=dumb;
end;



procedure choosemove;
   { Procedure to choose the best possible move for the computer }
var
    xcord,ycord   :integer;
    counter       :longint;
    luck          :real;


function bestmove(who     :boardtype;   level   :integer ):real;
{       The function finds out the bestmove credit for ((who)) at ((level)) }
var nodeweight            :real;
    counti,countj,stems   :integer;
    i,j,bestofall         :integer;
    pointvalue            :array[1..nmax,1..nmax] of real;
    flag,dummy4,dummy5    :boolean;



function whosthebest(i,j :integer):integer;
{      Function to decide which point to go for if all have same nodeweights.
       The decision is based on the neighbourhood of the points in question.}
var dummy,a,b       :integer;
    presentboard    :boardtype;

begin
     dummy:=0;
     for a:=max(i-1,1) to min(i+1,n) do { Check all valid points        }
     for b:=max(j-1,1) to min(j+1,n) do { around the point ((i,j))      }
     begin
          if board[a,b]=-1 {neighbouring point is opponent's}

          then if ((a=i) or (b=j)) {opponents point at vert or hor position}
               then begin
                    dummy:=dummy+(16 div m);
                    {checks if 2 consecutive points are at vert or hor position}
                    if ((2*a-i)>0) and ((2*a-i)<=n) and ((2*b-j)>0) and ((2*b-j)<=n)
                        then if board[2*a-i,2*b-j]=-1 then dummy:=dummy+(20 div m)
                                                      else if board[2*a-i,2*b-j]=1
                                                           then dummy:=dummy-3;
                    end

               else begin          {opponents point at a diagonal}
                     dummy:=dummy+(20 div m);
                     {checks if 2 consecutive points are at diagonal}
                     if ((2*a-i)>0) and ((2*a-i)<=n) and ((2*b-j)>0) and ((2*b-j)<=n)
                        then if board[2*a-i,2*b-j]=-1 then dummy:=dummy+(24 div m)
                                                      else if board[2*a-i,2*b-j]=1
                                                           then dummy:=dummy-3;
                    end;



          if board[a,b]=1 then      { neighbouring point is computer's}

             if ((a=i) or (b=j))
             then begin         { computer's point at vert or hor position}
                  dummy:=dummy+3;
                  {checks if 2 consecutive points are at vert or hor position}
                  if ((2*a-i)>0) and ((2*a-i)<=n) and ((2*b-j)>0) and ((2*b-j)<=n)
                  then if board[2*a-i,2*b-j]=1 then dummy:=dummy +4{+3}
                                               else if board[2*a-i,2*b-j]=-1
                                                    then dummy:=dummy-2;
                  end

             else begin         { computer's point at the diagonal}
                  dummy:=dummy+4;
                  {checks if 2 consecutive computer's points are at diagonal}
                  if ((2*a-i)>0) and ((2*a-i)<=n) and ((2*b-j)>0) and ((2*b-j)<=n)
                  then if board[2*a-i,2*b-j]=1 then dummy:=dummy +4{+4}
                                               else if board[2*a-i,2*b-j]=-1
                                                    then dummy :=dummy-2;
                  end;
     end;

{     if (i=1) or (j=1) or (i=n) or (j=n) then dummy:=dummy-1;}

     {   Gives more credit if win or loss possible in the next move     }
     presentboard:=board[i,j];
     board[i,j]:=1;
     if whogotit(i,j) then dummy:=100+dummy;

     board[i,j]:=-1;
     if whogotit(i,j) then dummy:=100+dummy;

     board[i,j]:=presentboard;


     whosthebest:=dummy;
end;


{   ------------------------FUNCTION BESTMOVE STARTS ----------------}

begin
     {generate the color changing "Thinking" on the screen}
     if level > lookaheads-2 then
     begin
          setcolor((counter mod 15)+1);
          outtextxy(545,369,'Thinking');
          counter:=counter+1;
     end;
     dummy4:=true;
     for counti := 1 to n do
         for countj := 1 to n do
         begin
         if level=lookaheads then circle(25+countj*(50 div n),counti*(50 div n),(20 div n));

         if not((needtoeval(counti,countj)) and dummy4)
         then pointvalue[counti,countj]:=-1.1{not a likely point to be choosen}

         else if (board[counti,countj]=0)
              then begin       { position ((counti,countj)) is free }

                   board[counti,countj] := who;  {temporarily put ((who)) at that position }

{    give credit to this point as -1 or 1 if ((who)) got m pieces in line    }
                   if whogotit(counti,countj) then begin
                                                   pointvalue[counti,countj] := who;
                                                   {dummy4:=false;}
                                                   end
{ if this is not the last step of recursion then calc pointvalue by recursion }
                                              else if (level>0)
                              then  pointvalue[counti,countj]:=bestmove((-1)*who,level-1)


{        else mark this point as draw               }
                              else pointvalue[counti,countj]:=0;

                   board[counti,countj]:=0;{restore the board   }
                   end

           {if board(counti,countj) is already filled}
              else pointvalue[counti,countj]:=2;
         end;

     if who=1      { for computer}
     then begin    { calculate the bestmove as the max of all pointweights}
               nodeweight:=-2;bestofall:=0;
               for i := 1 to n do
                   for j :=  1 to n do
                       if (pointvalue[i,j]<>2) and (pointvalue[i,j]<>-1.1)
                                               and (pointvalue[i,j] > nodeweight)
                       then nodeweight:=pointvalue[i,j];
               if nodeweight=-2 then nodeweight:=0;

{ If at the top level and more than one nodes have the same weight,
  calculate the best node with the help of bestofall function.     }
               if level=lookaheads
               then for i := 1 to n do
                    for j := 1 to n do
                       if (pointvalue[i,j]=nodeweight)
                       and (whosthebest(i,j)>=bestofall)
                       then begin
                            xcord := i;
                            ycord := j;
                            bestofall:=whosthebest(i,j);
                            end;
          end

     else begin {opponents move, take the average if none of pointvalues=-1
                                             else take nodevalue as -1    }
           nodeweight:=0;stems:=0;flag:=true;dummy5:=true;
           for i := 1 to n do
              for j:= 1 to n do
                  if (pointvalue[i,j]<>2) and (pointvalue[i,j]<>-1.1) and flag
                  then begin
                       if pointvalue[i,j]=-1 then flag:=false;
                       if dummy5 or (pointvalue[i,j]<>1)
                       then begin
                                 nodeweight:=nodeweight+pointvalue[i,j];
                                 stems:=stems+1;
                            end;
{                       else nodeweight:=nodeweight + (1/(2*n));}
                       if pointvalue[i,j]=1 then dummy5:=false;
                       end;
            if nodeweight<>0 then nodeweight:=nodeweight/stems;
            if not(flag) then nodeweight:=-1;
            end;


       bestmove:=nodeweight;
end;
{   --------------------- END OF BESTMOVE ----------------------------}

begin
        counter:=0;

{   Calculate the lookaheads dynimically depending on spacesleft        }
        if spacesleft>=18 then lookaheads:=3
           else if spacesleft>=12 then lookaheads:=4
                else lookaheads:=5;

      {  if (m<=4) and (lookaheads=3) then lookaheads:=4; }

{    Changing the lookaheads depending on intelligence level of opponent }
        lookaheads:=lookaheads+intelligence-2;

{    Calculate the best move & it's co-od as ((xcord)) & ((ycord))       }
        luck:=bestmove(1,lookaheads);
        putmove(xcord,ycord,1);
        beep;

        setcolor(black);
        outtextxy(545,369,'Thinking');
end;
{   ----------------------END OF CHOOSEMOVE ------------------------------}

begin
     {$M 60000,0,60000}
     clrscr;
     dummy1:=false;dummy2:=false;
     totalspace:=n*n;
     repeat
     setbody;
     outtextxy(100,200,'Would You like to Play First <Y/N> ?');
     choice:=readkey;
     setbkcolor(black);
     cleardevice;
     initialize;
     showboard;
     if (choice<>'y') and (choice<>'Y') then putmove((n+1) div 2,(n+1)div 2,1);
     repeat
           getusermove; dummy3:=false;
           if not(dummy2) then dummy3:= speedcheck;
           if (not(dummy3) and not(dummy2)) and not(spacesleft =0) then choosemove;
     until (dummy1) or (dummy2) or (spacesleft=0);
     settextstyle(3,0,8);
     setcolor(red);
     if not(dummy1) and not(dummy2) and (spacesleft=0) then outtextxy(215,380,'DRAW');
     if dummy1 then outtextxy(55,380,'Computer Wins');
     if dummy2 then outtextxy(180,380,'You Win');
     readln;
     setcolor(yellow);
     setbkcolor(lightblue);
     cleardevice;
     settextstyle(3,0,3);
     outtextxy(100,200,'Would You like to Play Again <Y/N> ?');
     choice:=readkey;
     cleardevice;
     until (choice='n') or (choice='N')
end.

