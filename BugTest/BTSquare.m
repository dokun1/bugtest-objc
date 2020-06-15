//
//  BTSquare.m
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import "BTSquare.h"
#import "BTUtil.h"
#import "UIColor+BTColorUtil.h"
#import "NSString+BTColorUtil.h"
#import "UIView+BTAnimations.h"


@interface BTSquare () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapGestureRecognizer;

@end

@implementation BTSquare

#pragma mark - init methods

- (id)initRandomSquare {
    if (self = [super init]) {
        [self setBounds:CGRectMake(0, 0, 100, 100)];
        CGPoint randomOrigin = [BTUtil getRandomSquareOriginForSize:100];
        [self setFrame:CGRectMake(randomOrigin.x, randomOrigin.y, 100, 100)];
        [self.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [self.layer setBorderWidth:1.f];
        self.backgroundColor = [UIColor randomColor];
        
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerActivated:)];
        [self.panGestureRecognizer setDelegate:self];
        [self addGestureRecognizer:self.panGestureRecognizer];
        
        self.doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureRecognizerActivated:)];
        [self.doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [self.doubleTapGestureRecognizer setDelegate:self];
        [self addGestureRecognizer:self.doubleTapGestureRecognizer];
        
        self.accessibilityLabel = @"Box";
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin {
    if (self = [self initRandomSquare]) {
        [self setFrame:CGRectMake(origin.x, origin.y, 100, 100)];
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin size:(CGFloat)size andHexColor:(NSString *)hexColor {
    if (self = [self initRandomSquare]) {
        [self setFrame:CGRectMake(origin.x, origin.y, size, size)];
        [self setBackgroundColor:[hexColor getColorFromHexCode]];
    }
    return self;
}

#pragma mark - Animation Methods

- (void)checkDisappearLogicForBlackHoleFrame {
    __block BOOL shouldContinue = YES;
    for (int i = self.frame.origin.x; i <= self.frame.origin.x + self.frame.size.width; i++) {
        
        // this for loop iterates over every point on the bottom and top lines of the square to check if any point is 50 or less px away from center of black hole. if it is, it needs to be sucked in
        CGFloat dist1 = [BTUtil distanceOfPointFromBlackHoleCenter:CGPointMake(i, self.frame.origin.y + self.frame.size.height)];
        CGFloat dist2 = [BTUtil distanceOfPointFromBlackHoleCenter:CGPointMake(i, self.frame.origin.y)];
        if ((dist1 <= 50) || (dist2 <= 50)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self makeDisappear];
            });
            shouldContinue = NO;
            break;
        }
        if (shouldContinue) {
            for (int i = self.frame.origin.y + self.frame.size.height; i >= self.frame.origin.y; i--) {
                
                // this for loop iterates over every point along the left and right hand side of the square to check if any point is 50 or less px away from center of black hole.
                
                if (([BTUtil distanceOfPointFromBlackHoleCenter:CGPointMake(self.frame.origin.x, i)] <= 50) || ([BTUtil distanceOfPointFromBlackHoleCenter:CGPointMake(self.frame.origin.x + self.frame.size.width, i)] <= 50)) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self makeDisappear];
                    });
                    shouldContinue = NO;
                    break;
                }
            }
        }
        if (shouldContinue) {
            if (CGRectContainsRect(self.frame, [BTUtil blackHoleFrame])) {
                
                // this checks to see if the square, which could be bigger than the entire black hole, is covering it. this is an edge case where every edge point could be greater than 50 away, but the whole box is covering the black hole
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self makeDisappear];
                });
            }
        }
    }
}

- (void)makeDisappear {
    [self disappearIntoBlackHoleWithCompletion:^(BOOL complete) {
        [self removeFromSuperview];
    }];
}


#pragma mark - GestureRecognizer methods & delegate

- (void)panGestureRecognizerActivated:(UIPanGestureRecognizer*)recognizer {
    if (recognizer.state != UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:self.superview];
        
        CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        
        CGRect newFrame = CGRectMake(newCenter.x - ((self.frame.size.width/2) - 1), newCenter.y - (self.frame.size.height/2), self.frame.size.width, self.frame.size.height);
        CGRect superviewFrame = self.superview.frame;
        
        CGFloat xOffset = 0.f;
        CGFloat yOffset = 0.f;
        
        if (newFrame.origin.x  <= superviewFrame.origin.x) { // if the square is too far to the left
            xOffset = -translation.x;
        }
        if (newFrame.origin.x + self.frame.size.width >= superviewFrame.size.width) { // if the square is too far to the right
            xOffset = -translation.x;
        }
        
        if (newFrame.origin.y <= superviewFrame.origin.y) { // if the square is too far above the view
            yOffset = -translation.y;
        }
        if (newFrame.origin.y + self.frame.size.height >= superviewFrame.size.height) { // if the square is too far below the view
            yOffset = -translation.y;
        }
        
        CGFloat newX = newCenter.x + xOffset;
        CGFloat newY = newCenter.y + yOffset;
        
        newCenter = CGPointMake(newX, newY);
        
        recognizer.view.center = newCenter;
        [recognizer setTranslation:CGPointZero inView:self.superview];
    }
    else {
        [self checkDisappearLogicForBlackHoleFrame];
    }
}

- (void)doubleTapGestureRecognizerActivated:(UITapGestureRecognizer*)recognizer {
    [self setBackgroundColor:[UIColor randomColor]];
}

#pragma mark - dealloc

- (void)dealloc {
    if (self.panGestureRecognizer) {
        [self.panGestureRecognizer setDelegate:nil];
        [self removeGestureRecognizer:self.panGestureRecognizer];
        self.panGestureRecognizer = nil;
    }
    if (self.doubleTapGestureRecognizer) {
        [self.doubleTapGestureRecognizer setDelegate:nil];
        [self removeGestureRecognizer:self.doubleTapGestureRecognizer];
        self.doubleTapGestureRecognizer = nil;
    }
}

@end


