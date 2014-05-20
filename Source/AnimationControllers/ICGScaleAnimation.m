//
//  ICGScaleAnimation.m
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/13/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGScaleAnimation.h"

@implementation ICGScaleAnimation

#pragma mark - Init methods

- (id) init
{
    self = [super init];
    if (self){
        self.animationDuration = 0.3; // make animation faster than default
    }
    
    return self;
}

- (instancetype) initWithType:(ICGScaleAnimationType)type
{
    self = [super init];
    if (self){
        self.type = type;
        self.animationDuration = 0.3; // make animation faster than default
    }
    return self;
}


#pragma mark - Overriden method

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView
{
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    
    CGFloat zoomingScale = (self.type == ICGScaleAnimationFadeIn) ? 0.8 : 2.0;
    CGFloat springScale = (self.type == ICGScaleAnimationFadeIn) ? 1.2 : 2.2;
    
    if (!self.reverse) {
        //Add 'to' view to the hierarchy with zooming scale
        toView.transform = CGAffineTransformMakeScale(zoomingScale, zoomingScale);
        [containerView insertSubview:toView aboveSubview:fromView];
        
        //Scale the 'to' view to to its final position
        [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.3 animations:^{
                toView.transform = CGAffineTransformMakeScale(springScale, springScale);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.7 animations:^{
                toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }completion:^(BOOL finished){
            [transitionContext completeTransition:YES];
        }];
        
    } else{
        //Add 'to' view to the hierarchy
        [containerView insertSubview:toView belowSubview:fromView];
        
        //Scale the 'from' view down until it disappears
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.transform = CGAffineTransformMakeScale(zoomingScale, zoomingScale);
            fromView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            fromView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            fromView.alpha = 1.0;
        }];
    }

    
}



@end
