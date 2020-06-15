//
//  NSString+BTColorUtil.h
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BTColorUtil)

/**
 *  Get UIColor from Hex String
 *
 *  @return UIColor for given hex code
 */
- (UIColor*)getColorFromHexCode;

@end
