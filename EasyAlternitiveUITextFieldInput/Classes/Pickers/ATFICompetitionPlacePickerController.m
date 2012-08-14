//
//  ATFICompetitionPlacePickerController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/13/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFICompetitionPlacePickerController.h"
#import "ATFIPresentationViewController.h"

@interface ATFICompetitionPlacePickerController ()

@end

@implementation ATFICompetitionPlacePickerController
@synthesize pickerView, lowestPlace;

- (id)initWithLowestPlace:(NSNumber *)aPlace
{
    self = [super init];
    if (self) {
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = YES;
        self.view.frame = self.pickerView.frame;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.pickerView.frame = CGRectMake(0, 788, 768, 216);
        }
        self.view = self.pickerView;
        self.lowestPlace = aPlace;
        if (self.lowestPlace == nil) {
            self.lowestPlace = [NSNumber numberWithInt:1000];
        }
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.lowestPlace integerValue];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"1st";
    } else if (row == 1) {
        return @"2nd";
    } else if (row == 2) {
        return @"3rd";
    } else if (row >= 3) {
        return [NSString stringWithFormat:@"%ith", row + 1];
    } else {
        return @"?";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.delegate changeTextField:[self pickerView:self.pickerView titleForRow:row forComponent:component]];
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
