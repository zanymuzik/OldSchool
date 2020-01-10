#include <stdlib.h>
#include <stdio.h>

unsigned char **
do_halftoning(unsigned char **image,unsigned char **blocks, int width, int height, char blocksize, int option)
{
  unsigned char **result;
  float pixelval;
  int segpoint;
  int newh=height, neww=width;
  int x, y , i ,j;
  int count = 0;

  if (option /4) /* size increase option */
    {
      newh *= blocksize;
      neww *= blocksize;
    }

  result = (unsigned char **)malloc(newh * sizeof(char *));
  for(i = 0; i < newh; i++)
    result[i] = (unsigned char *)malloc(neww * sizeof(char));

  for(x=0; x<height; x++)
    for(y=0; y<width; y++)

      if (option == 1) /*dither only*/
	{
	  pixelval = image[x][y];
	  segpoint = (int)((pixelval * (blocksize*blocksize +1) -1) / 255.0);

	    if (blocks[x % blocksize][j % blocksize] > segpoint)
	      result[x][y] = 0;
	    else
	      result[x][y] = 1;
	}
      else if (option /4) /*size increase*/
	{
	  pixelval = image[x][y];
	  segpoint = (int)((pixelval * (blocksize*blocksize +1) -1) / 255.0);

	  for(i=0; i<blocksize; i++)
	    for(j=0; j<blocksize; j++)
	      if (blocks[i][j] > segpoint)
		result[blocksize*x +i][blocksize*y +j] = 0;
	      else
		result[blocksize*x +i][blocksize*y +j] = 1;
	}
      else if (!(x % blocksize) && !(y % blocksize))  /* no size increase*/
	{
	  pixelval=0;
	  count   =0;

	  for(i=0; i<blocksize; i++)
	    for(j=0; j<blocksize; j++)
	      if ((x+i < height) && (y+j < width))
		{
		  pixelval += image[x+i][y+j];
		  count++;
		}

	  pixelval /= count;
	
	  segpoint = (int)((pixelval * (blocksize*blocksize +1) -1) / 255.0);
	  
	  for(i=0; i<blocksize; i++)
	    for(j=0; j<blocksize; j++)
	      if ((x+i < newh) && (y+j < neww))
		if (blocks[i][j] > segpoint)
		    result[x +i][y +j] = 0;
		  else
		    result[x +i][y +j] = 1;
	}

  return result;
}







