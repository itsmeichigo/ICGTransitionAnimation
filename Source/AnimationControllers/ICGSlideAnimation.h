//
//  ICGBounceAnimation.h
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGBaseAnimation.h"

/**
 Types of sliding animation
 */
typedef NS_ENUM (NSInteger, ICGSlideAnimationType){
    ICGSlideAnimationFromLeft,
    ICGSlideAnimationFromRight,
    ICGSlideAnimationFromTop,
    ICGSlideAnimationFromBottom
};

@interface ICGSlideAnimation : ICGBaseAnimation

/**
 Velocity of the sliding.
 */
@property (assign, nonatomic) CGFloat velocity;

/**
 Damping of the sliding.
 */
@property (assign, nonatomic) CGFloat damping;

/** Inits with specific sliding type.
 @param type sliding direction.
 @return An instance of ICGBounceAnimation with the specified bouncing direction.
 */
- (instancetype) initWithType:(ICGSlideAnimationType)type;

@end
