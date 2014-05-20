//
//  ICGFlipAnimation.m
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/13/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGFlipAnimation.h"

@interface ICGFlipAnimation()

@end

@implementation ICGFlipAnimation

#pragma mark - Init methods

- (instancetype) init
{
    self = [super init];
    if (self){
        self.animationDuration = 1.5;
    }
    
    return self;
}

- (instancetype)initWithType:(ICGFlipAnimationType)type
{
    self = [super init];
    if (self){
        self.animationDuration = 1.5;
        self.type = type;
    }
    return self;
}


#pragma mark - Override transition animation

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView
{
    // Set reverse type
    if (self.reverse){
        switch (self.type) {
            case ICGFlipAnimationLeft:
                self.type = ICGFlipAnimationRight;
                break;
            case ICGFlipAnimationRight:
                self.type = ICGFlipAnimationLeft;
                break;
            case ICGFlipAnimationTop:
                self.type = ICGFlipAnimationBottom;
                break;
            case ICGFlipAnimationBottom:
                self.type = ICGFlipAnimationTop;
                break;
        }
    }
    
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    // Add a perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    [containerView.layer setSublayerTransform:transform];
    
    // Give both VCs the same start frame
    CGRect initialFrame;
    if (self.modalTransition){
        initialFrame = containerView.frame;
    } else {
        initialFrame = [transitionContext initialFrameForViewController:self.fromViewController];
    }

    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    // reverse?
    float factor = (self.type == ICGFlipAnimationLeft || self.type == ICGFlipAnimationTop) ? -1.0 : 1.0;
    
    // flip the to VC halfway round - hiding it
    toView.layer.transform = [self rotate:factor * -M_PI_2];
    toView.alpha = 0.0;
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            // rotate the from view
            fromView.layer.transform = [self rotate:factor * -M_PI_2/8];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.3 animations:^{
            // rotate the from view
            fromView.layer.transform = [self rotate:factor * M_PI_2];
            fromView.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.3 animations:^{
            // rotate the to view
            toView.layer.transform = [self rotate:factor * M_PI_2/8];
            toView.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            // rotate the to view
            toView.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromView.alpha = 1.0;
        fromView.layer.transform = CATransform3DIdentity;
    }];

}


#pragma mark - Helper method

- (CATransform3D) rotate:(CGFloat) angle {
    if (self.type == ICGFlipAnimationLeft || self.type == ICGFlipAnimationRight){
        return  CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
    } else{
        return  CATransform3DMakeRotation(angle, 1.0, 0.0, 0.0);
    }
    
}

@end
