//
//  MKHeaderView.m
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 20/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import "MKHeaderView.h"
#import <Masonry/Masonry.h>

@interface MKHeaderView ()
@property BOOL didSetConstraints;
@property UIImageView *imageView;
@end

@implementation MKHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.157 green:0.294 blue:0.427 alpha:1];
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"instagram"]];
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetConstraints) {
        
        self.didSetConstraints = YES;
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }

    [super updateConstraints];
}

@end
