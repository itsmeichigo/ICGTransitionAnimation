//
//  ICGPushedViewController.m
//  ICGTransitionAnimationDemo
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGPushedViewController.h"

@interface ICGPushedViewController ()

@end

@implementation ICGPushedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = segue.destinationViewController;
    ICGViewController *fancyViewController = (ICGViewController *) self;
    
    fancyViewController.interactionEnabled = YES;
    NSString *className = [NSString stringWithFormat:@"ICG%@Animation", @"Layer"];
    id transitionInstance = [[NSClassFromString(className) alloc] init];
    fancyViewController.animationController = transitionInstance;
    fancyViewController.animationController.type = 1;
    
    if ([self respondsToSelector:@selector(setTransitioningDelegate:)]){
        viewController.transitioningDelegate = self.transitioningDelegate;  // this is important for the animation to work
    }
    
}

@end
