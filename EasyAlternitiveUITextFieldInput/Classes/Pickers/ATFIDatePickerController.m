//
//  ATFIDatePickerController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/11/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIDatePickerController.h"
#import "ATFIPresentationViewController.h"

@interface ATFIDatePickerController ()

@end

@implementation ATFIDatePickerController

- (id)init
{
    self = [super init];
    if (self) {
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.date = [NSDate date];
        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        self.view.frame = self.datePicker.frame;
        self.view = self.datePicker;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (UIView* subview in self.datePicker.subviews) {
        subview.frame = self.datePicker.bounds;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dateChanged:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    [self.delegate changeTextField:[formatter stringFromDate:self.datePicker.date]];
}

@end
