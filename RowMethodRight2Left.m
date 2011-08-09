//
//  RowMethodRight2Left.m
//  fangKuaiPlayer
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RowMethodRight2Left.h"


@implementation RowMethodRight2Left

- (void) testRun
{
  int old_remain = 0;
  
  while (remain != old_remain)
  {
    old_remain = remain;
    for (int i = 14; i >=0 && remain > 0; ++i)
    {  
      for (int j = 0; j < 23 && remain > 0; ++j)
      {
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
