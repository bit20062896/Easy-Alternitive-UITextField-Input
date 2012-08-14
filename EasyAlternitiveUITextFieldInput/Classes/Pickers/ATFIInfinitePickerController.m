//
//  ATFIInfinitePickerController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/14/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIInfinitePickerController.h"
#import "ATFIPresentationViewController.h"

@interface ATFIInfinitePickerController ()

@end

@implementation ATFIInfinitePickerController
@synthesize pickerView, rowTitles;

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
        //select mddle of picker view
        [self selectMiddleRow];
    }
    return self;
}

- (void)setNewRowTitles:(NSArray *)someRowTitles
{
    self.rowTitles = [someRowTitles mutableCopy];
    [self.pickerView reloadAllComponents];
}

- (void)selectMiddleRow
{
    NSInteger max = [self pickerView:self.pickerView numberOfRowsInComponent:0];
    NSInteger base = (max/2)-(max/2)%[self.rowTitles count];
    [self.pickerView selectRow:([self.pickerView selectedRowInComponent:0]%[self.rowTitles count] + base) inComponent:0 animated:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //not truly infinite, but feels like it. A user would have to be dedicated to reach the end.
    return 1000;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.rowTitles objectAtIndex:(row%[self.rowTitles count])];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self selectMiddleRow];
    [self.delegate changeTextField:[self.rowTitles objectAtIndex:(row%[self.rowTitles count])]];
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
