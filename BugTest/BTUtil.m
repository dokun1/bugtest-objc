//
//  BTUtil.m
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import "BTUtil.h"
#import "BTSquare.h"

@implementation BTUtil

+ (CGRect)getMainWindowSize {
  return [[UIScreen mainScreen] bounds];
}

+ (CGPoint)getRandomSquareOriginForSize:(CGFloat)size {
  NSUInteger x = arc4random_uniform(319 - size) + 1;
  NSUInteger y = arc4random_uniform([self getMainWindowSize].size.height - (size+1)) + 1;
  return CGPointMake(x, y);
}

+ (NSArray*)getInitialArrayOfSquaresFromJSON {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"initialLayout" ofType:@"json"];
  NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
  NSError *error = nil;
  NSDictionary *result = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:jsonData
                                              options:kNilOptions
                                                error:&error];
  if (error) {
    return nil;
  }  
  NSMutableArray *array = [NSMutableArray array];
  [result enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    NSArray *squareDataArray = (NSArray*)obj;
    [squareDataArray enumerateObjectsUsingBlock:^(NSDictionary *squareObject, NSUInteger idx, BOOL *stop) {
      double x = [squareObject[@"x"] doubleValue];
      double y = [squareObject[@"y"] doubleValue];
      double size = [squareObject[@"size"] doubleValue];
      NSString *colour = squareObject[@"colour"];
      BTSquare *square = [[BTSquare alloc] initWithOrigin:CGPointMake(x, y) size:size andHexColor:colour];
      [array addObject:square];
    }];
  }];
  return array;
}

+ (CGFloat)distanceOfPointFromBlackHoleCenter:(CGPoint)point {
  CGFloat distance;
  
  CGPoint blackHoleCenter = CGPointMake(60, [self getMainWindowSize].size.height);
  CGFloat xDiff = point.x - blackHoleCenter.x;
  CGFloat yDiff = point.y - blackHoleCenter.y;
  
  distance = sqrt((xDiff * xDiff) + (yDiff * yDiff));
  
  return distance;
}

+ (CGRect)blackHoleFrame {
  return CGRectMake(CGRectGetMinX([self getMainWindowSize]) + 10, CGRectGetMaxY([self getMainWindowSize]) - 110, 100, 100);
}

@end
