//
//  ATFIListPickerViewController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/12/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIListPickerViewController.h"
#import "ATFIPresentationViewController.h"

@interface ATFIListPickerViewController ()

@end

@implementation ATFIListPickerViewController

- (id)initWithRowTitles:(NSArray *)someRowTitles
{
    self = [super init];
    if (self) {
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = YES;
        self.view.frame = self.pickerView.frame;
        self.view = self.pickerView;
        self.rowTitles = [someRowTitles mutableCopy];
    }
    return self;
}

- (void)setNewRowTitles:(NSArray *)someRowTitles
{
    self.rowTitles = [someRowTitles mutableCopy];
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.rowTitles count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.rowTitles objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.delegate changeTextField:[self.rowTitles objectAtIndex:row]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (UIView* subview in self.pickerView.subviews) {
        subview.frame = self.pickerView.bounds;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
