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

// Generic - all iphones and ipads in any orientation
@property NSArray *anyWidthAnyHeightConstraints;

// Any iphone in portrait orientation
@property NSArray *compactWidthRegularHeightConstraints;

// Any iphone in portrait landscape
@property NSArray *anyWidthCompactHeightConstraints;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.didSetConstraints = NO;
        self.headerView = [[MKHeaderView alloc] initWithFrame:CGRectZero];
        self.pictureView = [[MKPictureView alloc] initWithFrame:CGRectZero];
        [self.pictureView setBackgroundColor:[UIColor redColor]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.pictureView];
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
        [self addCompactWidthRegularHeightConstraints];
    }
    
    [super updateViewConstraints];
}

#pragma mark UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    UIUserInterfaceSizeClass h = newCollection.horizontalSizeClass;
    UIUserInterfaceSizeClass v = newCollection.verticalSizeClass;
    
    // iPhone Landscape
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        [self removeCompactWidthRegularHeightConstraints];
        [self addAnyWidthCompactHeightConstraints];
    }
    
    // iPhone Landscape
    else if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        [self removeCompactWidthRegularHeightConstraints];
        [self addAnyWidthCompactHeightConstraints];
    }
    // iPhone Portrait
    else if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        [self removeAnyWidthCompactHeightConstraints];
        [self addCompactWidthRegularHeightConstraints];
    }
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
        [constraints addObject:make.top.equalTo(self.headerView.mas_bottom)];
    }];
    
    self.anyWidthAnyHeightConstraints = [constraints copy];
}

- (void)addCompactWidthRegularHeightConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.width.equalTo(self.view.mas_width)];

    }];
    
    self.compactWidthRegularHeightConstraints = [constraints copy];
}

- (void)removeCompactWidthRegularHeightConstraints
{
    for (MASConstraint *constraint in self.compactWidthRegularHeightConstraints) {
        [constraint uninstall];
    }
}

- (void)addAnyWidthCompactHeightConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.height.equalTo(self.view.mas_height)];
        
    }];
    
    self.anyWidthCompactHeightConstraints = [constraints copy];
}

- (void)removeAnyWidthCompactHeightConstraints
{
    for (MASConstraint *constraint in self.anyWidthCompactHeightConstraints) {
        [constraint uninstall];
    }
}

@end
