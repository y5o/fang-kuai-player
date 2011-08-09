//
//  ImageProcessor.h
//  fangKuaiPlayer
//
//  Created by y on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ImageProcessor : NSObject {
  int origin_x;
  int origin_y;
  float blockSize;
}

-(void)setAll:(int) x :(int) y;
-(NSImage *)capture:(CGRect) rect;
- (int)colorCode: (CGFloat) h :(CGFloat) s :(CGFloat) v;

- (int)ori_x;
- (int)ori_y;
- (float)bSize;

@end
