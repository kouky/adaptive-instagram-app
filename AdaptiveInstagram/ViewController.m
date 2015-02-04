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
#import "MKAuthorView.h"
#import "MKLikesView.h"
#import "UITraitCollection+MKAdditions.h"

@interface ViewController ()
@property BOOL didSetConstraints;
@property MKHeaderView *headerView;
@property MKAuthorView *authorView;
@property UIImageView *pictureView;
@property MKLikesView *likesView;

// Constraints
@property NSArray *genericConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.didSetConstraints = NO;
        self.headerView = [[MKHeaderView alloc] initWithFrame:CGRectZero];
        self.authorView = [[MKAuthorView alloc] initWithFrame:CGRectZero];
        self.pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rottnest"]];
        self.likesView = [[MKLikesView alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.authorView];
    [self.view addSubview:self.pictureView];
    [self.view addSubview:self.likesView];
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
        [self installGenericConstraints];
        [self installPhonePortraitConstraints];
    }
    
    [super updateViewConstraints];
}

#pragma mark UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if ([newCollection mk_matchesPhoneLandscape]) {
        
        [self uninstallPhonePortraitConstraints];
        [self installPhoneLandscapeConstraints];
        
    }
    else if ([newCollection mk_matchesPhonePortrait]) {
        
        [self uninstallPhoneLandscapeConstraints];
        [self installPhonePortraitConstraints];
    }
    
    [self updateViewConstraints];
}

#pragma mark Size class constraimts helpers

- (void)installGenericConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.right.and.top.equalTo(self.view)];
        [constraints addObject:make.height.equalTo(@60)];
    }];

    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.height.equalTo(@50)];
        [constraints addObject:make.top.equalTo(self.headerView.mas_bottom)];
    }];

    self.genericConstraints = [constraints copy];
}

- (void)installPhonePortraitConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];

    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.and.right.equalTo(self.view)];
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.authorView.mas_bottom)];
        [constraints addObject:make.left.and.right.equalTo(self.view)];
        [constraints addObject:make.height.equalTo(self.pictureView.mas_width)];
    }];
    
    [self.likesView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.pictureView.mas_bottom).with.offset(5)];
        [constraints addObject:make.left.and.right.equalTo(self.view)];
        [constraints addObject:make.height.equalTo(@60)];
    }];

    self.phonePortraitConstraints = [constraints copy];
}

- (void)uninstallPhonePortraitConstraints
{
    for (MASConstraint *constraint in self.phonePortraitConstraints) {
        [constraint uninstall];
    }
}

- (void)installPhoneLandscapeConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.equalTo(self.pictureView.mas_right)];
        [constraints addObject:make.width.lessThanOrEqualTo(self.pictureView)];
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.headerView.mas_bottom)];
        [constraints addObject:make.left.and.bottom.equalTo(self.view)];
        [constraints addObject:make.width.equalTo(self.pictureView.mas_height)];
    }];
    
    [self.likesView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.authorView.mas_bottom)];
        [constraints addObject:make.left.equalTo(self.pictureView.mas_right)];
        [constraints addObject:make.height.equalTo(@60)];
        [constraints addObject:make.width.lessThanOrEqualTo(self.pictureView)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}

- (void)uninstallPhoneLandscapeConstraints
{
    for (MASConstraint *constraint in self.phoneLandscapeConstraints) {
        [constraint uninstall];
    }
}

@end
