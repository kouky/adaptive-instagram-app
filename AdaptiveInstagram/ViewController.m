//
//  ViewController.m
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 19/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "MKHeaderView.h"
#import "MKPictureView.h"


@interface ViewController ()
@property BOOL didSetConstraints;
@property MKHeaderView *headerView;
@property MKPictureView *pictureView;
@property NSArray *anyWidthAnyHeightConstraints;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.didSetConstraints = NO;
        self.headerView = [[MKHeaderView alloc] initWithFrame:CGRectZero];
        self.pictureView = [[MKPictureView alloc] initWithFrame:CGRectZero];
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
        [self addAnyWidthAnyHeightConstraints];
    }
    
    [super updateViewConstraints];
}

#pragma mark UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"change");
}

#pragma mark Size class constraimts helpers

- (void)addAnyWidthAnyHeightConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.right.and.top.equalTo(self.view)];
        [constraints addObject:make.height.equalTo(@60)];
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.height.equalTo(self.pictureView.mas_width)];
    }];
    
    self.anyWidthAnyHeightConstraints = [constraints copy];
}


@end
