//
//  RowMethodLeft2Right.h
//  fangKuaiPlayer
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MethodRoot.h"

@interface RowMethod : MethodRoot 
{
  int savedMat[15][23];
}

- (void) testRun;
- (void) saveMat;
- (void) runOnce:(int *)ivec :(int *)jvec;

@end
