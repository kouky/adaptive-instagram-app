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
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerView = [[MKHeaderView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.headerView];
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
            make.left.right.and.top.equalTo(self.view);
            make.height.equalTo(@60);
        }];
    }
    
    [super updateViewConstraints];
}

@end
