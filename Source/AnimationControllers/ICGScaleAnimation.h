//
//  ICGScaleAnimation.h
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/13/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGBaseAnimation.h"

/**
 Types of scale animation
 */

typedef NS_ENUM(NSInteger, ICGScaleAnimationType){
    ICGScaleAnimationFadeIn,
    ICGScaleAnimationDropIn
};

@interface ICGScaleAnimation : ICGBaseAnimation

/** Inits with specific zooming type.
 @param type Type of scale animation.
 @return An instance of ICGScaleAnimation with the specified type.
 */
- (instancetype) initWithType:(ICGScaleAnimationType)type;

@end
