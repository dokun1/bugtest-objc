//
//  BTSquare.h
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTSquare : UIView

/**
 *  creates a random square of size 100 anywhere on the screen
 *
 *  @return BTSquare object
 */
- (id)initRandomSquare;

/**
 *  creates a square of app specification, but at specified CGPoint of origin in superview
 *
 *  @param origin CGPoint of origin in superview
 *
 *  @return BTSquare object
 */
- (id)initWithOrigin:(CGPoint)origin;

/**
 *  creates a square according to JSON data
 *
 *  @param origin   CGPoint for origin of square in superview
 *  @param size     CGFloat depicting initial size of square length and width
 *  @param hexColor NSString for hex code of color (convert to UIColor)
 *
 *  @return BTSquare object
 */
- (id)initWithOrigin:(CGPoint)origin size:(CGFloat)size andHexColor:(NSString*)hexColor;

/**
 *  Makes the square disappear into the black hole
 */
- (void)makeDisappear;

/**
 *  Checks the boundaries of the square to see if it intersects with the black hole boundaries, will make it disappear if it does
 */
- (void)checkDisappearLogicForBlackHoleFrame;

@end
