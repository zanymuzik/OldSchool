program tictactoe;
{Program to play the game of tic-tac-toe.
 By AMITABHA BANERJEE, Copyright reserved.

 Designed for TRYST-1998.

 Refer to the file ALGO.TXT for the algorithm
 Steps of the algorithm hae been correlated in the program.
 For furthur details refer to README.
 }
uses graph,crt;{Uses the GRAPH.TPU file}
type
   rang1=0..2;
   rang2=0..20;
   rang3=0..250;
var
   cho:rang1;
   c1,c2,c3:rang2;
   arra:array[1..20,1..20] of rang1;
   compmove:rang3;
   n,m,gs,csc,ysc,gss:rang2;
   aadd:0..50;
   wid:0..100;
   gm,gd:integer;
   che:boolean;
   stri:string[2];
   soun:char;
procedure tune1;{To generate the tune when user wins}
begin
   sound(800);
   delay(200);
   sound(1000);
   delay(200);
   sound(1200);
   delay(200);
   sound(800);
   delay(150);
   nosound;
end;
procedure tune2;{To generate the tune when computer wins}
begin
   sound(1200);
   delay(200);
   sound(1000);
   delay(200);
   sound(800);
   delay(200);
   nosound;
end;
procedure tune3;{To generate the tune on a drawn game}
begin
   sound(1000);
   delay(200);
   sound(1200);
   delay(200);
   sound(1000);
   delay(200);
   nosound;
end;

procedure drawrec(r1,c1,r2,c2:integer;col:integer); {Drawing a rectangle
      in text mode}
var
    co1:1..80;
begin
     textcolor(col);
     for co1:=(r1+1) to (r2-1) do
       begin
          gotoxy(co1,c1);
          write('Ä');
          gotoxy(co1,c2);
            write('Ä');
       end;
     for co1:=(c1+1) to (c2-1) do
       begin
          gotoxy(r1,co1);
          write('³');
          gotoxy(r2,co1);
          write('³');
        end;
     gotoxy(r1,c1);
     write('Ú');
     gotoxy(r1,c2);
     write('À');
     gotoxy(r2,c1);
     write('¿');
     gotoxy(r2,c2);
     write('Ù');
end;
procedure rules; {Writing the Rules & Regulations}
var
  ch:char;
