//
//  ICGLayerAnimation.h
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/16/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGBaseAnimation.h"

/**
 Types of layer animation
 */
typedef NS_ENUM(NSInteger, ICGLayerAnimationType) {
    ICGLayerAnimationCover,
    ICGLayerAnimationReveal
};

@interface ICGLayerAnimation : ICGBaseAnimation

/** Inits with specific layer type.
 @param type Type of layer animation.
 @return An instance of ICGLayerAnimation with the specified type.
 */
- (instancetype)initWithType:(ICGLayerAnimationType)type;

@end
