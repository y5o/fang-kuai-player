//
//  RegionFinder.m
//
//  Created by y on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegionFinder.h"

@implementation RegionFinder

- (id) init
{
  self = [super init];
  if (self != nil)
  {
    origin_x = 0;
    origin_y = 0;
    blockSize = 0.0;
    
    mouseClickEventTap = CGEventTapCreate (kCGSessionEventTap,
                                           kCGHeadInsertEventTap,
                                           // kCGEventTapOptionDefault,
                                           kCGEventTapOptionListenOnly,
                                           CGEventMaskBit(kCGEventLeftMouseDown),
                                           MyEventTapCallBack,
                                           self);
    if (mouseClickEventTap == NULL)
    {
      // NSLog(@"cannot create event tap!");
    }
    else
    {
      // NSLog(@"event tap created successfully");
    }
    CGEventTapEnable(mouseClickEventTap, false);
    
    runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, mouseClickEventTap, 0);
  }
  return self;
}

- (IBAction)locateRegion:(id)sender 
{
  CGEventTapEnable(mouseClickEventTap, true);
  CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource,
                     kCFRunLoopCommonModes); 
}

- (void) resetAll
{
  CGEventTapEnable(mouseClickEventTap, false);
  if (CFRunLoopContainsSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes))
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);  
}

// callback function
CGEventRef MyEventTapCallBack(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon)
{
  RegionFinder *selfPtr = refcon;

  if (type == kCGEventLeftMouseDown)
  {
    // NSLog(@"invoked! LMD: type: %X",type);
    
    CGPoint eventLocation = CGEventGetLocation(event);
    
    // NSLog(@"Click location: x is %d, y is %d", lroundf(eventLocation.x), lroundf(eventLocation.y));
    
    [selfPtr locateMain: lroundf(eventLocation.x) :lroundf(eventLocation.y)];
    
    [selfPtr resetAll];
  }
  else // disable message
  {
    // NSLog(@"invoked! type: %X",type);
  }
  return NULL;  
}

- (void)locateMain:(int) x :(int) y
{
  ImageProcessor *p = [[ImageProcessor alloc] init];
  [p setAll:x:y];
  
  origin_x = [p ori_x];
  origin_y = [p ori_y];
  blockSize = [p bSize];
  
  // NSLog(@"origin: %d,%d,size: %f", origin_x, origin_y,blockSize);
                                                              
  NSImage *im = [p capture:CGRectMake(origin_x, origin_y, 23*blockSize, 15*blockSize)];
  
  [imageView setImage:im];
   
  [p release];
  
}

- (void)dealloc
{
  CGEventTapEnable(mouseClickEventTap, false);
  if (CFRunLoopContainsSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes))
  {
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), runLoopSource,
                       kCFRunLoopCommonModes);    
  }
  CFRelease(mouseClickEventTap);
  [super dealloc];
}

- (int)ori_x 
{
  return origin_x;
}
- (int)ori_y
{
  return origin_y;
}

- (float)bSize
{
  return blockSize;
}

@end