begin
     drawrec(2,2,78,24,4);
     window(3,3,77,23);
     textcolor(0);
     textbackground(15);
     clrscr;
     window(4,3,75,23);
     textcolor(4);
     writeln(' RULES & REGULATIONS');
     writeln(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
     textcolor(1);
     write(' 1)You have to first chose an (n * n) board on which to play.');
     write('The minimum size of the board can be 3(for cross & noughts game) ,the maximum');
     write(' size being 20. However we recommend that beginners limit their grid size');
     writeln(' to  11.');
     write(' 2)The user then chooses the no. of elements that should be placed');
     write(' on   the grid to win. This no. should obviously  be lesser than the grid size');
     write(' But if the grid size is 4 or less than four then this no. is automatically');
     write(' assigned as the grid size. We recommend that beginners should keep  this no.');
     writeln(' below 6.');
     write(' 3)The user and the computer now take turns placing elements on the');
     write(' board.''Who'' starts the game is decided by the user.Whoever first creates a');
     write('   row, column or diagnol of the required no. of elements wins the game.');
     writeln('  The no. of games played is decided by the user.');
     write(' 4)The user must use the Menu driver Keys (On the right side of the ');
     write(' keyboard to move around the grid .To place his element on the required');
     write(' square, he has to move to that square and press enter.Remember that');
     writeln(' you cannot place an element on a square already occupied.');writeln;
     write('Press any key when ready');
     ch:=readkey;
     window(1,1,79,25);
     textcolor(15);
     textbackground(0);
     clrscr;
end;
procedure cover; {For designing the COVER}
var
  ch:char;
begin
    drawrec(3,3,77,22,4);
    window(4,4,76,21);
    textcolor(0);
    textbackground(white);
    clrscr;
    textcolor(1);
    writeln;
    writeln(' Presenting TIC-TAC-TOE Version 1.00 ');
    writeln(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
    writeln;
    textcolor(0);
    writeln(' By Amitabha Banerjee, 2nd yr., Electrical Engg., IIT Delhi(E no. 96180)');
    writeln(' Designed for TRYST 1998');
    writeln;
    writeln(' For more information contact at::B-2 Jwalamukhi Hostel or');
    writeln(' 136, Aakashdarshan apartments, Mayur Vihar 1, New Delhi-91 or');
    writeln(' Dial (011)-2259663 or');
    writeln(' Mail to eeu96180 (only in IITD)');
    writeln;
    write(' Would you like to refer to the rules & regulations(Y/N)');
    ch:=readkey;
    if upcase(ch)='Y' then rules;
    window(1,1,79,25);
    textcolor(15);
    textbackground(0);
    clrscr;
end;
procedure help;{For writing the HELP file}
var
  ch:char;
begin
   cleardevice;
  setcolor(15);
  bar(1,1,getmaxx,getmaxy);
  setcolor(1);
  settextstyle(2,0,5);
  outtextxy(10,10,' Welcome to TIC-TAC-TOE (Version 1.0) help');
  outtextxy(10,30,' Press enter to exit from ''HELP'' and return back to game ');
  setcolor(4);
  outtextxy(10,50,' How to play---');
  setcolor(0);
  outtextxy(10,70,' Use the menu driver keys to move around the board.These ');
  outtextxy(10,90,' keys are located in the right corner of the keyboard.');
  outtextxy(10,110,' Up key::Move up by a row.   Down key::Move down by a row.');
  outtextxy(10,130,' Right key::Move to next column  Left Key::Move to previous column');
  outtextxy(10,150,' Home::Move to starting point of board');
  outtextxy(10,170,' End::Move to last point on board');
  outtextxy(10,190,' Pg up.::Move to first row of the same column');
  outtextxy(10,210,' Pg. down::Move to last row of the same column');
  outtextxy(10,250,' Computer''s move will be indicted by a blue mark which');
  outtextxy(10,270,' will become white after some time.');
  setcolor(2);
  outtextxy(10,310,' Hints--');
  setcolor(0);
  outtextxy(10,330,' 1)Make rows or columns or diagnols in more than one direction simantaneously');
  outtextxy(10,350,' 2)Always try to place elements on the central squares');
  outtextxy(10,370,' 3)Watch out for the computer''s moves. It may sometimes take you by surprise.');
  outtextxy(10,390,' 4)Prevent the computer from creating long rows or columns');
  outtextxy(10,410,' 5)Plan your moves in advance');
  outtextxy(10,430,' Press any key to continue');
  ch:=readkey;
end;
function checksqr(no:rang1):boolean;
var
   che:boolean;
   co1,co2:rang2;
begin
    che:=false;
    for co1:=1 to (n-1) do
      for co2:=n downto 2 do
      if (arra[co1,co2]>0) then
        if ((arra[co1,co2]=no) and (arra[co1,co2-1]=no) and (arra[co1+1,co2-1]=no)
        and (arra[co1+1,co2]=no)) then
         che:=true;
    checksqr:=che;
end;
function check(no:rang2;var nosq:rang2):boolean;
{Algorithm Step no. 9}
var
   che:boolean;
   add:0..50;
   co1,co2,co3,co4:rang2;
begin
   che:=true;nosq:=0;
   aadd:=0;
    co1:=1;
    repeat
      co2:=1;
      repeat
         if (arra[co1,co2]=0) then
         che:=false;
         co2:=co2+1;
      until ((co2>n) or (not che));
      co1:=co1+1;
    until ((co1>n) or (not che));
   {Algorithm Step no. 9.1}
   for co1:= 1 to n do
   begin
      add:=0;co3:=0;
      for co2:=1 to (n-1) do
      begin
        if (arra[co1,co2]=0) then
        begin
         add:=0;
         co3:=0;
        end
        else
        if (arra[co1,co2]=arra[co1,(co2+1)]) then
        begin
          add:=add+arra[co1,co2];
          co3:=co3+1;
        end
        else
          begin
          add:=0;
          co3:=0;
          end;
        if co3=no then
        begin
           co3:=0;
           add:=0;
        end;
        if (co3=(no-1)) then
        if ((add=(no-1)) or (add=(2*(no-1)))) then
          begin che:=true;aadd:=add;nosq:=nosq+1; end;
      end;
   end;
   {Algorithm Step no. 9.2}
   for co2:= 1 to n do
   begin
      add:=0;co3:=0;
      for co1:=1 to (n-1) do
      begin
        if arra[co1,co2]=0 then
        begin
          add:=0;
        co3:=0;
        end
        else
        if arra[co1,co2]=arra[(co1+1),co2] then
        begin
          add:=add+arra[co1,co2];
          co3:=co3+1;
        end
        else
          begin
          add:=0;
          co3:=0;
          end;
          if co3=no then
          begin
            co3:=0;
            add:=0;
          end;
        if co3=(no-1) then
        if ((add=(no-1)) or (add=(2*(no-1)))) then
          begin che:=true;aadd:=add;nosq:=nosq+1; end;
      end;
   end;
   {Algorithm Step no. 9.3}
   for co1:=1 to (n-(m-1)) do
   begin
       co2:=1;
       co3:=co1;
       co4:=0;
       add:=0;
       while (co3<=(n-1)) do
       begin
          if arra[co2,co3]=0 then
          begin
             add:=0;
             co4:=0;
          end
          else
          if arra[co2,co3]=arra[co2+1,co3+1] then
           begin
             add:=add+arra[co2,co3];
             co4:=co4+1;
           end
           else
            begin
               add:=0;
               co4:=0;
            end;
           if co4=no then
           begin
              co4:=0;
              add:=0;
           end;
           if co4=(no-1) then
             if ((add=(no-1)) or (add=(2*(no-1)))) then
                begin che:=true;aadd:=add;nosq:=nosq+1; end;
          co3:=co3+1;
          co2:=co2+1;
       end;{while do}
   end;{for do}
   for co1:=2 to (n-(m-1)) do
   begin
       co2:=co1;
       co3:=1;
       co4:=0;
       add:=0;
       while (co2<=(n-1)) do
       begin
          if arra[co2,co3]=0 then
          begin
             add:=0;
             co4:=0;
          end
          else
          if arra[co2,co3]=arra[co2+1,co3+1] then
           begin
             add:=add+arra[co2,co3];
             co4:=co4+1;
           end
           else
           begin
             add:=0;
             co4:=0;
           end;
           if co4=no then
           begin
              co4:=0;
              add:=0;
           end;
           if co4=(no-1) then
             if ((add=(no-1)) or (add=(2*(no-1)))) then
                begin che:=true;aadd:=add;nosq:=nosq+1; end;
          co3:=co3+1;
          co2:=co2+1;
       end;{while do}
   end;{for do}
   for co1:=n downto (m-1) do
   begin
       co2:=co1;
       co3:=1;
       co4:=0;
       add:=0;
       while (co2>1)
        do
       begin
          if arra[co2,co3]=0 then
          begin
             add:=0;
             co4:=0;
          end
          else
          if arra[co2,co3]=arra[co2-1,co3+1] then
           begin
             add:=add+arra[co2,co3];
             co4:=co4+1;
           end
           else
             begin
                add:=0;
                co4:=0;
             end;
           if co4=no then
           begin
              co4:=0;
              add:=0;
           end;
           if co4=(no-1) then
             if ((add=(no-1)) or (add=(2*(no-1)))) then
                begin che:=true;aadd:=add;nosq:=nosq+1; end;
          co3:=co3+1;
          co2:=co2-1;
       end;{while do}
   end;{for do}
   for co1:=2 to (n-(m-1)) do
   begin
       co2:=n;
       co3:=co1;
       co4:=0;
       add:=0;
       while (co3<=(n-1)) do
       begin
          if arra[co2,co3]=0 then
          begin
             add:=0;
             co4:=0;
          end
          else
          if arra[co2,co3]=arra[co2-1,co3+1] then
           begin
             add:=add+arra[co2,co3];
             co4:=co4+1;
           end
           else
            begin
              add:=0;
              co4:=0;
            end;
           if co4=no then
           begin
              co4:=0;
              add:=0;
           end;
           if co4=(no-1) then
             if ((add=(no-1)) or (add=(2*(no-1)))) then
                begin che:=true;aadd:=add;nosq:=nosq+1; end;
          co3:=co3+1;
          co2:=co2-1;
       end;{while do}
   end;{for do}
   check:=che;
end;
procedure checkcomp(var cco1,cco2:rang2);
   {Algorithm Step no. 10}
var
   cc1,cc2,cc3,cc4,cc5,cc6,cc7,cc8:rang2;
   fi,fi1:boolean;
begin
    fi:=false;
    cco1:=0;
    cco2:=0;
    cc1:=1;cc2:=n;
   {Algorithm Step no. 10.1.(i)}
    repeat
      if (arra[cc1,cc2]=0) then
      begin
         arra[cc1,cc2]:=2;
         if check(m,cc3) then
         begin
         fi:=true;
         cco1:=cc1;
         cco2:=cc2;
         arra[cc1,cc2]:=0;
         end
         else
          arra[cc1,cc2]:=0;
      end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
      end;
    until ((cc1=(n+1)) or fi);
   {Algorithm Step no. 10.1.(ii)}
    if not fi then
    begin
      cc1:=1;cc2:=n;
      repeat
      if (arra[cc1,cc2]=0) then
      begin
         arra[cc1,cc2]:=1;
         if check(m,cc3) then
         begin
         fi:=true;
         cco1:=cc1;
         cco2:=cc2;
         arra[cc1,cc2]:=0;
         end
         else
          arra[cc1,cc2]:=0;
      end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
      end;
    until ((cc1=(n+1)) or fi);
   end;{if then else}
    {Algorithm Step no. 10.1.(iii)}
   if not fi then
    begin
      cc1:=1;cc2:=n;
      repeat
      if (arra[cc1,cc2]=0) then
      begin
         check((m-1),cc3);
         arra[cc1,cc2]:=1;
         check(m-1,cc4);
         if (cc3<(cc4-1)) then
         begin
         fi:=true;
         cco1:=cc1;
         cco2:=cc2;
         arra[cc1,cc2]:=0;
         end
         else
          arra[cc1,cc2]:=0;
       end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
      end;
    until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(iv)}
   if not fi then
    begin
      cc1:=1;cc2:=n;
      repeat
      if (arra[cc1,cc2]=0) then
      begin
         check(m-1,cc3);
         arra[cc1,cc2]:=2;
         check(m-1,cc4);
         if (cc3<(cc4-1)) then
         begin
         fi:=true;
         cco1:=cc1;
         cco2:=cc2;
         arra[cc1,cc2]:=0;
         end
         else
          arra[cc1,cc2]:=0;
       end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
      end;
    until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(v)}
   if not fi then
   begin
     cc1:=1;cc2:=n;
      repeat
      if (arra[cc1,cc2]=0) then
      begin
         check((m-1),cc3);
         arra[cc1,cc2]:=2;
         check((m-1),cc4);
         if (cc3<cc4) then
         begin
           cc5:=1;
           cc6:=n;
           cc7:=0;
           repeat
            if (arra[cc5,cc6]=0) then
              begin
                 arra[cc5,cc6]:=2;
                 if (check(m,cc8)) then  cc7:=cc7+1;
                 if cc7=2 then
                 begin
                      fi:=true;
                      cco1:=cc1;
                      cco2:=cc2;
                      arra[cc5,cc6]:=0;
                 end;
                 arra[cc5,cc6]:=0;
             end;
             cc6:=cc6-1;
             if cc6=0 then
               begin
               cc6:=n;
               cc5:=cc5+1;
              end;
           until ((cc5=(n+1)) or fi);
         end;
         arra[cc1,cc2]:=0;
       end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
     end;
    until ((cc1=(n+1)) or fi);
 end;{if then else}
 {Alogorithm steep 10.1.(vi)}
  if not fi then
   begin
     cc1:=1;cc2:=n;
      repeat
      if (arra[cc1,cc2]=0) then
      begin
         check((m-1),cc3);
         arra[cc1,cc2]:=1;
         check((m-1),cc4);
         if (cc3<cc4) then
         begin
           cc5:=1;
           cc6:=n;
           cc7:=0;
           repeat
            if (arra[cc5,cc6]=0) then
              begin
                 arra[cc5,cc6]:=1;
                 if (check(m,cc8)) then  cc7:=cc7+1;
                 if cc7=2 then
                 begin
                      fi:=true;
                      cco1:=cc1;
                      cco2:=cc2;
                      arra[cc5,cc6]:=0;
                 end;
                 arra[cc5,cc6]:=0;
             end;
             cc6:=cc6-1;
             if cc6=0 then
               begin
               cc6:=n;
               cc5:=cc5+1;
              end;
           until ((cc5=(n+1)) or fi);
         end;
         arra[cc1,cc2]:=0;
       end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
     end;
    until ((cc1=(n+1)) or fi);
 end;{if then else}
   {Algorithm Step no. 10.1.(vii)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(m-2,cc3);
          arra[cc1,cc2]:=1;
          check(m-2,cc4);
          if (cc3<(cc4-1)) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
          end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
       end;
     until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(viii)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(m-2,cc3);
          arra[cc1,cc2]:=2;
          check(m-2,cc4);
          if (cc3<(cc4-1)) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
          end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
       end;
     until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(ix)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(m-1,cc3);
          arra[cc1,cc2]:=2;
          check(m-1,cc4);
          if (cc3<cc4) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
       end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
      end;
     until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(x)}
   if not fi then
    begin
      cc1:=1;cc2:=n;
      repeat
      if (arra[cc1,cc2]=0) then
      begin
         check((m-1),cc3);
         arra[cc1,cc2]:=1;
         check(m-1,cc4);
         if (cc3<cc4) then
         begin
         fi:=true;
         cco1:=cc1;
         cco2:=cc2;
         arra[cc1,cc2]:=0;
         end
         else
          arra[cc1,cc2]:=0;
       end;
      cc2:=cc2-1;
      if cc2=0 then
      begin
        cc2:=n;
        cc1:=cc1+1;
      end;
    until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(xi)}
   if m<6 then
   begin
   {Algorithm Step no. 10.1.(xi)(a)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          arra[cc1,cc2]:=1;
          if checksqr(1) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
       end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
      end;
     until ((cc1=(n+1)) or fi);
   end;
   {Algorithm Step no. 10.1.(xi)(b)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          arra[cc1,cc2]:=2;
          if checksqr(2) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
       end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
      end;
     until ((cc1=(n+1)) or fi);
   end;
  end;{if not begin for m<6}
   {Algorithm Step no. 10.1.(xii)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(m-2,cc3);
          arra[cc1,cc2]:=2;
          check(m-2,cc4);
          if (cc3<cc4) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
          end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
       end;
     until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(xiii)}
   if not fi then
    begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(m-2,cc3);
          arra[cc1,cc2]:=1;
          check(m-2,cc4);
          if (cc3<cc4) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end
          else
           arra[cc1,cc2]:=0;
          end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
       end;
     until ((cc1=(n+1)) or fi);
   end;{if then else}
   {Algorithm Step no. 10.1.(xiv)}
   if not fi then
    begin
      cc8:=2;
      repeat
       cc1:=1;cc2:=n;fi1:=false;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(cc8+1,cc3);
          arra[cc1,cc2]:=2;
          check(cc8+1,cc4);
          if (cc3<cc4) then
          fi1:=true;
           arra[cc1,cc2]:=0;
       end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
       end;
       until ((cc1=(n+1)) or fi1);
       if not fi1 then
       begin
       cc1:=1;cc2:=n;
       repeat
       if (arra[cc1,cc2]=0) then
       begin
          check(cc8,cc3);
          arra[cc1,cc2]:=2;
          check(cc8,cc4);
          if (cc3<cc4) then
          begin
          fi:=true;
          cco1:=cc1;
          cco2:=cc2;
          arra[cc1,cc2]:=0;
          end;
           arra[cc1,cc2]:=0;
       end;
       cc2:=cc2-1;
       if cc2=0 then
       begin
         cc2:=n;
         cc1:=cc1+1;
       end;
      until ((cc1=(n+1)) or fi);
      end;
      cc8:=cc8+1;
     until (fi or (cc8=(m-2)))
   end;{if then else}
end;
procedure check3(var ch1,ch2:rang2;moves:rang3);
begin
    if ((arra[2,2]=1) and (arra[3,1]=1) and (moves=2)) then
    begin
      ch1:=1;
      ch2:=1;
    end;
    if ((arra[2,2]=2) and (moves=2)) then
    if (((arra[1,1]=1) and (arra[3,3]=1) ) or ((arra[1,3]=1) and (arra[3,1]=1) )) then
    begin
      ch1:=1;
      ch2:=2;
    end;
end;
{this procedure is to trace the computer's move}
procedure comove(pmx,pmy:rang2;cmv:rang3);
   {Algorithm Step no. 8}
var
  cmx,cmy,co3,co4:rang2;
begin
    case cmv of
       {Algorithm Step no. 8.1}
      1:if ((pmx=((n div 2)+1)) and (pmy=((n div 2)+1))) then
         begin
           cmx:=(n div 2);
           cmy:=(n div 2)+2;
         end
         else
         begin
           cmx:=(n div 2)+1;
           cmy:=(n div 2)+1;
         end;
       {Algorithm Step no. 8.2(a)}
      2:begin

            cmx:=(n div 2) +2;
            cmy:=(n div 2) +2;
            repeat
            cmy:=cmy-1;
            until arra[cmx,cmy]=0;
           end;
        end;{case of}
   {Algorithm Step no. 8.2(i)}
    if (((m<5) and (cmv>1)) or (cmv>2)) then
     begin
        checkcomp(co3,co4);
        if ((co3>0) and (co4>0)) then
        begin
           cmx:=co3;
           cmy:=co4;
        end
        else
         begin
           randomize;
           repeat
             cmx:=random(n-1)+1;
             cmy:=random(n-1)+1;
           until (arra[cmx,cmy]=0);
         end;
     end;
    if n=3 then check3(cmx,cmy,cmv);
    {Algorithm Step no. 10.2(i)}
    arra[cmx,cmy]:=2;
    setcolor(blue);
    outtextxy((180+(wid div 2)-10-((n-3)*12)+(cmx*wid)),(87+((wid-10) div 2)-((n-3)*5)+cmy*(wid-10)),'0');
    delay(200);
    setcolor(white);
    outtextxy((180+(wid div 2)-10-((n-3)*12)+(cmx*wid)),(87+((wid-10) div 2)-((n-3)*5)+cmy*(wid-10)),'0');
end;{procedure}
procedure menu(var cm1,cm2:rang2);
{This operates a menu driver to make the program user friendly}
var
   ch:char;
   c1,c2:rang2;
begin
    repeat
       setcolor(15);
       outtextxy((180+(wid div 2)-10-((n-3)*12)+(cm1*wid)),(87+((wid-10) div 2)-((n-3)*5)+cm2*(wid-10)),'_');
       ch:=readkey;
       setcolor(0);
       outtextxy((180+(wid div 2)-10-((n-3)*12)+(cm1*wid)),(87+((wid-10) div 2)-((n-3)*5)+cm2*(wid-10)),'_');
       case ord(ch) of
         071:begin
              cm1:=1;
              cm2:=1;
             end;
         072:if cm2>1 then cm2:=cm2-1 else cm2:=n;
         073:cm2:=1;
         075:if cm1>1 then cm1:=cm1-1 else cm1:=n;
         077:if cm1<n then cm1:=cm1+1 else cm1:=1;
         079:begin
              cm1:=n;
              cm2:=n;
             end;
         080:if cm2<n then cm2:=cm2+1 else cm2:=1;
         081:cm2:=n;
         060:che:=true;
         059:begin
               help;
               clearviewport;
               setcolor(green);
               settextstyle(2,0,5);
    outtextxy((180-((n-3)*12)+(1*wid)),(90-((n-3)*5)+(n+1)*(wid-10)),'X::denotes you,0::denotes computer');
    outtextxy((180-((n-3)*12)+(1*wid)),(110-((n-3)*5)+(n+1)*(wid-10)),'F1::Help  F2::exit');
    setcolor(white);
    if n<6 then
    settextstyle(0,0,2)
    else
    if n<14 then
    settextstyle(0,0,2)
    else
    settextstyle(0,0,1);
    for c1:=1 to n do
      for c2:=1 to n do
         begin
            rectangle((180-((n-3)*12)+(c1*wid)),(90-((n-3)*5)+c2*(wid-10))
            ,( ( 180-((n-3)*12)+(c1*wid)+(wid-1))),(90-((n-3)*5)+c2*(wid-10)+(wid-11)));
            if arra[c1,c2]=1 then
      outtextxy((180+(wid div 2)-10-((n-3)*12)+(c1*wid)),(87+((wid-10) div 2)-((n-3)*5)+c2*(wid-10)),'X')
            else
            if arra[c1,c2]=2 then
      outtextxy((180+(wid div 2)-10-((n-3)*12)+(c1*wid)),(87+((wid-10) div 2)-((n-3)*5)+c2*(wid-10)),'0');
         end;
      end;{059}
       end;{case of}
     until ((ord(ch)=013) or (ord(ch)=060));
     setcolor(15);
end;
begin{main}
    che:=false;
    textcolor(white);
    textbackground(black);
    clrscr;
    cover;
    che:=false;
    drawrec(10,5,70,20,4);
    window(12,7,68,18);
    textcolor(black);
    textbackground(white);
    clrscr;
    repeat
    {$i-}
    {Algorithm Step no. 1}
    write(' Please enter the dimension of the matrix(3..20)??');
    readln(n);
    {$i+}
    until ((ioresult=0) and (n IN [3..20]));
    {Algorithm Step no. 2(a)}
    if n<5 then
    begin
     m:=n;
     writeln(' Create ',m,' elements in rows,columns or diagnols to win');
     writeln(' Refer to Rules and Regulations for details');
    end
    else
    begin
      repeat
      {$i-}
      {Algorithm Step no. 2(i)}
      write(' How many elements to win(4');
      write('..',n,')??');
      readln(m);
      {$i+}
      {Algorithm Step no. 2(ii)}
      until ((ioresult=0) and (m IN [4..n]));
    end;
    {Algorithm Step no. 3}
    repeat
    {$i-}
    write(' Please enter the no. of games you''ll play(1..20)??');
    readln(gs);
    {$i+}
    until ((ioresult=0) and (gs IN [1..20]));
    {Algorithm Step no. 4}
    repeat
    {$i-}
    writeln(' Choices');
    writeln(' 0)You always start');
    writeln(' 1)Computer always starts');
    writeln(' 2)You and computer start alternately');
    write(' Choice(0..2)??');
    readln(cho);
    {$i+}
    until ((ioresult=0) and (cho In [0..2]));
    write(' Sound on win(Y/N)');
    soun:=readkey;
    window(1,1,79,25);
    textcolor(15);
    textbackground(0);
    clrscr;
    if n=3 then wid:=80
    else
    if n<5 then wid:=70
    else
      if n<6 then wid:=60
      else
      if n<14 then wid:=40
      else
      if n<21 then wid:=31;
    csc:=0;
    ysc:=0;
{Algorithm Step no. 5}
    gss:=0;
    gd:=detect;
    initgraph(gm,gd,' ');
    clearDevice;
    repeat
    setcolor(red);
    settextstyle(2,0,5);
    {This is to draw the board in graphics}
    outtextxy((180-((n-3)*12)+(1*wid)),(90-((n-3)*5)+wid-30),'Game no.   out of');
    str(gss+1,stri);
    outtextxy((245-((n-3)*12)+(1*wid)),(90-((n-3)*5)+wid-30),stri);
    str(gs,stri);
    outtextxy((315-((n-3)*12)+(1*wid)),(90-((n-3)*5)+wid-30),stri);
    setcolor(green);
    outtextxy((180-((n-3)*12)+(1*wid)),(90-((n-3)*5)+(n+1)*(wid-10)),'X::denotes you,0::denotes computer');
    outtextxy((180-((n-3)*12)+(1*wid)),(110-((n-3)*5)+(n+1)*(wid-10)),'F1::Help  F2::exit');
    setcolor(white);
    if n<6 then
    settextstyle(0,0,2)
    else
    if n<14 then
    settextstyle(0,0,2)
    else
    settextstyle(0,0,1);
    compmove:=0;
    for c1:=1 to n do
      for c2:=1 to n do
         begin
            rectangle((180-((n-3)*12)+(c1*wid)),(90-((n-3)*5)+c2*(wid-10))
            ,( ( 180-((n-3)*12)+(c1*wid)+(wid-1))),(90-((n-3)*5)+c2*(wid-10)+(wid-11)));
            arra[c1,c2]:=0;
         end;
  c2:=1;c1:=1;
{Algorithm Step no. 7}
case cho of
 0: while not (check(m,c3) or che) do
  begin
    {Algorithm Step no. 7.1.(a)}
    repeat
    menu(c2,c1);
    until ((arra[c2,c1]=0) or che);
    arra[c2,c1]:=1;
    outtextxy((180+(wid div 2)-10-((n-3)*12)+(c2*wid)),(87+((wid-10) div 2)-((n-3)*5)+c1*(wid-10)),'X');
    {Algorithm Step no. 7.1.(b)}
    if not (check(m,c3) or che) then
    begin
       {Algorithm Step no. 7.1.(c)}
       compmove:=compmove+1;
       comove(c1,c2,compmove);
    end;{if loop}
   end;{while do}
 1:while not (check(m,c3) or che) do
  begin
    {Algorithm Step no. 7.2.(c)}
    compmove:=compmove+1;
    comove(c1,c2,compmove);
    if not (check(m,c3) or che) then
    begin
     {Algorithm Step no. 7.2.(a)}
     repeat
     menu(c2,c1);
     until ((arra[c2,c1]=0) or che);
     arra[c2,c1]:=1;
     outtextxy((180+(wid div 2)-10-((n-3)*12)+(c2*wid)),(87+((wid-10) div 2)-((n-3)*5)+c1*(wid-10)),'X');
    end;{if loop}
   end;{while do}
   {Algorithm Step no. 7.3}
 2:if ((gss mod 2)=0) then
   while not (check(m,c3) or che) do
    begin
    gotoxy(18,24);
    repeat
    menu(c2,c1);
    until ((arra[c2,c1]=0) or che);
    arra[c2,c1]:=1;
    outtextxy((180+(wid div 2)-10-((n-3)*12)+(c2*wid)),(87+((wid-10) div 2)-((n-3)*5)+c1*(wid-10)),'X');
    if not (check(m,c3) or che) then
    begin
       compmove:=compmove+1;
       comove(c1,c2,compmove);
    end;{if loop}
   end{while do}
   else
   while not (check(m,c3) or che) do
    begin
    compmove:=compmove+1;
    comove(c1,c2,compmove);
    if not (check(m,c3) or che) then
    begin
     repeat
     menu(c2,c1);
     until ((arra[c2,c1]=0) or che);
     arra[c2,c1]:=1;
     outtextxy((180+(wid div 2)-10-((n-3)*12)+(c2*wid)),(87+((wid-10) div 2)-((n-3)*5)+c1*(wid-10)),'X');
    end;{if loop}
   end;{while do}
  end;
    gss:=gss+1;
    settextstyle(2,0,5);
    setcolor(green);
    if not che then
    if aadd=(m-1) then
    begin
     ysc:=ysc+1;
     if upcase(soun)= 'Y' then tune1;
     outtextxy((320-((n-3)*12)+(1*wid)),(110-((n-3)*5)+(n+1)*(wid-10)),'You win.Press enter.');
    end
    else
    if aadd=(2*(m-1)) then
     begin
     csc:=csc+1;
     if upcase(soun)='Y' then tune2;
     outtextxy((320-((n-3)*12)+(1*wid)),(110-((n-3)*5)+(n+1)*(wid-10)),'Computer wins.Press Enter');
     end
     else
     begin
     outtextxy((320-((n-3)*12)+(1*wid)),(110-((n-3)*5)+(n+1)*(wid-10)),'Game draw.Press enter.');
     if upcase(soun)='Y' then tune3;
     end;
     if not che then
     readln;
     clearDevice;
    until ((gss=gs) or che);
    {Algorithm Step no. 11}
     restorecrtmode;
    textcolor(white);
    textbackground(black);
    drawrec(20,7,60,18,2);
    window(21,8,59,17);
    textcolor(black);
    textbackground(white);
    clrscr;
    writeln('            SCORE TABLE');
    writeln('            ÄÄÄÄÄÄÄÄÄÄÄ');
    drawrec(3,2,28,8,0);
    drawrec(30,2,37,8,0);
    gotoxy(1,3);
    writeln('  ³Games played::          ³ ³  ',gs);
    writeln('  ³You won::               ³ ³  ',ysc);
    writeln('  ³Computer won::          ³ ³  ',csc);
    writeln('  ³Drawn/No result::       ³ ³  ',(gs-ysc-csc));
    write('  ³Your % success::        ³ ³',((ysc/gs)*100):4:2);
    gotoxy(3,9);
    textcolor(red);
    if ysc>csc then writeln('Result::You won the series of games')
    else
    if ysc<csc then writeln('Result::Computer won the series')
    else
    writeln('You and the computer share honours');
    gotoxy(3,10);
    write(' Press enter to end...');
    readln;
end.


