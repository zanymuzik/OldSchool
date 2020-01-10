program try(input,output);
uses crt;
const
    ko=20;
var
    bd,set1,set2 : array[1..ko,1..ko] of integer;
    dis:array[1..2,1..ko,1..ko] of integer;
    mus,i,j,k,m,n:integer;
{************** PROCEDURES ********************}
procedure mwin;
begin
  mus :=0;
  for mus := 1 to 2 do
  begin
  sound (700);delay (60);nosound;
  sound (900);delay (150);nosound;
  sound (700);delay (100);nosound;
  sound (1100);delay (300);nosound;
  end;
end;
procedure mlos;
begin
  mus :=0;
  for mus := 1 to 1 do
  begin
  sound (1100);delay (200);nosound;
  sound (800);delay (200);nosound;
  sound (500);delay (100);nosound;
  sound (200);delay (200);nosound;
  end;
end;
{****}
procedure click;
begin
   sound(900);delay (60);nosound;
end;
{****}



procedure display;
var y,z:integer;
begin
  clrscr;
  writeln('TO WIN ',m,' Os MUST IN A LINE');
  write(chr(218));
  for y:=1 to n-1 do
  write(chr(196),chr(196),chr(196),chr(194));
  writeln(chr(196),chr(196),chr(196),chr(191));
  for y:=1 to n do
  begin
   write(chr(179));
   for z:=1 to n do
   if bd[y,z]=1 then
          write(' O ',chr(179))
          else if bd[y,z]=2 then
                            write(' X ',chr(179))
                            else write('   ',chr(179));
   writeln;
   if y<>n then
   begin
      write(chr(195));
      for z:=1 to n-1 do
      write(chr(196),chr(196),chr(196),chr(197));
      writeln(chr(196),chr(196),chr(196),chr(180));
   end;
  end;
  write(chr(192));
  for z:=1 to n-1 do
  write(chr(196),chr(196),chr(196),chr(193));
  writeln(chr(196),chr(196),chr(196),chr(217));
end;

procedure dis12(p:integer);
var i,j,d,s,e:integer;
begin
  for i:= 1 to n do
  for j:= 1 to n do
  if bd[i,j]=p then dis[p,i,j]:=0 else
  begin
    d:=20;s:=i;
    repeat s:=s+1
    until (bd[s,j]=p)or(s=i+3)or(s>=n);
    if bd[s,j]=p then d:=s-i;
    s:=i ;repeat s:=s-1 until (bd[s,j]=p)or(s=i-4)or(s<=1);
    if (bd[s,j]=p)and (d>i-s) then d:=i-s;
    s:=j;
    repeat s:=s+1
    until (bd[i,s]=p)or(s=j+3)or(s>=n);
    if (bd[i,s]=p)and(d>s-j) then d:=s-j;
    s:=j ;
    repeat s:=s-1
    until (bd[i,s]=p)or(s=j-3)or(s<=1);
    if (bd[i,s]=p)and (d>j-s) then d:=j-s;
    s:=i;
    repeat s:=s+1
    until (bd[s,i+j-s]=p)or(s>=n)or(i+j-s<=1)or(s=i+3);
    if (bd[s,i+j-s]=p)and(d>abs(i-s)) then d:=abs(i-s);
    s:=i;
    repeat s:=s-1
    until (bd[s,i+j-s]=p)or(s<=1)or(s=i-3)or(i+j-s>=n);
    if (bd[s,i+j-s]=p)and(d>abs(i-s))then d:=abs(i-s);
    s:=i;
    repeat s:=s+1
    until (bd[s,j-i+s]=p)or(s=i+3)or(s>=n)or(j-i+s>=n);
    if (bd[s,j-i+s]=p)and(d>abs(i-s)) then d:=abs(i-s);
    s:=i;
    repeat s:=s-1
    until (bd[s,j-i+s]=p)or(s=i-3)or(s<=1)or(j-i+s<=1);
    if (bd[s,j-i+s]=p)and(d>abs(i-s)) then d:=abs(i-s);
    dis[p,i,j]:=d;
  end;
end;



function h_v(r,c,p:integer):integer;
var
s,e,q:integer;
hv :integer;
begin
  hv:=0;
  if p=1 then q:=2;
  if p=2 then q:=1;
  s:=r+1;
  repeat s:=s-1
  until ((bd[s-1,c]=q) or (s=1) or (s=r-m+1) );
  e:=r-1;
  repeat e:=e+1
  until ((bd[e+1,c]=q) or(e=n)or(e=r+m-1));
  if e-s+1>=m then hv:=hv+1+e-s+1-m;
  s:=c+1;
  repeat s:=s-1
  until ((bd[r,s-1]=q) or (s=1) or (s=c-m+1) );
  e:=c-1;
  repeat e:=e+1
  until ((bd[r,e+1]=q) or(e=n)or(e=c+m-1));
  if e-s+1>=m then hv:=hv+1+e-s+1-m;
  h_v:=hv;
