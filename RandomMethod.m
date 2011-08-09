//
//  RandomMethod.m
//  fangKuaiPlayer
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RandomMethod.h"


@implementation RandomMethod

- (void) testRun
{
  int wasteCount = 0;
  int i,j,toRemove;
  while (wasteCount++ < 15*23*2 && remain > 0)
  {
    i = arc4random()%15;
    j = arc4random()%22;
    toRemove = (mat[i][j] == 0) ? [self bricksToRemoveAtI:i J:j] :0;
    if (toRemove!= 0)
    {
      remain -= toRemove;
      
      arr[2*steps] = i;
      arr[2*steps+1] = j;
      steps++;
      wasteCount = 0;
    }    
  }
  // NSLog(@"Random remain: %d",remain);
}

@end
