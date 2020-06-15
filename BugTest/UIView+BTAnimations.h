//
//  UIView+BTAnimations.h
//  BugTestT
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTSquare.h"

typedef void (^BTAnimationCompleteCallBackBlock)(BOOL complete);

@interface UIView (BTAnimations)

/**
 *  Makes a given square object disappear into the black hole from wherever it is
 *
 *  @param completionHandler Block callback to make changes on main view controller (removing square from superview, remove from array, etc.)
 */
- (void)disappearIntoBlackHoleWithCompletion:(BTAnimationCompleteCallBackBlock)completionHandler;

@end