end;

function diagon(r,c,p:integer):integer;
var
s,e,q:integer;
d:integer;
begin
  if p=1 then q:=2 else q:=1;
  d:=0;
  if n-abs(r-c)>= m then
  begin
    s:=r+1;
    repeat s:=s-1
    until ((bd[s-1,c-r+s-1]=q)or(s=1)or (c-r+s=1)or(s=r-m+1));
    e:=r-1;
    repeat e:=e+1
    until ((bd[e+1,c-r+e+1]=q)or(e=n)or(c-r+e=n)or(e=r+m-1));
    if e-s+1>=m then d:=d+1+e-s+1-m;
  end;
  if(abs(n-abs(n-(r+c-1)))>=m) then
  begin
    s:=r+1;
    repeat s:=s-1
    until((bd[s-1,r+c-s+1]=q)or(s=1)or(r+c-s=n)or(s=r-m+1));
    e:=r-1;
    repeat e:=e+1
    until((bd[e+1,r+c-e-1]=q)or(e=n)or(r+c-e=1)or(e=r+m-1));
    if e-s+1>=m then d:=d+1+e-s+1-m;
  end;
  diagon:=d;
end;

function set12:boolean;
var
 y,z:integer;
begin
  set12:=false;
  for y:= 1 to n do
  for z:= 1 to n do
  begin
    if bd[y,z]=0 then begin
    set1[y,z]:=h_v(y,z,1)+diagon(y,z,1) ;
    set2[y,z]:=h_v(y,z,2)+diagon(y,z,2); end;
    if ((bd[y,z]=0)and((set1[y,z]>1)or(set2[y,z]>1)))
    then set12:=true
  end;
end;

function fbd:boolean;
var
  y,z :integer;
begin
  fbd := true;
  for y:= 1 to n do
  for z:= 1 to n do
  if (bd[y,z]=0) then begin fbd:=false;y:=n;z:=n;end;
end;

function check1(a:integer):boolean;
var
  h,v,i,j:integer;
begin
  check1 := false ;
  for i:= 1 to n do
  begin
     h:=0;v:= 0 ;
     for j := 1 to n do
     begin
       if bd[i,j]=a then h:=h+1 else h:=0;
       if bd[j,i]=a then v:=v+1 else v:=0;
       if (v=m) or (h=m) then begin
                              check1:=true;i:=n;j:=n;
                              end;
     end;
  end;
end;

function check2(r,c,p:integer):boolean;
var
  s,e:integer;
  d:boolean;
begin
  d:=false;
  if n-abs(r-c)>= m then
  begin
    s:=r+1;
    repeat s:=s-1
    until ((bd[s-1,c-r+s-1]<>p)or(s=1)or(c-r+s=1)or(s=r-m+1));
    e:=r-1;
    repeat e:=e+1
    until ((bd[e+1,c-r+e+1]<>p)or(e=n)or(c-r+e=n)or(e=r+m-1));
    if e-s+1>=m then d:=true;
  end;
  if  (abs(n-abs(n-(r+c-1)))>=m)and not(d) then
  begin
    s:=r+1;
    repeat s:=s-1
    until((bd[s-1,r+c-s+1]<>p)or(s=1)or(r+c-s=n)or(s=r-m+1));
    e:=r-1;
    repeat e:=e+1
    until((bd[e+1,r+c-e-1]<>p)or(e=n)or(r+c-e=1)or(e=r+m-1));
    if e-s+1>=m then d:=true;
  end;
  check2:=d;
end;

function win:boolean;
var
  y,z:integer;
  w:boolean;
begin
  w:=false;
  if check1(2) then  w :=true else
  for y:=1 to n do
  for z:=1 to n do
  if (bd[y,z]=2) and check2(y,z,2) then  w:=true;
  win:=w;
end;

function lost:boolean;
var
  y,z:integer;
  w:boolean;
begin
  w:=false;
  if check1(1) then  w :=true else
  for y:=1 to n do
  for z:=1 to n do
  if (bd[y,z]=1) and check2(y,z,1) then  w:=true;
  lost:=w;
end;
function drc(x:integer;var r:integer;var c:integer):integer;
var
  d,y,z :integer;
