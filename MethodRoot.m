//
//  MethodRoot.m
//  fangKuaiPlayer
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MethodRoot.h"


@implementation MethodRoot

- (int)total
{
  return total;
}

- (int)remain
{
  return remain;
}

- (int)steps
{
  return steps;
}

- (int *)arr
{
  return arr;
}

- (void) setAll:(int [][23]) inMat
{
  total = 0;
  for (int i = 0; i < 15; ++i)
  {  
    for (int j = 0; j < 23; ++j)
    {
      mat[i][j] = inMat[i][j];
      if (inMat[i][j] != 0)
      {
        total++;
      }
    }
  }
  remain = total;
  steps = 0;
}


- (void) testRun
{
  
}

- (int) bricksToRemoveAtI: (int) x J:(int) y
{
  int up = 0,down = 0,left = 0,right = 0;
  int ui = 0,di = 0,li = 0,ri = 0;
  for (int i = x-1; i >= 0; --i)
  {
    if (mat[i][y] != 0)
    {
      up = mat[i][y];
      ui = i;
      break;
    }
  }
  for (int i = x+1; i < 15; ++i)
  {
    if (mat[i][y] != 0)
    {
      down = mat[i][y];
      di = i;
      break;
    }
  }
  for (int i = y-1; i >= 0; --i)
  {
    if (mat[x][i] != 0)
    {
      left = mat[x][i];
      li = i;
      break;
    }
  }
  for (int i = y+1; i < 23; ++i)
  {
    if (mat[x][i] != 0)
    {
      right = mat[x][i];
      ri = i;
      break;
    }
  }
  
  int count = 0;
  
  if (up == down)
  {
    if (left == up)
    {
      if (right == up)
      {
        if (up != 0)
        {
          count = 4;
          mat[ui][y] = 0;
          mat[di][y] = 0;
          mat[x][li] = 0;
          mat[x][ri] = 0;
        }
      }
      else
      {
        if (up != 0)
        {
          count = 3;
          mat[ui][y] = 0;
          mat[di][y] = 0;
          mat[x][li] = 0;
        }      
      }
    }
    else
    {
      if (right == up)
      {
        if (up != 0)
        {
          count = 3;
          mat[ui][y] = 0;
          mat[di][y] = 0;
          mat[x][ri] = 0;
        }      
      }
      else if (right == left)
      { 
        if (up != 0)
        {
          count += 2;
          mat[ui][y] = 0;
          mat[di][y] = 0;
        }
        if (right != 0)
        {
          count += 2;
          mat[x][li] = 0;
          mat[x][ri] = 0;
        }
      }
      else
      {
        if (up != 0)
        {
          count = 2;
          mat[ui][y] = 0;
          mat[di][y] = 0;
        }
      }
    }
  }
  else
  {
    if (left == up)
    {
      if (right == up)
      {
        if (up != 0)
        {
          count = 3;
          mat[ui][y] = 0;
          mat[x][li] = 0;
          mat[x][ri] = 0;
        }      
      }
      else if (right == down)
      {
        if (up != 0)
        {
          count += 2;
          mat[ui][y] = 0;
          mat[x][li] = 0;
        }
        if (down != 0)
        {
          count += 2;
          mat[di][y] = 0;
          mat[x][ri] = 0;
        }
      }
      else
      {
        if (up != 0)
        {
          count = 2;
          mat[ui][y] = 0;
          mat[x][li] = 0;
        }
      }
    }
    else
    {
      if (left == down)
      {
        if (right == down)
        {
          if (down != 0)
          {
            count = 3;
            mat[di][y] = 0;
            mat[x][li] = 0;
            mat[x][ri] = 0;
          }        
        }
        else if (right == up)
        {
          if (up != 0)
          {
            count += 2;
            mat[ui][y] = 0;
            mat[x][ri] = 0;
          }
          if (down != 0)
          {
            count += 2;
            mat[di][y] = 0;
            mat[x][li] = 0;
          }
        }
        else
        {
          if (down != 0)
          {
            count = 2;
            mat[di][y] = 0;
            mat[x][li] = 0;
          }        
        }
      }
      else
      {
        if (right == up)
        {
          if (up != 0)
          {
            count = 2;
            mat[ui][y] = 0;
            mat[x][ri] = 0;
          }
        }
        else if (right == down)
        {
          if (down != 0)
          {
            count = 2;
            mat[di][y] = 0;
            mat[x][ri] = 0;
          }        }
        else if (right == left)
        {
          if (left != 0)
          {
            count = 2;
            mat[x][li] = 0;
            mat[x][ri] = 0;
          }
        }
      }
    }
  }
  // printf("current: %d, %d,UDLR,%d,%d,%d,%d,UDLR,%d,%d,%d,%d\n",y,x,up,down,left,right,ui,di,li,ri);
  return count;
}

@end
