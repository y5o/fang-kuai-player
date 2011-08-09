//
//  ColumnMethod.m
//  fangKuaiPlayer
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ColumnMethod.h"


@implementation ColumnMethod

- (void) testRun
{
  int ivec1[15] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14};
  int ivec2[15] = {14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
  int jvec1[23] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22};
  int jvec2[23] = {22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
  
  [self saveMat];
  
  int minCase = 1;
  int minRemain;
    // case 1
  [self runOnce:ivec1 :jvec1];
  minRemain = remain;
  //NSLog(@"case 1 remain: %d",remain);
  [self setAll:savedMat];
  
    // case 2
  [self runOnce:ivec1 :jvec2];
  minRemain = remain < minRemain ? remain : minRemain;
  minCase = remain <= minRemain ? 2 : minCase;
  // NSLog(@"case 2 remain: %d",remain);
  [self setAll:savedMat];
  
    // case 3
  [self runOnce:ivec2 :jvec1];
  minRemain = remain < minRemain ? remain : minRemain;
  minCase = remain <= minRemain ? 3 : minCase;
  // NSLog(@"case 3 remain: %d",remain);
  [self setAll:savedMat];
  
    // case 4
  [self runOnce:ivec2 :jvec2];
  minRemain = remain < minRemain ? remain : minRemain;
  minCase = remain <= minRemain ? 4 : minCase;
  // NSLog(@"case 4 remain: %d",remain);
  [self setAll:savedMat];
  
  switch (minCase)
  {
    case 1:
      [self runOnce:ivec1 :jvec1];
      break;
    case 2:
      [self runOnce:ivec1 :jvec2];
      break;
    case 3:
      [self runOnce:ivec2 :jvec1];
      break;
    case 4:
      [self runOnce:ivec2 :jvec2];
      break;
    default:
      break;
  }
}

- (void) saveMat
{
  for (int i = 0; i < 15; ++i)
  {  
    for (int j = 0; j < 23; ++j)
    {
      savedMat[i][j] = mat[i][j];
    }
  } 
}

- (void) runOnce:(int *) ivec :(int *) jvec
{ 
  
  int old_remain = 0;
  int i,j;
  while (remain != old_remain)
  {
    old_remain = remain;
    for (int n = 0; n < 23 && remain > 0; ++n)
    {  
      j = jvec[n];
      for (int m = 0; m < 15 && remain > 0; ++m)
      {
        i = ivec[m];
        int toRemove = (mat[i][j] == 0) ? [self bricksToRemoveAtI:i J:j] :0;
        if (toRemove!= 0)
        {
          remain -= toRemove;
          
          arr[2*steps] = i;
          arr[2*steps+1] = j;
          steps++;
        }
      }
    }
  }
}
@end

