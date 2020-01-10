//declarations and definations for main program

#define IDD_ENTERN	101
#define IDD_ENTERM	102
#define IDD_PUSH1	103
#define IDD_PUSH2	104
#define IDM_RESTART	1001
#define CM_HELPCONTENTS	101
#define CM_HELPABOUT	24346
#define IDM_EXIT	1002
#define MAX 50
#define XWIDTH (400+10)
#define YWIDTH (400+25+25)
#define WIDTHX 400
#define WIDTHY 400
#define DEFAULT_N 10
#define DEFAULT_M 5
#define XMARK  -1
#define OMARK  1
#define BLANK 0
#define COMPUTER 2
#define USER     3
#define DRAW     4
static int N=DEFAULT_N;
static int M=DEFAULT_M;
static int XWT[MAX];
static int OWT[MAX];
static int Board[MAX][MAX];
LRESULT CALLBACK _export WndProc(HWND,UINT,WPARAM,LPARAM);
BOOL CALLBACK _export HandleDialog(HWND,UINT,WPARAM,LPARAM);

#define BUFFSIZE 256
char szName[BUFFSIZE];
char szString[BUFFSIZE];

PSTR szProgName="gomoku";
int move=USER;
BOOL Game_over=FALSE;
int Winner;
HWND hWindow;
void nextmove(int *,int *);
void initialize(void);
void InitDialog(HWND);
void ShowBoard(HDC);
int Evaluate(int,int);
void check(void);
