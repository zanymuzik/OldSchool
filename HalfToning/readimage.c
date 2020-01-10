#include <stdio.h>
#include <string.h>

unsigned char** 
readimage(char *filename, int *width, int *height)
{
  FILE *filedes;
  unsigned char **result;
  
  int  x, y;
  unsigned char pixelR, pixelG, pixelB;

  char garbage [20];

  if ((filedes = fopen( filename, "r")) == 0)
    {
      printf("Error opening the Image (%s) !! \n", filename);
      exit(0);
    }
  
  fscanf(filedes, "%s", garbage);
  if (strncmp(garbage, "P6", 2))
    {
      printf("Unreadable or Unsupported ppm Format (%s) !! \n", garbage);
      exit(0);
    }  
      
  do
    fscanf(filedes, "%s", garbage);
  while (strncmp(garbage, "6", 1));
      
  fscanf(filedes, "%d %d", width, height);
  fscanf(filedes, "%s", garbage);

  printf("Width = %d, Height = %d, Max Colors = %s", *width, *height, garbage);
      
  result = (unsigned char **)malloc((*height) * sizeof(char *));
  for(x = 0; x < *height; x++)
    {
      result[x] = (unsigned char *)malloc((*width) * sizeof(char));
      for(y = 0; y < *width; y++)
	{
	  fread(&pixelR, 1, sizeof(char), filedes);
	  fread(&pixelG, 1, sizeof(char), filedes);
	  fread(&pixelB, 1, sizeof(char), filedes);
	  
	  result[x][y] = (unsigned char)((pixelR + pixelG + pixelB) /3);
	}       
    }

  fclose(filedes);
  printf("....DONE !!\n");

  return result;
}

unsigned char**
readblocks(char blocksize)
{
  FILE *filedes;
  char filename[15];
  int  x, y, temp;

  unsigned char **result;
  
  filename[0] = blocksize + '0';
  strncpy(filename +1, ".dot\0", 5);

  if ((filedes = fopen(filename, "r")) == 0)
    {
      printf("Error reading the block file (%s) for blocksize=%d !!\n", filename, blocksize);
      exit(0);
    }
  
  result = (unsigned char **)malloc(blocksize * sizeof(int *));

  for(x=0; x<blocksize; x++)
    {
      result[x] = (unsigned char *)malloc(blocksize * sizeof(int));
      for(y=0; y<blocksize; y++)
	{
	  fscanf(filedes, "%d", &temp);
	  result[x][y] = temp;
	}
    }
  
  fclose(filedes);

  /*
    printf("Successfully read the block file (%s) for blocksize (%d)\n", filename, blocksize);
  */
  
  return result;
}


























