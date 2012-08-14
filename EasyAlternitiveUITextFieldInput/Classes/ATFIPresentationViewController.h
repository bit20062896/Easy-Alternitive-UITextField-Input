//
//  ATFIPresentationViewController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/11/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATFIViewController.h"

@interface ATFIPresentationViewController : NSObject <UITextFieldDelegate>

@property (nonatomic, retain) UIButton *coverButton;
@property (nonatomic, retain) UIScrollView *contentScrollView;
@property (nonatomic, retain) UITextField *inputTextField;
@property (nonatomic, retain) UIToolbar *inputToolbar;
@property (nonatomic, retain) ATFIViewController *picker;
@property (nonatomic, retain) NSString *previousInputText;
@property (nonatomic, retain) UIViewController *theViewController;
@property () id <UITextFieldDelegate> previousTextFieldDelegate;

- (void)presentATFIViewController:(ATFIViewController *)aController withToolbar:(UIToolbar *)aToolbar forTextField:(UITextField *)aTextField overScrollView:(UIScrollView *)aScrollView inViewController:(UIViewController *)aViewController;
- (void)dismissATFIViewController;
- (void)dismissATFIViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

- (void)presentKeyboardWithToolbar:(UIToolbar *)aToolbar forTextField:(UITextField *)aTextField overScrollView:(UIScrollView *)aScrollView inViewController:(UIViewController *)aViewController;
- (void)dismissKeyboard;

//General toolbar tie in methods
- (void)changeTextField:(NSString *)newString;
- (IBAction)clearTextField:(id)sender;
- (IBAction)cancelTextFieldInput:(id)sender;
- (IBAction)cancelKeyboardInput:(id)sender;

@end
