//
//  ICGFlipAnimation.h
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/13/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGBaseAnimation.h"

/**
 Types of flip animation
 */
typedef NS_ENUM(NSInteger, ICGFlipAnimationType) {
    ICGFlipAnimationLeft,
    ICGFlipAnimationRight,
    ICGFlipAnimationTop,
    ICGFlipAnimationBottom
};

@interface ICGFlipAnimation : ICGBaseAnimation

/** Inits with specific flip type.
 @param type Type of flip animation.
 @return An instance of ICGFlipAnimation with the specified type.
 */
- (instancetype)initWithType:(ICGFlipAnimationType)type;

@end
