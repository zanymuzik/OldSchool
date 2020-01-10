#include <stdlib.h>
#include <stdio.h>
#include <string.h>

unsigned char **
readimage(char *filename, int *width, int *height);

unsigned char **
readblocks(char blocksize);

void 
add_random_noise(unsigned char **image, int width, int height, int noisef);

unsigned char **
do_halftoning(unsigned char **image, unsigned char **blocks, int width, int height, char blocksize, int option);

void 
writeppm(unsigned char **image, int width, int height);

void 
main ( int argc, char *argv[])
{
  unsigned char **inputimage; 
  unsigned char **halftoned;
  unsigned char **blocks;
  int  width, height;

  char filename[50];
  int  option = 0;
  int  blocksize = 3;
  int  noisef = 20;
  int  count;

  if (argc < 3)
    {
      printf("USAGE: %s [-d] [-r] [-i] [-s BLOCKSIZE] -f FILENAME\n", argv[0]);
      exit(0);
    }
  
  for(count=1; count<argc; count++)
    {
      if (!strcmp(argv[count], "-d"))
	option = 1;
      
      if (!strcmp(argv[count], "-r"))
	{	
	  sscanf(argv[++count], "%d", &noisef);
	  option +=2;
	}

      if (!strcmp(argv[count], "-i"))
	option +=4;
       
      if (!strcmp(argv[count], "-f"))
	sscanf(argv[++count], "%s", filename);

      if (!strcmp(argv[count], "-s"))
	sscanf(argv[++count], "%d", &blocksize);
    }

  printf("Image (%s) Block Size (%d) ", filename, blocksize);

  if (option == 5)
    {
      printf("Dithering not possible with increased size. Exitting!!\n");
      exit(0);
    }

  if (option == 1)
    printf("with dithering.\n");
  else if (option %4 == 2)
    printf("with random noise addition(%d).\n", noisef);
  else printf("without dithering or random noise addition.\n");
 
  if (option / 4)
    printf("Size Increased.\n");
  else
    printf("Preserving Size.\n");
 
  inputimage = readimage(filename, &width, &height); 
  blocks     = readblocks(blocksize);
 
  if (option %4 == 2)
    add_random_noise(inputimage, width, height, noisef);

  halftoned = do_halftoning(inputimage, blocks, width, height, blocksize, option);

  if (option / 4)
    writeppm(halftoned, blocksize*width, blocksize*height);
  else
    writeppm(halftoned, width, height);

  system("imgview Result.ppm");
}





