//
//  UIColor+BTColorUtil.h
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BTColorUtil)

/**
 *  Gets a random color that is not too light so that it is easily visible on the view
 *
 *  @return UIColor that is visible on the white background
 */
+ (UIColor*)randomColor;

@end
