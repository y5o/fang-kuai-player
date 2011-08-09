//
//  ImageProcessor.m
//  fangKuaiPlayer
//
//  Created by y on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageProcessor.h"


@implementation ImageProcessor

-(NSImage *)capture : (CGRect) rect
{
  // get the whole image
  CGDirectDisplayID displayID = CGMainDisplayID();
  
/*  CGFloat llx = 302.5;
  CGFloat lly = 350;
  CGFloat w = 879-302;
  CGFloat h = 655 - 280;
*/  
  CGImageRef image = CGDisplayCreateImageForRect(displayID, rect);
  NSBitmapImageRep *temp = [[NSBitmapImageRep alloc] initWithCGImage:image];
  
  NSImage *im = [[NSImage alloc] init];
  [im addRepresentation:temp];
  
  [temp autorelease];
  CGImageRelease(image);
  return [im autorelease];
  /*
  // no use any more
  NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithCGImage:image];
  CGImageRelease(image);
  NSColor *color = [bitmap colorAtX:x y:y];
  [bitmap release];
  */
}

- (void)setAll:(int) x :(int) y
{
  CGDirectDisplayID displayID = CGMainDisplayID();
  int screenH = CGDisplayPixelsHigh(displayID);
  int screenW = CGDisplayPixelsWide(displayID);
  NSImage *screenWhole = [self capture:CGRectMake(0, 0, screenW, screenH)];
  
  NSBitmapImageRep* rawWhole = [NSBitmapImageRep imageRepWithData:[screenWhole TIFFRepresentation]];
  CGFloat hue, sat, bright, alpha; 
  int left=0, up=0,down=0;
  int lColorCode = 0, uColorCode = 0, dColorCode = 0;
  NSColor *color = [rawWhole colorAtX:x y:y];
  [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
  int clickColorCode = [self colorCode:hue :sat :bright];
  
  for (int i = x-1; i >=0 ; --i)
  {
    color = [rawWhole colorAtX:i y:y];
    [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    lColorCode = [self colorCode:hue :sat :bright];
    if (lColorCode != clickColorCode)
    {
      left = i;
      break;
    }
  }
  for (int i = y-1; i >=0 ; --i)
  {
    color = [rawWhole colorAtX:x y:i];
    [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    uColorCode = [self colorCode:hue :sat :bright];
    if (uColorCode != clickColorCode)
    {
      up = i;
      break;
    }
  }
  for (int i = y+1; i <= screenH ; ++i)
  {
    color = [rawWhole colorAtX:x y:i];
    [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    dColorCode = [self colorCode:hue :sat :bright];
    if (dColorCode != clickColorCode)
    {
      down = i;
      break;
    }
  }
  int blockSizeTotal = down - up;
  blockSize = down - up;
  int blocks = 10;
  int tempColorCode = dColorCode;
  int new_up = down;
  
  while (blocks-- > 0)
  {
    // NSLog(@"edge y %d",new_up);
    color = [rawWhole colorAtX:x y:new_up+floor(blockSize/2.0)];
    [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    tempColorCode = [self colorCode:hue :sat :bright];
    
    for (int i = new_up+floor(blockSize/2.0)+1; i <= screenH ; ++i)
    {
      color = [rawWhole colorAtX:x y:i];
      [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
      dColorCode = [self colorCode:hue :sat :bright];
      if (dColorCode != tempColorCode)
      {
        down = i;
        break;
      }
    }
    // NSLog(@"temp block size: %d", down - new_up);
    blockSizeTotal += (down-new_up);
    new_up = down;  
  }
  blockSize = blockSizeTotal/11.0;
  origin_x = left;
  origin_y = up;
}

// note this is different with the one in main player
- (int)colorCode: (CGFloat) h :(CGFloat) s :(CGFloat) v
{
  /* 
   Name            H         S         V
   white           0         0         0.96
   light gray      0         0         0.92
   dark gray       0         0         0.7-0.87
   dark purple     0.833    .12-.46    1
   light purple    0.833    .1-.5      .8-.9
   dark blue       0.6      .2-1       1
   light blue      0.5      .1-.5      .8-.9
   green           0.333    .2-1       .8-.9
   orange          .09-.1   .26-1      1
   red             1        .2-.6      1
   yellow-green    .16667   .1-.5      .8-.92
   brown           .0833    .2-1       .8-.92
   */
  if (h < 0.01)
  {
    if (v > 0.94)
    {
      return 0;  // white
    }
    else if (v > 0.9)
    {
      return -1; // light gray
    }
    else
    {
      return 1; // dark gray
    }
  }
  else if (h < 0.085)
  {
    return 2; // brown
  }
  else if (h < 0.12)
  {
    return 3; // orange
  }
  else if (h < 0.2)
  {
    return 4; // yellow green
  }
  else if (h < 0.4)
  {
    return 5; // green
  }
  else if (h < 0.55)
  {
    return 6; // light blue
  }
  else if (h < 0.7)
  {
    return 7; // dark blue
  }
  else if (h > 0.9)
  {
    return 8; // red
  }
  else if (v > 0.95)
  {
    return 9; // light purple
  }
  else
  {
    return 10; // dark purple
  }
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
