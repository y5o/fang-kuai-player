//
//  MouseEventGenerator.m
//  strokeMonkey
//
//  Created by y on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MouseEventGenerator.h"


@implementation MouseEventGenerator

-(void) setPos: (CGFloat) px: (CGFloat) py
{
  x = px;
  y = py;
}

-(void) generateEvent: (CGEventType) t: (CGMouseButton) b
{
  CGPoint p = {
    x,y
  };
  CGEventRef mouseEvent = CGEventCreateMouseEvent (NULL, t, p, b);

  CGEventPost(kCGHIDEventTap, mouseEvent);
  
  CFRelease(mouseEvent);
}

-(void) leftClick
{
  [self move];
  [self generateEvent:kCGEventLeftMouseDown: kCGMouseButtonLeft];
  [self generateEvent:kCGEventLeftMouseUp: kCGMouseButtonLeft];
}

-(void) rightClick
{
  [self move];
  [self generateEvent:kCGEventRightMouseDown: kCGMouseButtonRight];
  [self generateEvent:kCGEventRightMouseUp: kCGMouseButtonRight];
}

-(void) move
{
  [self generateEvent:kCGEventMouseMoved :kCGMouseButtonLeft];
}
@end
