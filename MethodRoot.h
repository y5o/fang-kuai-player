//
//  MethodRoot.h
//  fangKuaiPlayer
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MethodRoot : NSObject {
  int total;
  int remain;
  int mat[15][23];
  int steps;
  int arr[200];
}

- (int)total;
- (int)remain;
- (int)steps;
- (int *)arr;

- (void)setAll: (int [15][23]) inMat;
- (void)testRun;
- (int) bricksToRemoveAtI: (int) x J:(int) y;

@end
