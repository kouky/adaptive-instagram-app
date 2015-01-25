//
//  ViewController.m
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 19/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import "ViewController.h"
#import "MKHeaderView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property BOOL didSetConstraints;
@property MKHeaderView *headerView;
@property NSArray *anyWidthAnyHeightConstraints;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.didSetConstraints = NO;
        self.headerView = [[MKHeaderView alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view setNeedsUpdateConstraints];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)updateViewConstraints
{
    if (!self.didSetConstraints) {
        
        self.didSetConstraints = YES;
        
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            NSMutableArray *constraints = [[NSMutableArray alloc] init];
            
            [constraints addObject:make.left.right.and.top.equalTo(self.view)];
            [constraints addObject:make.height.equalTo(@60)];
            
            self.anyWidthAnyHeightConstraints = [constraints copy];
        }];
    }
    
    [super updateViewConstraints];
}

#pragma mark UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"change");
}

@end
