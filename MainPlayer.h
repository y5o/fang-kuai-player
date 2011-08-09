//
//  MainPlayer.h
//
//  Created by y on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MouseEventGenerator.h"
#import "ImageProcessor.h"
#import "RowMethod.h"
#import "ColumnMethod.h"
#import "RandomMethod.h"
#import "RegionFinder.h"

@interface MainPlayer : NSObject {
  IBOutlet RegionFinder *theRegion;
  IBOutlet NSImageView *imageView;
  IBOutlet NSSlider *speedSlider;
  int mat[15][23];
  float speed;
}
- (IBAction)startPlay:(id)sender;
- (IBAction)changeSpeed:(id)sender;
- (void)fillMat:(NSImage *)image;
- (void)doClicks;
- (int)colorCode: (CGFloat) h :(CGFloat) s :(CGFloat) v;

@end
