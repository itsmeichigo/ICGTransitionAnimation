//
//  ICGBaseAnimation.h
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICGBaseAnimation : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning>

/**
 The animation duration.
 */
@property (assign, nonatomic) NSTimeInterval animationDuration;

/**
 Direction of the transition.
 */
@property (assign, nonatomic) NSInteger type;

/**
 Whether the animation should be reverse.
 */
@property (assign, nonatomic) BOOL reverse;

/**
 Whether the transition is modal.
 */
@property (assign, nonatomic) BOOL modalTransition;

/**
 Whether the interaction is in progress.
 */
@property (assign, nonatomic) BOOL interactionInProgress;

/**
 The view controller from which the transition starts.
 */
@property (strong, nonatomic) UIViewController *fromViewController;

/**
 The view controller at which the transition ends.
 */
@property (strong, nonatomic) UIViewController *toViewController;

/**
 The gesture that is added for the interaction.
 Make sure this is removed when no longer necessary.
 */
@property (strong, nonatomic) UIGestureRecognizer *gesture;


/** Helper method for animating transition
 @param transitionContext The context object containing information about the transition.
 @param fromView The view to be hidden
 @param toView The view to be displayed
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromView:(UIView*)fromView toView:(UIView*)toView;

/** Helper method for enabling interactive transition
 */
- (void)setInteractionEnabled;
@end
