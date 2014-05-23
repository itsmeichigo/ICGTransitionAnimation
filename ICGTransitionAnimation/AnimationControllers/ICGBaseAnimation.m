//
//  ICGBaseAnimation.m
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGBaseAnimation.h"

@implementation ICGBaseAnimation

#pragma mark - Init method

- (id) init
{
    self = [super init];
    if (self){
        self.animationDuration = 1.0f;
    }
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    [self animateTransition:transitionContext fromView:fromView toView:toView];
}


#pragma mark - Helper methods

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView*)fromView toView:(UIView*)toView
{
    
}

- (void)setInteractionEnabled
{
    
}

@end
