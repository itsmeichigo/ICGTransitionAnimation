//
//  ICGNavigationController.m
//  ICGTransitionAnimation
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGNavigationController.h"

@implementation ICGNavigationController

#pragma mark - Init methods

- (id)initWithRootViewController:(UIViewController *)rootViewController withAnimation:(ICGBaseAnimation *)animation
{
    self = [super initWithRootViewController:rootViewController];
    if (self){
        self.delegate = self;
        self.animationController = animation;
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self){
        self.delegate = self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    self.animationController.fromViewController = fromVC;
    self.animationController.toViewController = toVC;
    
    if (self.interactionEnabled){
        [self.animationController setInteractionEnabled];
    }
    
    if (operation == UINavigationControllerOperationPop) {
        self.animationController.reverse = YES;
    } else {
        self.animationController.reverse = NO;
    }
    
    return self.animationController;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return self.interactionEnabled && self.animationController.interactionInProgress ? self.animationController : nil;
}

@end
