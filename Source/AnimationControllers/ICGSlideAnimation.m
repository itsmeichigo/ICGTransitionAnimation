//
//  ICGBounceAnimation.m
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGSlideAnimation.h"
#import "ICGNavigationController.h"

@interface ICGSlideAnimation()
@property (assign, nonatomic) BOOL shouldCompleteTransition;
@end

@implementation ICGSlideAnimation

#pragma mark - Init methods

- (instancetype) init
{
    self = [super init];
    if (self){
        self.damping = 0.8;
        self.velocity = 1.0;
    }
    return self;
}

- (instancetype) initWithType:(ICGSlideAnimationType)type
{
    self = [super init];
    if (self){
        self.type = type;
        self.damping = 0.8;
        self.velocity = 1.0;
    }
    return self;
}


#pragma mark - Overriden methods

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView
{
    UIView *containerView = [transitionContext containerView];
    
    CGPoint temporaryPoint = CGPointZero;
    CGPoint centerPoint = toView.center;
    
    switch (self.type) {
        case ICGSlideAnimationFromBottom:
            temporaryPoint = CGPointMake(CGRectGetMidX(fromView.frame), 1.5*CGRectGetMaxY(fromView.frame));
            break;
        case ICGSlideAnimationFromTop:
            temporaryPoint = CGPointMake(CGRectGetMidX(fromView.frame), -CGRectGetMaxY(fromView.frame));
            break;
        case ICGSlideAnimationFromLeft:
            temporaryPoint = CGPointMake(-CGRectGetMaxX(fromView.frame), CGRectGetMidY(fromView.frame));
                break;
        case ICGSlideAnimationFromRight:
            temporaryPoint = CGPointMake(1.5*CGRectGetMaxX(fromView.frame), CGRectGetMidY(fromView.frame));
            break;
        default:
            break;
    }
    
    if (self.reverse){
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
    } else {
        [containerView addSubview:toView];
        [containerView bringSubviewToFront:toView];
        toView.center = temporaryPoint;
    }
    
    //Animate using spring animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:self.damping initialSpringVelocity:self.velocity options:0 animations:^{
        if (self.reverse){
            fromView.center = temporaryPoint;
        } else {
            toView.center = centerPoint;
        }
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [fromView removeFromSuperview];
    }];
    
}

- (void)setInteractionEnabled
{
    self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.toViewController.view addGestureRecognizer:self.gesture];
}


#pragma mark - Helper methods

- (void) handleGesture:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    BOOL horizontalPan = (self.type == ICGSlideAnimationFromLeft || self.type == ICGSlideAnimationFromRight);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            BOOL rightToLeftSwipe = vel.x < 0;
            BOOL leftToRightSwipe = vel.x > 0;
            BOOL topToBottomSwipe = translation.y > 0;
            BOOL bottomToTopSwipe = translation.y < 0;
            
            // perform the required navigation operation ...
            if (horizontalPan){
                if ((self.type == ICGSlideAnimationFromLeft && rightToLeftSwipe) ||
                    (self.type == ICGSlideAnimationFromRight && leftToRightSwipe)){
                    [self dismissViewController];
                }
            } else {
                if ((self.type == ICGSlideAnimationFromTop && bottomToTopSwipe) ||
                    (self.type == ICGSlideAnimationFromBottom && topToBottomSwipe)){
                    [self dismissViewController];
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (self.interactionInProgress) {
                CGFloat fraction = 0;
                
                if (horizontalPan){
                    // compute the current position
                    fraction = fabsf(translation.x / 200.0);
                    fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                    self.shouldCompleteTransition = (fraction > 0.5);
                    
                } else {
                    // compute the current position
                    fraction = fabsf(translation.y / 200.0);
                    fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                    self.shouldCompleteTransition = (fraction > 0.5);
                }

                if (fraction >= 1.0){
                    fraction = 0.99;
                }
                
                [self updateInteractiveTransition:fraction];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (self.interactionInProgress) {
                self.interactionInProgress = NO;
                if (!self.shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                } else {
                    [self finishInteractiveTransition];
                }
            }
            break;
        default:
            break;
    }
    
}

- (void)dismissViewController
{
    if (self.modalTransition){
        [self.toViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.toViewController.navigationController popViewControllerAnimated:YES];
    }
}

@end