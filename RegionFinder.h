//
//  RegionFinder.h
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ImageProcessor.h"

@interface RegionFinder : NSObject {
    int origin_x;
    int origin_y;
    float blockSize;
    IBOutlet NSImageView *imageView;
    CFMachPortRef *mouseClickEventTap;
    CFRunLoopSourceRef runLoopSource;
}

- (id) init;
- (void) dealloc;
- (int)ori_x;
- (int)ori_y;
- (float)bSize;

- (IBAction)locateRegion:(id)sender;

- (void)resetAll;
- (void)locateMain:(int) x :(int) y;

CGEventRef MyEventTapCallBack(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon);

@end
