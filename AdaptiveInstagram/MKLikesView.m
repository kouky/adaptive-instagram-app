//
//  MKLikesView.m
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 26/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import "MKLikesView.h"
#import <Masonry/Masonry.h>

@interface MKLikesView ()
@property BOOL didSetConstraints;
@property UIImageView *imageView;
@property UILabel *likesLabel;
@end

@implementation MKLikesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart"]];
        
        self.likesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.likesLabel setText:@"lachlanhardy, toolmantim, madpilot, dylanfm, alanjrogers, snapperwolf, niick, timriley"];
        [self.likesLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self.likesLabel setTextColor:[UIColor colorWithRed:0.157 green:0.294 blue:0.427 alpha:1]];
        [self.likesLabel setNumberOfLines:0];
        
        [self addSubview:self.imageView];
        [self addSubview:self.likesLabel];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetConstraints) {
        
        self.didSetConstraints = YES;
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self).with.insets(UIEdgeInsetsMake(5, 5, 0, 0));
        }];
        
        [self.likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(3);
            make.left.equalTo(self.imageView.mas_right).with.offset(5);
            make.right.equalTo(self);
        }];
    }
    
    [super updateConstraints];
}

@end
