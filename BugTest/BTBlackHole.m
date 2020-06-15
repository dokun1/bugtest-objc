//
//  BTBlackHole.m
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import "BTBlackHole.h"
#import "BTUtil.h"

@implementation BTBlackHole

- (id)init {
  if (self = [super init]) {
    [self setBounds:CGRectMake(0, 0, 100, 100)];
    CGRect superviewFrame = [BTUtil getMainWindowSize];
    [self setFrame:CGRectMake(CGRectGetMinX(superviewFrame) + 10, CGRectGetMaxY(superviewFrame) - 110, 100, 100)];
    [self.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.layer setBorderWidth:1.f];
    [self.layer setCornerRadius:50.f];
  }
  return self;
}

@end
