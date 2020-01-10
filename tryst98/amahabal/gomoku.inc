/** a include file which most of windows applications can use
 ** defines WinMain() procedure
**/
#pragma argsused
int PASCAL WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,LPSTR lpszCmdLine,int nCmdShow) {
	HWND hWnd;
	MSG  msg;
	WNDCLASS wndclass;

	if(!hPrevInstance) {
		wndclass.style            =   CS_HREDRAW | CS_VREDRAW;          //default
		wndclass.lpfnWndProc      =   (WNDPROC) WndProc;
		wndclass.cbClsExtra=     0;
		wndclass.cbWndExtra=		 0;
		wndclass.hInstance=      hInstance;
		wndclass.hIcon=          LoadIcon(hInstance,IDI_APPLICATION);
		wndclass.hCursor=        LoadCursor(NULL,IDC_ARROW);
		wndclass.hbrBackground=  GetStockObject(WHITE_BRUSH);
		wndclass.lpszClassName=   szProgName;     //windows class name
		wndclass.lpszMenuName=     szProgName;
		if(!RegisterClass(&wndclass))
			return FALSE;
	}
	hWnd = CreateWindow(szProgName,                  //windows class name
							  szProgName,                  //caption
							  WS_OVERLAPPEDWINDOW,             //style
							  0,0,XWIDTH,YWIDTH,
					  /*		  CW_USEDEFAULT,                   //x
							  CW_USEDEFAULT,                   //y
							  CW_USEDEFAULT,                   //width
							  CW_USEDEFAULT,                   //height */
							  NULL,                            //parents handle
							  NULL,                            //menu handle
							  hInstance,                              //which program
							  NULL);                           //no xtra data
	ShowWindow(hWnd,nCmdShow);

	while(GetMessage(&msg,NULL,0,0)) {     //message loop
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return msg.wParam;
}


