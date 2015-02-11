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
    [self.view addSubview:self.likesView];
    [self.view addSubview:self.pictureView];
    [self.view setNeedsUpdateConstraints];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark UIViewController template methods

- (void)updateViewConstraints
{
    if (!self.didSetConstraints) {
        
        self.didSetConstraints = YES;
        [self installGenericConstraints];
        [self toggleConstraintsForTraitCollection:self.traitCollection];
    }
    
    [super updateViewConstraints];
}

#pragma mark UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self toggleConstraintsForTraitCollection:newCollection];
}

#pragma mark Private methods

- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection
{
    if ([traitCollection mk_matchesPhoneLandscape]) {
        
        [self uninstallPhonePortraitConstraints];
        [self installPhoneLandscapeConstraints];
        
    }
    else if ([traitCollection mk_matchesPhonePortrait]) {
        
        [self uninstallPhoneLandscapeConstraints];
        [self installPhonePortraitConstraints];
    }
    
    [self updateViewConstraints];
}

- (void)installGenericConstraints
{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.left.right.and.top.equalTo(self.view);
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.pictureView.mas_width);
        make.left.equalTo(self.view);
    }];

    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        addObject:make.height.equalTo(@50);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
}

- (void)installPhonePortraitConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];

    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.and.right.equalTo(self.view)];
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.authorView.mas_bottom)];
        [constraints addObject:make.right.equalTo(self.view)];
    }];
    
    [self.likesView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.pictureView.mas_bottom).with.offset(5)];
        [constraints addObject:make.left.and.right.equalTo(self.view)];
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
        [constraints addObject:make.bottom.equalTo(self.view)];
    }];
    
    [self.likesView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.authorView.mas_bottom)];
        [constraints addObject:make.left.equalTo(self.pictureView.mas_right)];
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
