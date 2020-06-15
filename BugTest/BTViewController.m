//
//  BTViewController.m
//  BugTest
//
//  Created by David Okun on 7/1/14.
//  Copyright (c) 2014 Apptivation. All rights reserved.
//

#import "BTViewController.h"
#import "BTSquare.h"
#import "BTBlackHole.h"
#import "BTUtil.h"
#import "UIView+BTAnimations.h"

@interface BTViewController ()

@property (strong, nonatomic) NSMutableArray *squares;
@property (strong, nonatomic) BTBlackHole *blackHole;


@property (weak, nonatomic) IBOutlet UILabel *blackHoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addSquareLabel;
@property (weak, nonatomic) IBOutlet UIButton *blackHoleButton;
@property (weak, nonatomic) IBOutlet UIButton *addSquareButton;


@end

@implementation BTViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self createInitialScene];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - UI Methods

- (void)createInitialScene {
  self.squares = [[NSMutableArray alloc] init];
  
  NSArray *initialArray = [BTUtil getInitialArrayOfSquaresFromJSON];
  
  [self.squares addObjectsFromArray:initialArray];
  
  for (BTSquare *square in initialArray) {
    [self.view addSubview:square];
    [self.view sendSubviewToBack:square];
  }
  
  self.blackHole = [[BTBlackHole alloc] init];
  [self.view addSubview:self.blackHole];
  [self.view sendSubviewToBack:self.blackHole];
}

- (void)updateStaticUIForLastSquare:(BTSquare*)lastSquare {
  if (lastSquare) {
    [lastSquare checkDisappearLogicForBlackHoleFrame];
  }
}

#pragma mark - IBActions

- (IBAction)blackHoleButtonTapped:(id)sender {
  [self.squares enumerateObjectsUsingBlock:^(BTSquare *square, NSUInteger idx, BOOL *stop) {
    [square makeDisappear];
  }];
  [self.squares removeAllObjects];
}

- (IBAction)addSquareButtonTapped:(id)sender {
  BTSquare *newSquare = [[BTSquare alloc] initRandomSquare];
  [self.view addSubview:newSquare];
  [self.squares addObject:newSquare];
  [self updateStaticUIForLastSquare:newSquare];
}

#pragma mark - dealloc

- (void)dealloc {
  [self.squares removeAllObjects];
  [self.blackHole removeFromSuperview];
}

@end
