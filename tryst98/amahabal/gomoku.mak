#
# Borland C++ IDE generated makefile
#
.AUTODEPEND


#
# Borland C++ tools
#
IMPLIB  = Implib
BCC     = Bcc +BccW16.cfg 
TLINK   = TLink
TLIB    = TLib
BRC     = Brc
TASM    = Tasm
#
# IDE macros
#
#
# External tools
#
CompileHLP = hc31.exe  # IDE Command Line: $NOSWAP $CAP MSG(HC312MSG) $EDNAME


#
# Options
#
IDE_LFLAGS =  -LC:\TC4.5\LIB
IDE_RFLAGS = 
LLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe =  -LH:\BC45\LIB -Twe -c -C
RLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe =  -31
BLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = 
CNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = -IH:\BC45\INCLUDE -D_RTLDLL;_BIDSDLL;
LNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = -x
LEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = $(LLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe)
REAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = $(RLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe)
BEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = $(BLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe)
CLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = 
LLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = 
RLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = 
BLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = 
CEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = $(CEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(CLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp)
CNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = -IH:\BC45\INCLUDE -D_RTLDLL;_BIDSDLL;
LNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = -x
LEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = $(LEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(LLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp)
REAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = $(REAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(RLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp)
BEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp = $(BEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(BLATW16_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudhlp)

#
# Dependency List
#
Dep_gomoku = \
   C:\FILES\CEE\WINDOWS\GOMOKU\gomoku.exe

gomoku : BccW16.cfg $(Dep_gomoku)
  echo MakeNode 

Dep_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe = \
   C:\FILES\CEE\WINDOWS\GOMOKU\gomoku.hlp\
   C:\TMP\gomoku.obj\
   C:\TMP\gomoku.res\
   gomoku.def

C:\FILES\CEE\WINDOWS\GOMOKU\gomoku.exe : $(Dep_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe)
  $(TLINK)   @&&|
 /v $(IDE_LFLAGS) $(LEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(LNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) +
H:\BC45\LIB\c0wl.obj+
C:\TMP\gomoku.obj
$<,$*
H:\BC45\LIB\bidsi.lib+
H:\BC45\LIB\import.lib+
H:\BC45\LIB\crtldll.lib
gomoku.def
|
   $(BRC) C:\TMP\gomoku.res $<

C:\FILES\CEE\WINDOWS\GOMOKU\gomoku.hlp :  gomoku.hpj
  $(CompileHLP)   C:\FILES\CEE\WINDOWS\GOMOKU\gomoku.hpj

C:\TMP\gomoku.obj :  gomoku.c
  $(BCC)   -P- -c @&&|
 $(CEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(CNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) -o$@ gomoku.c
|

C:\TMP\gomoku.res :  gomoku.rc
  $(BRC) $(IDE_RFLAGS) $(REAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) $(CNIEAT_CcbFILESbCEEbWINDOWSbGOMOKUbgomokudexe) -R -FO$@ gomoku.rc

# Compiler configuration file
BccW16.cfg : 
   Copy &&|
-R
-v
-vi
-H
-H=gomoku.csm
-ml
-H
-4
-f
-ff
-H-
-H= 
-ml
-WS
| $@


