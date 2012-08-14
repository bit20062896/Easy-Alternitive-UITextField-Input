//
//  ATFINumberPickerController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/12/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFINumberPickerController.h"
#import "ATFIPresentationViewController.h"

@interface ATFINumberPickerController ()

@end

@implementation ATFINumberPickerController
@synthesize pickerView, componentsWithDecimals, leadingSymbol;

- (id)initWithNumberOfDigits:(NSNumber *)components
{
    self = [super init];
    if (self) {
        numberOfComponents = [components intValue];
        componentLimits = [[NSMutableDictionary alloc] init];
        for (int i = 0; i <= numberOfComponents; i++) {
            [componentLimits setValue:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"Component%iLowerLimit", i]];
            [componentLimits setValue:[NSNumber numberWithInt:9] forKey:[NSString stringWithFormat:@"Component%iUpperLimit", i]];
        }
        [self setLowerLimit:[NSNumber numberWithInt:-9] andUpperLimit:nil forComponentIndex:[NSNumber numberWithInt:0]];
        self.componentsWithDecimals = [[NSMutableSet alloc] init];
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = YES;
        self.view.frame = self.pickerView.frame;
        self.view = self.pickerView;
        self.leadingSymbol = @"";
    }
    return self;
}

- (void)addDecimalToComponentIndex:(NSNumber *)componentIndex
{
    [self.componentsWithDecimals addObject:componentIndex];
    [self.pickerView reloadAllComponents];
}

- (void)removeDecimalFromComponentIndex:(NSNumber *)componentIndex
{
    NSNumber *object = nil;
    for (NSNumber *aComponent in self.componentsWithDecimals) {
        if ([aComponent intValue] == [componentIndex intValue]) {
            object = aComponent;
        }
    }
    if (object != nil) {
        [self.componentsWithDecimals removeObject:object];
    }
    [self.pickerView reloadAllComponents];
}

- (void)setLowerLimit:(NSNumber *)lowerLimit andUpperLimit:(NSNumber *)upperLimit forComponentIndex:(NSNumber *)component
{
    if (lowerLimit != nil) {
        [componentLimits setValue:lowerLimit forKey:[NSString stringWithFormat:@"Component%@LowerLimit", component]];
    }
    if (upperLimit != nil) {
        [componentLimits setValue:upperLimit forKey:[NSString stringWithFormat:@"Component%@UpperLimit", component]];
    }
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSNumber *lowerLimit = [componentLimits objectForKey:[NSString stringWithFormat:@"Component%iLowerLimit", component]];
    NSNumber *upperLimit = [componentLimits objectForKey:[NSString stringWithFormat:@"Component%iUpperLimit", component]];
    int lower = [lowerLimit intValue];
    int upper = [upperLimit intValue];
    int zero = 0;
    if (lower <= 0 && upper >= 0) {
        zero = 1;
    }
    return abs(lower) + abs(upper) + zero;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber *lowerLimit = [componentLimits objectForKey:[NSString stringWithFormat:@"Component%iLowerLimit", component]];
    int lower = [lowerLimit intValue];
    
    BOOL addDecimal = FALSE;
    for (NSNumber *aComponent in componentsWithDecimals) {
        if ([aComponent intValue] == component) {
            addDecimal = TRUE;
        }
    }
    if (addDecimal && component != 0) {
        return [NSString stringWithFormat:@".%i", lower + row];
    } else if (addDecimal && component == 0) {
        return [NSString stringWithFormat:@"%@.%i", self.leadingSymbol , lower + row];
    } else if (!addDecimal && component != 0) {
        return [NSString stringWithFormat:@"%i", lower + row];
    } else if (!addDecimal && component == 0) {
        return [NSString stringWithFormat:@"%@%i", self.leadingSymbol , lower + row];
    } else {
        return @"?";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < numberOfComponents; i++) {
        [string appendString:[self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:i] forComponent:i]];
    }

    [self.delegate changeTextField:string];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (UIView* subview in self.pickerView.subviews) {
        subview.frame = self.pickerView.bounds;
    }
    //set all values to zero
    for (int i = 0; i < numberOfComponents; i ++) {
        NSNumber *lowerLimit = [componentLimits objectForKey:[NSString stringWithFormat:@"Component%iLowerLimit", i]];
        NSNumber *upperLimit = [componentLimits objectForKey:[NSString stringWithFormat:@"Component%iUpperLimit", i]];
        int lower = [lowerLimit intValue];
        int upper = [upperLimit intValue];
        int zero = 0;
        if (lower <= 0 && upper >= 0) {
            zero = 1;
        }
        for (int j = 0; j < abs(lower) + abs(upper) + zero; j++) {
            if ([[self pickerView:self.pickerView titleForRow:j forComponent:i] isEqualToString:@"0"] || [[self pickerView:self.pickerView titleForRow:j forComponent:i] isEqualToString:@".0"] || [[self pickerView:self.pickerView titleForRow:j forComponent:i] isEqualToString:[NSString stringWithFormat:@"%@0", self.leadingSymbol]]) {
                [self.pickerView selectRow:j inComponent:i animated:YES];
            }
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
