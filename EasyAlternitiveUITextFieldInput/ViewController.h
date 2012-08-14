//
//  ViewController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/11/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATFIPresentationViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *datePicker;
@property (nonatomic, retain) IBOutlet UITextField *basicPicker;
@property (nonatomic, retain) IBOutlet UITextField *keyboard;
@property (nonatomic, retain) IBOutlet UITextField *numberPicker;
@property (nonatomic, retain) IBOutlet UITextField *placePicker;
@property (nonatomic, retain) IBOutlet UITextField *imagePicker;
@property (nonatomic, retain) IBOutlet UITextField *infinitePicker;
@property (nonatomic, retain) IBOutlet UITextField *datePickerWithToolbar;
@property (nonatomic, retain) IBOutlet UITextField *basicPickerWithToolbar;
@property (nonatomic, retain) IBOutlet UITextField *keyboardWithToolbar;
@property (nonatomic, retain) IBOutlet UITextField *numberPickerWithToolbar;
@property (nonatomic, retain) ATFIPresentationViewController *presentationController;

@end
