//
//  ATFIPresentationViewController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/11/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIPresentationViewController.h"

@implementation ATFIPresentationViewController

@synthesize previousInputText, contentScrollView, picker, inputTextField, inputToolbar, theViewController, previousTextFieldDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        self.coverButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.coverButton.backgroundColor = [UIColor blackColor];
        self.coverButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)presentATFIViewController:(ATFIViewController *)aController withToolbar:(UIToolbar *)aToolbar forTextField:(UITextField *)aTextField overScrollView:(UIScrollView *)aScrollView inViewController:(UIViewController *)aViewController
{
    //stop keyboard from appearing
    [aTextField resignFirstResponder];
    
    //set picker delegate
    aController.delegate = self;
    
    //set all variables
    self.contentScrollView = aScrollView;
    self.inputTextField = aTextField;
    self.inputToolbar = aToolbar;
    self.picker = aController;
    self.previousInputText = self.inputTextField.text;
    self.theViewController = aViewController;
    
    //Set pre-animation values
    self.inputToolbar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    self.picker.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height + self.inputToolbar.frame.size.height, self.picker.view.frame.size.width, self.picker.view.frame.size.height);
    self.coverButton.alpha = 0.0;
    self.coverButton.frame = CGRectMake(0, 0, self.theViewController.view.frame.size.width, self.theViewController.view.frame.size.height);
    [self.coverButton addTarget:self action:@selector(dismissATFIViewController) forControlEvents:UIControlEventTouchUpInside];
    
    //add to screen
    [self.theViewController.view addSubview:self.coverButton];
    [self.theViewController.view addSubview:self.picker.view];
    [self.theViewController.view addSubview:self.inputToolbar];
    
    //Begin animations
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    //Bring in content
    self.picker.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.picker.view.frame.size.height, self.picker.view.frame.size.width, self.picker.view.frame.size.height);
    self.inputToolbar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.picker.view.frame.size.height - self.inputToolbar.frame.size.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    self.coverButton.alpha = 0.5;
    
    //Move ScrollView
    UIEdgeInsets contentInset = UIEdgeInsetsMake(0.0, 0.0, self.picker.view.frame.size.height + self.inputToolbar.frame.size.height, 0.0);
    self.contentScrollView.contentInset = contentInset;
    self.contentScrollView.scrollIndicatorInsets = contentInset;
    
    CGRect aRect = self.contentScrollView.frame;
    aRect.size.height = aRect.size.height - self.contentScrollView.contentInset.bottom - self.inputTextField.frame.size.height - 15;
    if (!CGRectContainsPoint(aRect, self.inputTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(self.contentScrollView.contentOffset.x, self.inputTextField.frame.origin.y - (self.contentScrollView.frame.size.height - self.contentScrollView.contentInset.bottom) + self.inputTextField.frame.size.height + 15);
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
    
    [UIView commitAnimations];
}

- (void)dismissATFIViewController
{
    //Begin animations
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissATFIViewControllerEnded:finished:context:)];
    
    //Bring in content
    self.picker.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height + self.inputToolbar.frame.size.height, self.picker.view.frame.size.width, self.picker.view.frame.size.height);
    self.inputToolbar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    self.coverButton.alpha = 0.0;
    
    //Move ScrollView
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    self.contentScrollView.contentInset = contentInset;
    self.contentScrollView.scrollIndicatorInsets = contentInset;
    
    [UIView commitAnimations];
}

- (void)dismissATFIViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self.picker.view removeFromSuperview];
    [self.inputToolbar removeFromSuperview];
    [self.coverButton removeFromSuperview];
    [self.coverButton removeTarget:self action:@selector(dismissATFIViewController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)presentKeyboardWithToolbar:(UIToolbar *)aToolbar forTextField:(UITextField *)aTextField overScrollView:(UIScrollView *)aScrollView inViewController:(UIViewController *)aViewController
{
    //set all variables
    self.contentScrollView = aScrollView;
    self.inputTextField = aTextField;
    self.inputToolbar = aToolbar;
    self.picker = [[ATFIViewController alloc] init];
    self.theViewController = aViewController;
    self.previousInputText = self.inputTextField.text;
    self.inputTextField.returnKeyType = UIReturnKeyDone;
    self.previousTextFieldDelegate = inputTextField.delegate;
    self.inputTextField.delegate = self;
    
    //Set pre-animation values
    [self.coverButton addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    self.coverButton.alpha = 0.0;
    self.coverButton.frame = CGRectMake(0, 0, self.theViewController.view.frame.size.width, self.theViewController.view.frame.size.height);
    self.inputToolbar.frame = CGRectMake(0, self.theViewController.view.frame.size.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    
    //add to screen
    [self.theViewController.view addSubview:self.coverButton];
    [self.theViewController.view addSubview:self.inputToolbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //Move scroll view
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + self.inputToolbar.frame.size.height, 0.0);
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.contentScrollView.frame;
    aRect.size.height = aRect.size.height - self.contentScrollView.contentInset.bottom - self.inputTextField.frame.size.height - 15;
    if (!CGRectContainsPoint(aRect, self.inputTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(self.contentScrollView.contentOffset.x, self.inputTextField.frame.origin.y - (self.contentScrollView.frame.size.height - self.contentScrollView.contentInset.bottom) + self.inputTextField.frame.size.height + 15);
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
    
    //set pre animation toolbar value
    self.inputToolbar.frame = CGRectMake(0, kbSize.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    
    //Add overlay
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.coverButton.alpha = 0.5;
    self.inputToolbar.frame = CGRectMake(0, self.theViewController.view.frame.size.height - kbSize.height - self.inputToolbar.frame.size.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    [UIView commitAnimations];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.inputTextField.delegate = self.previousTextFieldDelegate;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissKeyboardEnded:finished:context:)];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;
    
    self.coverButton.alpha = 0.0;
    self.inputToolbar.frame = CGRectMake(0, self.theViewController.view.frame.size.height, self.inputToolbar.frame.size.width, self.inputToolbar.frame.size.height);
    
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dismissKeyboardEnded
{
    [self.coverButton removeFromSuperview];
    [self.inputToolbar removeFromSuperview];
    [self.coverButton removeTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//---------------------------------
//general tie in methods for toolbar buttons
//---------------------------------

- (void)dismissKeyboard
{
    [self.inputTextField resignFirstResponder];
}

- (void)changeTextField:(NSString *)newString
{
    self.inputTextField.text = newString;
}

- (IBAction)cancelTextFieldInput:(id)sender
{
    self.inputTextField.text = self.previousInputText;
    [self dismissATFIViewController];
}

- (IBAction)clearTextField:(id)sender
{
    self.inputTextField.text = @"";
}

- (IBAction)cancelKeyboardInput:(id)sender
{
    self.inputTextField.text = self.previousInputText;
    [self.inputTextField resignFirstResponder];
}

@end
