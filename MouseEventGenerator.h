//
//  MouseEventGenerator.h
//  strokeMonkey
//
//  Created by y on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MouseEventGenerator : NSObject {
  CGFloat x;
  CGFloat y;
}

-(void) generateEvent: (CGEventType) t: (CGMouseButton) b;
-(void) setPos: (CGFloat) px: (CGFloat) py;
-(void) leftClick;
-(void) rightClick;
-(void) move;

@end
