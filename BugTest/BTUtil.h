//
//  BTUtil.h
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTUtil : NSObject

/**
 *  Gets the screen size of the phone you are using
 *
 *  @return CGRect that is the main screen size
 */
+ (CGRect)getMainWindowSize;

/**
 *  Gets a random point within the screen that will be acceptable to place a new random square, given the size of the square
 *
 *  @param size CGFloat depicting size of given square
 *
 *  @return CGPoint acceptable for origin of new random square given size
 */
+ (CGPoint)getRandomSquareOriginForSize:(CGFloat)size;
/**
 *  Returns an NSArray of BTSquare objects as defined by JSON layout document
 *
 *  @return NSArray of BTSquare objects
 */
+ (NSArray*)getInitialArrayOfSquaresFromJSON;

/**
 *  Gets distance between CGPoint passed in and center of constant black hole
 *
 *  @param point CGPoint to check for distance from black hole center
 *
 *  @return CGFloat of distance. If a point's distance from center is 50 or less, it needs to be sucked in
 */
+ (CGFloat)distanceOfPointFromBlackHoleCenter:(CGPoint)point;

/**
 *  Gets the constant black hole frame
 *
 *  @return CGRect depicting the black hole frame in the superview
 */
+ (CGRect)blackHoleFrame;
@end
