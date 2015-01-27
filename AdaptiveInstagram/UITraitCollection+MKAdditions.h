//
//  UITraitCollection+MKAdditions.h
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 27/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITraitCollection (MKAdditions)

- (BOOL)mk_matchesPhoneLandscape;
- (BOOL)mk_matchesPhonePortrait;

@end
