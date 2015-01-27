//
//  UITraitCollection+MKAdditions.h
//  AdaptiveInstagram
//
//  Created by Michael Koukoullis on 27/01/2015.
//  Copyright (c) 2015 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITraitCollection (MKAdditions)

// Any iphone in landscape orientation
- (BOOL)mk_matchesPhoneLandscape;

// Any iphone in portrait orientation
- (BOOL)mk_matchesPhonePortrait;

@end
