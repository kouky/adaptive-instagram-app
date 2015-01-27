//
//  UITraitCollection+MKAdditions.m
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 27/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import "UITraitCollection+MKAdditions.h"

@implementation UITraitCollection (MKAdditions)

- (BOOL)mk_matchesPhoneLandscape
{
    if (self.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        return YES;
    }
    else if (self.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)mk_matchesPhonePortrait
{
    if (self.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
