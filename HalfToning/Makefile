CC = cc
FLAGS = -g -O2
OBJS = readimage.o halftoning.o noise.o writeppm.o main.o

%.o:%.c
	$(CC) -c $(@:.o=.c)

all  : $(OBJS) 
	$(CC) $(FLAGS) -o halftone $(OBJS)

clean:
	rm -f *.o core halftone Result.ppm

etags:
	etags *.c 
