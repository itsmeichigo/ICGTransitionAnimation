//
//  ICGMainViewController.m
//  ICGTransitionAnimationDemo
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import "ICGMainViewController.h"
#import "ICGModalViewController.h"
#import "ICGPushedViewController.h"
#import "ICGNavigationController.h"
#import "ICGViewController.h"

@interface ICGMainViewController ()

@property (strong, nonatomic) NSArray *animations;
@property (strong, nonatomic) NSArray *textFields;
@property (assign, nonatomic) NSInteger selectedNavigationAnimation;
@property (assign, nonatomic) NSInteger selectedNavigationType;
@property (assign, nonatomic) NSInteger selectedModalAnimation;
@property (assign, nonatomic) NSInteger selectedModalType;

@end

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation ICGMainViewController

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
    self.title = @"Fancy Transition Animation";
    
    self.textFields = @[self.navigationField, self.typeNavigationField,
                        self.modalField, self.typeModalField];
    for (UITextField *textField in self.textFields){
        textField.delegate = self;
    }
    
    [self.pickerView setTag:0];
    [self.pickerView setDataSource:self];
    [self.pickerView setDelegate:self];
    [self.optionView setFrame:CGRectMake(0, SCREEN_HEIGHT, CGRectGetWidth(self.optionView.frame), CGRectGetHeight(self.optionView.frame))];
    [self.optionView setAlpha:0.0];
    [self.view addSubview:self.optionView];
    [self.view bringSubviewToFront:self.optionView];
    
    [self.scrollView setContentSize:self.contentView.frame.size];
    [self.scrollView addSubview:self.contentView];
    
    [self.doneButton setTarget:self];
    [self.doneButton setAction:@selector(exitEditingMode)];
    
    self.animations = @[@{@"name": @"Default"},
                        @{@"name": @"Slide",
                          @"types": @[@"From Left", @"From Right", @"From Top", @"From Bottom"]},
                        @{@"name": @"Scale",
                          @"types": @[@"Fade In", @"Drop In"]},
                        @{@"name": @"Layer",
                          @"types": @[@"Cover", @"Reveal"]},
                        @{@"name": @"Flip",
                          @"types": @[@"From Left", @"From Right", @"From Top", @"From Bottom"]}];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self exitEditingMode];
}

- (void) exitEditingMode
{
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    [self pickerView:self.pickerView didSelectRow:row inComponent:0];
    
    switch (self.pickerView.tag + 100) {
        case 100:
            self.selectedNavigationAnimation = row;
            self.selectedNavigationType = 0;
            break;
        case 101:
            self.selectedNavigationType = row;
            break;
        case 102:
            self.selectedModalAnimation = row;
            self.selectedModalType = 0;
            break;
        case 103:
            self.selectedModalType = row;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.optionView setFrame:CGRectMake(0, SCREEN_HEIGHT, CGRectGetWidth(self.optionView.frame), CGRectGetHeight(self.optionView.frame))];
    } completion:^(BOOL finished){
        if (finished){
            [self.optionView setAlpha:0.0];
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"pushSegue"]) {
        
        ICGNavigationController *fancyNavigationController = (ICGNavigationController *) self.navigationController;
        
        if (self.selectedNavigationAnimation == 0){
            fancyNavigationController.animationController = nil;
        } else {
            fancyNavigationController.interactionEnabled = YES;
            NSString *className = [NSString stringWithFormat:@"ICG%@Animation", [[self.animations objectAtIndex:self.selectedNavigationAnimation] objectForKey:@"name"]];
            id transitionInstance = [[NSClassFromString(className) alloc] init];
            fancyNavigationController.animationController = transitionInstance;
            fancyNavigationController.animationController.type = self.selectedNavigationType;
        }
        
       
    } else if ([segue.identifier isEqualToString:@"modalSegue"]) {
        ICGModalViewController *viewController = segue.destinationViewController;
        ICGViewController *fancyViewController = (ICGViewController *) self;
        if (self.selectedModalAnimation == 0){
            fancyViewController.animationController = nil;
        } else {
            fancyViewController.interactionEnabled = YES;
            NSString *className = [NSString stringWithFormat:@"ICG%@Animation", [[self.animations objectAtIndex:self.selectedModalAnimation] objectForKey:@"name"]];
            id transitionInstance = [[NSClassFromString(className) alloc] init];
            fancyViewController.animationController = transitionInstance;
            fancyViewController.animationController.type = self.selectedModalType;
        }
        
        if ([self respondsToSelector:@selector(setTransitioningDelegate:)]){
            viewController.transitioningDelegate = self.transitioningDelegate;  // this is important for the animation to work
        }
        
    }
}


#pragma mark - UIPickerViewDatasource

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag%2 != 0){
        UITextField *previousTextField = [self.textFields objectAtIndex:pickerView.tag-1];
        for (NSDictionary *animation in self.animations){
            if ([[animation objectForKey:@"name"] isEqualToString:[previousTextField text]]){
                return [[animation objectForKey:@"types"] count];
            }
        }
    }
    
    return [self.animations count];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark - UIPickerViewDelegate

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag%2 != 0){
        UITextField *previousTextField = [self.textFields objectAtIndex:pickerView.tag-1];
        for (NSDictionary *animation in self.animations){
            if ([[animation objectForKey:@"name"] isEqualToString:[previousTextField text]]){
                return [[animation objectForKey:@"types"] objectAtIndex:row];
            }
        }
    }

    return [[self.animations objectAtIndex:row] objectForKey:@"name"];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UITextField *textField = [self.textFields objectAtIndex:pickerView.tag];
    [textField setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
    if (pickerView.tag%2 == 0){
        UITextField *nextTextField = [self.textFields objectAtIndex:pickerView.tag+1];
        if (row > 0){
            [nextTextField setText:[[[self.animations objectAtIndex:row] objectForKey:@"types"] objectAtIndex:0]];
            [nextTextField setEnabled:YES];
        } else {
            [nextTextField setText:@""];
            [nextTextField setEnabled:NO];
        }
        
    }
    
    switch (self.pickerView.tag + 100) {
        case 100:
            self.selectedNavigationAnimation = row;
            break;
        case 101:
            self.selectedNavigationType = row;
            break;
        case 102:
            self.selectedModalAnimation = row;
            break;
        case 103:
            self.selectedModalType = row;
            break;
        default:
            break;
    }
    
}


#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    self.pickerView.tag = textField.tag - 100;
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [self.optionView setAlpha:1.0];
    
    CGFloat height = 0;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        height = SCREEN_WIDTH;
    } else {
        height = SCREEN_HEIGHT;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.optionView setFrame:CGRectMake(0, height - CGRectGetHeight(self.optionView.frame), CGRectGetWidth(self.optionView.frame), CGRectGetHeight(self.optionView.frame))];
    }];
    return NO;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self exitEditingMode];
    return NO;
}


@end
