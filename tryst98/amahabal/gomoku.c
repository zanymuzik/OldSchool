// gomoku:: a tic tac toe like game
#define STRICT
#include <windows.h>
#include "gomoku.h"
#include "gomoku.inc";       

LRESULT CALLBACK _export WndProc(HWND hWnd,UINT iMessage,WPARAM wParam,LPARAM lParam) {
	HDC hdc;
	PAINTSTRUCT ps;
	int xposition,yposition;
	int xpos,ypos;
	float BOXSIZE;
	int i=0;
	BOXSIZE=(WIDTHX/N);
	switch(iMessage) {
		case WM_CREATE :
			initialize();
			InitDialog(hWnd);
			hWindow=hWnd;
			break;
		case WM_PAINT:
			hdc=BeginPaint(hWnd,&ps);
			for(i=0;i<N;i++) {
				MoveTo(hdc,i*BOXSIZE,0);
				LineTo(hdc,i*BOXSIZE,WIDTHY);
			}
			for(i=0;i<N;i++) {
				MoveTo(hdc,0,i*BOXSIZE);
				LineTo(hdc,WIDTHX,i*BOXSIZE);
			}
			ShowBoard(hdc);
			EndPaint(hWnd,&ps);
			break;
		case WM_COMMAND :
			switch(wParam) {
            case CM_HELPABOUT :
               MessageBox(hWnd,"Gomoku is a tic tac toe like game\n\n\
Programmers  :Vivek,Abhijeet & Sushil\n\n\
Explicitly coded for tryst :-)","About Gomoku",MB_OK | MB_ICONINFORMATION);
               break;
            case CM_HELPCONTENTS:
               WinHelp(hWnd,"gomoku.hlp",HELP_CONTENTS,0L);
               break;
				case IDM_RESTART :
					InitDialog(hWnd);
					break;
				case IDM_EXIT:
					DestroyWindow(hWnd);
					break;
				}
				break;
			case WM_DESTROY:
				PostQuitMessage(0);
				break;
			case WM_LBUTTONDOWN :
				 xposition=LOWORD(lParam);
				 yposition=HIWORD(lParam);
				 xposition /= BOXSIZE;
				 yposition /= BOXSIZE;
				 if(Board[yposition][xposition]==BLANK) {
					 hdc=GetDC(hWnd);
					 TextOut(hdc,BOXSIZE*xposition+BOXSIZE/2 - 5
                ,BOXSIZE*yposition+BOXSIZE/2-9,"X",1);
					 Board[yposition][xposition]=XMARK;
					 nextmove(&ypos,&xpos);
                if(ypos!=-1) {
                   Board[ypos][xpos]=OMARK;
                   TextOut(hdc,BOXSIZE*xpos+BOXSIZE/2 - 5
                   ,BOXSIZE*ypos+BOXSIZE/2-9,"O",1);
                }
                check();
                if(Game_over) {
						 if(Winner==COMPUTER) {
						 Game_over=FALSE;
						 MessageBox(hWnd,"I win!","Game over",MB_OK | MB_ICONINFORMATION);
						 }
						 if(Winner==USER) {
						 Game_over=FALSE;
						 MessageBox(hWnd,"You win!","Game over",MB_OK | MB_ICONINFORMATION);
                   return 0L;
						 }
                   if(Winner==DRAW) {
                   Game_over=FALSE;
                   MessageBox(hWnd,"Game draw!","Game over",MB_OK | MB_ICONINFORMATION);
                   InitDialog(hWnd);
                   return 0L;
                   }
					 }
				 } else MessageBeep(0);
				break;
			default:
				return DefWindowProc(hWnd,iMessage,wParam,lParam);
		}
	return 0L;
}

