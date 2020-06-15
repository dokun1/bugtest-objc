//
//  UIView+BTAnimations.m
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import "UIView+BTAnimations.h"
#import "BTUtil.h"

@implementation UIView (BTAnimations)

- (void)disappearIntoBlackHoleWithCompletion:(BTAnimationCompleteCallBackBlock)completionHandler {
  [UIView animateWithDuration:0.5
                        delay:0.01
       usingSpringWithDamping:0.5
        initialSpringVelocity:0.6
                      options:UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2)];
                     [self setCenter:CGPointMake(60, [BTUtil getMainWindowSize].size.height - 60)];
                   } completion:^(BOOL finished) {
                     [UIView animateWithDuration:0.5
                                      animations:^{
                                        [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01)];
                                        [self setAlpha:0.0f];
                                      } completion:^(BOOL finished) {
                                        completionHandler(finished);
                                      }];
                   }];
}

@end
