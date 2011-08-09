  //
  //  MainPlayer.m
  //
  //  Created by y on 8/4/11.
  //  Copyright 2011 __MyCompanyName__. All rights reserved.
  //

#import "MainPlayer.h"


@implementation MainPlayer

- (IBAction)changeSpeed: (id) sender
{
  speed = [sender floatValue];
}

- (IBAction)startPlay:(id)sender 
{
  if ([theRegion bSize] < 1.0) // click to find region first
  {
    return;
  }
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  MouseEventGenerator *m = [[MouseEventGenerator alloc] init];
  ImageProcessor *p = [[ImageProcessor alloc] init];
  
  speed = [speedSlider floatValue];
  
  NSImage *im = [imageView image];
  
  [m setPos:[theRegion ori_x]-[theRegion bSize]/2.0:[theRegion ori_y]-[theRegion bSize]/2.0];
  [m leftClick];
  sleep(1);
  
  im = [p capture:CGRectMake([theRegion ori_x], [theRegion ori_y], 23*[theRegion bSize], 15*[theRegion bSize])];
  
  [imageView setImage:im];

  [self fillMat:im];

  [self doClicks];
  
  [p release];
  [m release];
  [pool drain];
}

- (void)fillMat:(NSImage *) image
{
  NSBitmapImageRep* raw = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
  
  // NSInteger w = [raw pixelsWide];
  // NSInteger h = [raw pixelsHigh];
  // NSLog(@"the pixel width is %ld, and the height is %ld",w,h);
  NSColor* color;
    // [raw setColor:[NSColor blackColor] atX:13 y:12];
  /* 
   // find out the hsv values in one square
   int x = 0*25;
   int y = 3*25;
   int i = x+12;
   for (int j = y; j < y+25; ++j)
   {  
   color = [raw colorAtX:i y:j];
   CGFloat hue, sat, bright, alpha; 
   [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
   NSLog(@"HSBA at x=%ld,y=%ld are %f,%f,%f,%f",i,j,hue,sat,bright,alpha);
   } */
  
  CGFloat hue, sat, bright, alpha; 
  float blockSize = [theRegion bSize];
  
  for (int i = 0; i < 15; ++i)
    for (int j = 0; j < 23; ++j)
    {
      color = [raw colorAtX:lroundf(j*blockSize+blockSize/2) y:lroundf(i*blockSize+blockSize/2)];
      if (color == nil)
        NSLog(@"out of range?");
      [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
      
      mat[i][j] = [self colorCode:hue :sat :bright];
    }
  
  // log the result
  /*
  for (int i = 0; i < 15; ++i)
  {  
    for (int j = 0; j < 23; ++j)
    {
      printf("%3d",mat[i][j]);
    }
    printf("\n");
  }
  */
}

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
    if (v > 0.9)
    {
      return 0;  // background
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

- (void)doClicks
{
  MouseEventGenerator *m = [[MouseEventGenerator alloc] init];
  RowMethod *algo1 = [[RowMethod alloc] init];
  ColumnMethod *algo2 = [[ColumnMethod alloc] init];
  
  RandomMethod *rand1 = [[RandomMethod alloc] init];
  
  [algo1 setAll:mat];
  [algo1 testRun];
  [algo2 setAll:mat];
  [algo2 testRun];
  [rand1 setAll:mat];
  [rand1 testRun];
  
  id algoBest = ([algo1 remain] < [algo2 remain]) ? algo1 : algo2;
  
  if ([algoBest remain] > 0)
  {
    int cycleNum = 0;
    while ([rand1 remain] > 0 && cycleNum++ < 1000)
    {
      [rand1 setAll:mat];
      [rand1 testRun];    
    }
    // NSLog(@"random tries: %d", cycleNum);
  }
  algoBest = ([algoBest remain] < [rand1 remain]) ? algoBest : rand1;
  
  int x = [theRegion ori_x];
  int y = [theRegion ori_y];
  float blockSize = [theRegion bSize];
  
  for (int k = 0; k < [algoBest steps]; ++k)
  {
    int *arr = [algoBest arr];
    int i = arr[2*k];
    int j = arr[2*k+1];
    [m setPos:x+j*blockSize+blockSize/2 :y+i*blockSize+blockSize/2];
    [m leftClick];
    usleep(speed*1000000);
  }
  [m release];
  [algo1 release];
  [algo2 release];
  [rand1 release];
}

@end