void ShowBoard(HDC hdc) {
	int i,j;
	float BOXSIZE=WIDTHX/N;
	for(i=0;i<N;i++) {
		for(j=0;j<N;j++) {
			if(Board[j][i]==OMARK)
				TextOut(hdc,BOXSIZE*i+BOXSIZE/2-5,BOXSIZE*j+BOXSIZE/2 -9 ,"O",1);
			if(Board[j][i]==XMARK)
				TextOut(hdc,BOXSIZE*i+BOXSIZE/2-5,BOXSIZE*j+BOXSIZE/2 -9,"X",1);
		}
	}
}
void InitDialog(HWND hWnd) {
	HINSTANCE hInstance;
	DLGPROC lpNameDialog;
	int i,j;
	int result;
   int xpos,ypos;
	hInstance=(HINSTANCE)GetWindowWord(hWnd,GWW_HINSTANCE); //get instance handle

	//get pointer to instance of procedure
	lpNameDialog=(DLGPROC)MakeProcInstance(
						  (FARPROC)HandleDialog,hInstance);
	//show the dialog box
	result=DialogBox(hInstance,"gomoku",hWnd,lpNameDialog);
	//free this instance of procedure
	FreeProcInstance((FARPROC)lpNameDialog);
	if(result==IDOK) {
		for(i=0;i<MAX;i++)
		  for(j=0;j<MAX;j++)
			  Board[i][j]=BLANK;
		if(move==COMPUTER)  {
			nextmove(&ypos,&xpos);
			Board[ypos][xpos]=OMARK;
		}
	}
	InvalidateRect(hWnd,NULL,TRUE);
}

BOOL CALLBACK _export HandleDialog(HWND hDlg,UINT iMessage,WPARAM wParam,LPARAM lParam) {
	HWND hControl;
	static int tmove;
	int current;
	switch(iMessage) {
		case WM_INITDIALOG :
			hControl = GetDlgItem(hDlg,IDD_ENTERN);
			SetFocus(hControl);
			SetDlgItemInt(hDlg,IDD_ENTERN,N,FALSE);
			SetDlgItemInt(hDlg,IDD_ENTERM,M,FALSE);
			SendMessage(hControl,EM_SETSEL,0,MAKELONG(0,-1));

			current=(move==COMPUTER) ? IDD_PUSH1 : IDD_PUSH2;
			CheckRadioButton(hDlg,IDD_PUSH1,IDD_PUSH2,current);
			return FALSE;
		case WM_COMMAND :
			switch(wParam) {
				case IDD_PUSH1 :
					tmove=COMPUTER;
					break;
				case IDD_PUSH2 :
					tmove=USER;
					break;
				case IDOK:
					N=GetDlgItemInt(hDlg,IDD_ENTERN,NULL,FALSE);
					M=GetDlgItemInt(hDlg,IDD_ENTERM,NULL,FALSE);
					EndDialog(hDlg,IDOK);
					N=((N==0) ? DEFAULT_N : N);
					M=((M==0) ? DEFAULT_M : M);
					move=tmove;
					break;
				case IDCANCEL:
					EndDialog(hDlg,IDCANCEL);
					break;
			}
			break;
		default:
			return FALSE;
	}
	return TRUE;
}

