//
//  ICGMainViewController.h
//  ICGTransitionAnimationDemo
//
//  Created by HuongDo on 5/12/14.
//  Copyright (c) 2014 ichigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICGViewController.h"

@interface ICGMainViewController : ICGViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UITextField *navigationField;
@property (weak, nonatomic) IBOutlet UITextField *typeNavigationField;
@property (weak, nonatomic) IBOutlet UITextField *modalField;
@property (weak, nonatomic) IBOutlet UITextField *typeModalField;


@end
