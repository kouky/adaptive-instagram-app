//
//  MKPictureView.m
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 26/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import "MKPictureView.h"

@interface MKPictureView ()
@property UIImageView *imageView;
@end

@implementation MKPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rottnest"]];
        [self addSubview:self.imageView];
    }
    
    return self;
}

@end