void nextmove(int *compux,int *compuy)  {
	int bestx=-1,besty;
	int value,bestvalue=-1;
	int i,j;

	for(i=0;i<N;i++) {
		for(j=0;j<N;j++) {
			if(Board[i][j]==BLANK) {
				value=Evaluate(i,j);
				if(value > bestvalue) {
					bestx=i; besty=j;
					bestvalue=value;
				 }
			 }
		 }
	 }
    /*if(bestx==-1) {
       Game_over=1;
       Winner=DRAW;
    } */
	*compux=bestx;
	*compuy=besty;
}
int Evaluate(int  x,int y) {
	int sum=0;
	int xcount,ocount,i,j,s,t,u,v,valid;
	//VERT
	for(i=0;i<M;i++) {
	  s=x-M+1+i;  t=y;
	  xcount=ocount=0;
	  u=s,v=t;
	  valid=1;
	  for(j=0;j<M;j++) {
		  if(u<0 || v < 0 || u >= N || v >= N) {
			  valid=0;
			  continue;
		  }
		  if(Board[u][v] == XMARK) xcount++;
		  if(Board[u][v] == OMARK) ocount++;
		  u++;
	  }
	  if(valid) {
		  if(xcount==0)  sum+= OWT[ocount];
		  else if(ocount==0) sum += XWT[xcount];
		  if(ocount==M-1 &&(!Game_over)) {
			  Game_over=1;
			  Winner=COMPUTER;
		  }
	  }
	}
	//HORZ
	for(i=0;i<M;i++) {
	  s=x;  t=y-M+1+i;
	  xcount=ocount=0;
	  u=s,v=t;
	  valid=1;
	  for(j=0;j<M;j++) {
		  if(u<0 || v < 0 || u >= N || v >= N) {
			  valid=0;
			  continue;
		  }
		  if(Board[u][v] == XMARK) xcount++;
		  if(Board[u][v] == OMARK) ocount++;
		  v++;
	  }
	  if(valid) {
		  if(xcount==0)  sum+= OWT[ocount];
		  else if(ocount==0) sum += XWT[xcount];
		  if(ocount==M-1 &&(!Game_over)) {
			  Game_over=1;
			  Winner=COMPUTER;
		  }
	  }
	}
	//1st diagonal
	for(i=0;i<M;i++) {
	  s=x-M+1+i;  t=y-M+1+i;
	  xcount=ocount=0;
	  u=s,v=t;
	  valid=1;
	  for(j=0;j<M;j++) {
		  if(u<0 || v < 0 || u >= N || v >= N) {
			  valid=0;
			  continue;
		  }
		  if(Board[u][v] == XMARK) xcount++;
		  if(Board[u][v] == OMARK) ocount++;
		  u++;v++;
	  }
	  if(valid) {
		  if(xcount==0)  sum+= OWT[ocount];
		  else if(ocount==0) sum += XWT[xcount];
		  if(ocount==M-1 &&(!Game_over)) {
			  Game_over=1;
			  Winner=COMPUTER;
		  }
	  }
	}
	//2nd diagonal
	for(i=0;i<M;i++) {
	  s=x-M+1+i;  t=y+M-1-i;
	  xcount=ocount=0;
	  u=s,v=t;
	  valid=1;
	  for(j=0;j<M;j++) {
		  if(u<0 || v < 0 || u >= N || v >= N) {
			  valid=0;
			  continue;
		  }
		  if(Board[u][v] == XMARK) xcount++;
		  if(Board[u][v] == OMARK) ocount++;
		  u++;v--;
	  }
	  if(valid) {
		  if(xcount==0)  sum+= OWT[ocount];
		  else if(ocount==0) sum += XWT[xcount];
		  if(ocount==M-1 &&(!Game_over)) {
			  Game_over=1;
			  Winner=COMPUTER;
		  }
	  }
	}
	return sum;
}
void initialize() {
	int i;
	int j;
	XWT[0]=OWT[0]=1;
	XWT[1]=4;OWT[1]=5;
	for(i=2;i<M;i++) {
		XWT[i]=XWT[i-1]*5;
		OWT[i]=OWT[i-1]*5;
	}

	for(i=0;i<MAX;i++)
	  for(j=0;j<MAX;j++)
		  Board[i][j]=BLANK;
}
void check() {
   int i,j;
   int sr,sc;
   int cons_x=0;
   int over=TRUE;
   //HORZ
   for(i=0;i<N;i++) {
      for(j=0;j<N;j++) {
         if(Board[i][j]==XMARK) {
            cons_x++;
            if(cons_x == M) {
               Game_over=1;
               Winner=USER;
            }
         } else { cons_x=0;
            if(Board[i][j]!=OMARK) over=FALSE;
         }
      }
      cons_x=0;
   }
   if(over) {
      Game_over=1;
      Winner=DRAW;
   }
   for(j=0;i<N;i++) {
      for(i=0;j<N;j++) {
         if(Board[i][j]==XMARK) {
            cons_x++;
            if(cons_x == M) {
               Game_over=1;
               Winner=USER;
            }
         }  else cons_x=0;
      }
      cons_x=0;
   }

   i=sr=0; j=sc=N-1;
   while(1) {
      if(Board[i][j]==XMARK) {
         cons_x++;
         if(cons_x == M) {
            Game_over=1;
            Winner=USER;
         }
      } else cons_x=0;
      if (i==N-1) {i=++sr; j=sc; cons_x=0;}
      else if(j == N-1) {j=--sc; i=sr; cons_x=0;}
      else { i++; j++; }
      if(j<0) break;
  }
  i=sr=0; j=sc=0;
   while(1) {
      if(Board[i][j]==XMARK) {
         cons_x++;
         if(cons_x == M) {
            Game_over=1;
            Winner=USER;
         }
      } else cons_x=0;
      if (i==N-1) {i=++sr; j=sc; cons_x=0;}
      else if(j == 0) {j=++sc; i=sr; cons_x=0;}
      else { i++; j--; }
      if(j==N) break;
  }
  return;
}
