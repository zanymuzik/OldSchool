#include <stdlib.h>
#include <stdio.h>

void 
add_random_noise(unsigned char **image, int width, int height, int noisef)
{
  int seed;
  int i,j;

  for(i=0; i<height; i++)
    for(j=0; j<width; j++)
      if ((image[i][j]>noisef) && (image[i][j]<255 -noisef))
	image[i][j] += (char)(noisef*((char)rand() - 127)/255);
}

