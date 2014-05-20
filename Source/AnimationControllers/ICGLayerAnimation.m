//
//  ICGLayerAnimation.m
//  ICGTransitionAnimationDemo
//
//  Created by HuongDo on 5/16/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGLayerAnimation.h"

@implementation ICGLayerAnimation

#pragma mark - Init method

- (instancetype)initWithType:(ICGLayerAnimationType)type
{
    self = [super init];
    if (self){
        self.type = type;
    }
    return self;
}


#pragma mark - Overriden method

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView
{
    UIView *containerView = [transitionContext containerView];
    
    switch (self.type) {
        case ICGLayerAnimationReveal:
            [self executeRevealAnimationIn:containerView from:fromView to:toView withContext:transitionContext];
            break;
            
        case ICGLayerAnimationCover:
            [self executeCoverAnimationIn:containerView from:fromView to:toView withContext:transitionContext];
            break;
    }
}


#pragma mark - Helper methods

- (void) executeRevealAnimationIn:(UIView *)containerView from:(UIView *)fromView to:(UIView *)toView withContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    CGPoint temporaryPoint = CGPointMake(-CGRectGetMaxX(toView.frame), CGRectGetMidY(toView.frame));
    CGPoint centerPoint = toView.center;
    
    if (self.reverse){
        toView.center = temporaryPoint;
        [UIView animateWithDuration:self.animationDuration/2 animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            fromView.alpha = 0.3;
        } completion:^(BOOL finished){
        }];
        
        [UIView animateWithDuration:self.animationDuration delay:(self.animationDuration/8) usingSpringWithDamping:0.8f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            toView.center = centerPoint;
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromView removeFromSuperview];
        }];
    } else {
        toView.alpha = 0.3;
        toView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        [UIView animateWithDuration:self.animationDuration animations:^{
            fromView.center = temporaryPoint;
            toView.transform = CGAffineTransformIdentity;
            toView.alpha = 1.0;
        } completion:^(BOOL finished){
            [transitionContext completeTransition:YES];
            [fromView removeFromSuperview];
        }];
        
    }
}

- (void) executeCoverAnimationIn:(UIView *)containerView from:(UIView *)fromView to:(UIView *)toView withContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f*M_PI/180.0f, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = t1.m34;
    t2 = CATransform3DTranslate(t2, 0, fromView.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    
    if (!self.reverse){
        CGRect offScreenFrame = containerView.frame;
        offScreenFrame.origin.y = containerView.frame.size.height;
        toView.frame = offScreenFrame;
        
        [containerView insertSubview:toView aboveSubview:fromView];
        
        CFTimeInterval duration = self.animationDuration;
        CFTimeInterval halfDuration = duration/2;
        
        [UIView animateKeyframesWithDuration:halfDuration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                fromView.layer.transform = t1;
                fromView.alpha = 0.6;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                fromView.layer.transform = t2;
            }];
            
        } completion:^(BOOL finished) {
        }];
        
        
        [UIView animateWithDuration:duration delay:(halfDuration - (0.3*halfDuration)) usingSpringWithDamping:0.7f initialSpringVelocity:6.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            toView.frame = containerView.frame;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];

    } else {
        if (self.modalTransition){
            toView.frame = containerView.frame;
        }
        
        CATransform3D scale = CATransform3DIdentity;
        toView.layer.transform = CATransform3DScale(scale, 0.6, 0.6, 1);
        toView.alpha = 0.6;
        
        [containerView insertSubview:toView belowSubview:fromView];
        
        CGRect frameOffScreen = containerView.frame;
        frameOffScreen.origin.y = containerView.frame.size.height;
        
        NSTimeInterval duration = self.animationDuration;
        NSTimeInterval halfDuration = duration/2;
        
        
        [UIView animateKeyframesWithDuration:halfDuration delay:halfDuration - (0.3*halfDuration) options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
                toView.layer.transform = t1;
                toView.alpha = 1.0;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
                
                toView.layer.transform = CATransform3DIdentity;
            }];
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
        
        [UIView animateWithDuration:halfDuration animations:^{
            fromView.frame = frameOffScreen;
        } completion:^(BOOL finished) {
            
        }];

    }
    
}

@end