begin
  r:=0;c:=0;d:=0;
  for y := 1 to n do
  for z:= 1 to n do
  begin
     if (bd[y,z]= 0) and (dis[x,y,z]<3)
     then
     begin
       bd[y,z]:=x ;
       if (check1(x)) or (check2(y,z,x)) then
                                         begin
                                         r:=y;c:=z;d:=d+1
                                         end;
       bd[y,z]:=0;
     end;
  end;
  drc:=d;
end;

function drc2(p:integer;var y,z:integer):integer;
var
  d,y1,z1,i,j,q,l2,l:integer;
begin
  y:=0;z:=0;d:=0;
  for i:=1 to n do
  for j:=1 to n do
  if (bd[i,j]=0) and (dis[p,i,j]<3)
  then
  begin
    bd[i,j]:=p;l2:=drc(p,y1,z1);dis12(p);
    if l2>1 then
    begin
      y:=i;z:=j;d:=d+1;
    end;
    bd[i,j]:=0;dis12(p);
  end;
  drc2:=d;
  if p=1 then q:=2 else q:=1;
  if (d>1)and(m=3)and(n=3)and (bd[2,2]=q) then
  begin
    bd[y,z]:=p ;drc(p,y1,z1);bd[y,z]:=0;y:=y1;z:=z1;
  end;
end;

function drc3(p:integer;var y,z:integer):integer;
var
  d,y1,z1,i,j,q,l,l2:integer;
begin
  y:=0;z:=0;d:=0;l:=1;
  for i:=1 to n do
  for j:=1 to n do
  if (bd[i,j]=0)and(dis[p,i,j]<4 )
  then
  begin
    bd[i,j]:=p;l2:=drc2(p,y1,z1);dis12(1);
    if l2>l then
    begin
      y:=i;z:=j;d:=d+1;l:=l2
    end;
    bd[i,j]:=0;dis12(1);
    end;
  drc3:=d;
end;

procedure compturn;
var
  i,j,y,z,large:integer;
begin
  if not(fbd or win or lost) then
  begin
    i:=0;j:=0;
    drc(2,i,j);
    if not(i=0) then bd[i,j]:=2 else
     begin
       drc(1,i,j);
       if not(i=0) then bd[i,j]:=2 else
       if drc2(2,i,j)>0 then bd[i,j]:=2 else
       if drc2(1,i,j)>0 then bd[i,j]:=2 else
       if ((m-0.5)<=n/2)and(drc3(2,i,j)>0) then bd[i,j]:=2 else
       if ((m-0.5)<=n/2)and(drc3(1,i,j)>0) then bd[i,j]:=2 else
       begin
         large:=-3; set12;
         for y:=1 to n do
         for z:=1 to n do
         if bd[y,z]=0 then
         begin
           if (set1[y,z]+set2[y,z]-large)>=0 then
           begin
            large :=set1[y,z]+set2[y,z];
            i:=y;j:=z;
           end;
       end;
       bd[i,j]:=2
     end;
    end;
    dis12(2);
    display;
  end;
end;

procedure game;
var
 i,j,w,l,d,y,z:integer;
 large:real;
 r:boolean;
begin
  repeat
  clrscr;
  writeln('FIRST TURN ');
  writeln('1:COMPUTER   2:MAN');
  write('your choice:');
  readln(i);
  until (i>0)and(i<3);
  if i=2 then
  begin
    display;
    writeln('YOUR TURN');
    repeat readln(i,j);
    until (i>0)and(j>0)and(i<=n)and(j<=n);
    bd[i,j]:=1;
  end;
  repeat
  compturn;click;
  display;
  if not(fbd or win or lost) then
  begin
    repeat display;
    writeln('YOUR TURN');
    readln(i,j);
    until (bd[i,j]=0)and(i>0)and(j>0)and(i<=n)and(j<=n);
    bd[i,j]:=1;
    dis12(1);
  end;
  until (fbd or win or lost);
  display;
  if fbd then writeln('FULL BOARD!');
  if win then
     begin
     writeln('COMPUTER HAS WON. BETTER LUCK NEXT TIME.');
     mlos;
     end;
  if lost then
     begin
     writeln('CONGRATS YOU HAVE BEATEN THE COMPUTER');
     mwin;
     end;
end;

{******************** MAIN BLOCK ***********************}
begin
  repeat
  clrscr;
  write ('size of grid is :');
  readln(n);
  write('THE NUMBER OF Xs or Os REQUIRED IN A LINE TO WIN:');
  readln(m);
  until (n>2) and (m>2) and (n<20) and(m<20)and(m<=n);
  display ;
  writeln('THIS IS THE GRID SHEET');
  writeln('Press enter to continue');
  readln;
  for i:=1 to n do
  for j:=1 to n do
  begin
    dis[1,i,j]:=20;dis[2,i,j]:=20;
  end;
  game;
  readln;
end.


