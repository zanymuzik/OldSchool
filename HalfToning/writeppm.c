#include <stdio.h>
#include <string.h>

void
writeppm(unsigned char **output, int width, int height)
{
  FILE *filedes;

  char filename[20] = "Result.ppm";
  char garbage [20];
  int  x, y;

  unsigned char dummy;

  if ((filedes = fopen( filename, "w")) == 0)
    {
      printf("Error writting output file (%s) !!\n", filename);
      exit(0);
    }
  
  fprintf(filedes, "P6\n");
  fprintf(filedes, "# Halftoned Image\n");
  fprintf(filedes, "# Project Work - Gaurav & Mohit\n");
  fprintf(filedes, "%d %d\n", width, height);
  fprintf(filedes, "255\n");

  for(x = 0; x < height; x++)
    for(y = 0; y < width; y++)
      {
	if (output[x][y])
	  dummy = 255;
	else 
	  dummy = 0;
	
	fwrite(&dummy, 1, sizeof(char), filedes);
	fwrite(&dummy, 1, sizeof(char), filedes);
	fwrite(&dummy, 1, sizeof(char), filedes);
      }       
  
  fclose(filedes);
  printf("%s written successfully !!\n", filename);
}
































