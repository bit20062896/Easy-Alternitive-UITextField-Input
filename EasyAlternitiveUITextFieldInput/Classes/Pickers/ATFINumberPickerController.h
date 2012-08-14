//
//  ATFINumberPickerController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/12/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIViewController.h"

@interface ATFINumberPickerController : ATFIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    int numberOfComponents;
    NSMutableDictionary *componentLimits;
}

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableSet *componentsWithDecimals;
@property (nonatomic, retain) NSString *leadingSymbol;

- (id)initWithNumberOfDigits:(NSNumber *)components;
- (void)addDecimalToComponentIndex:(NSNumber *)componentIndex;
- (void)removeDecimalFromComponentIndex:(NSNumber *)componentIndex;
- (void)setLowerLimit:(NSNumber *)lowerLimit andUpperLimit:(NSNumber *)upperLimit forComponentIndex:(NSNumber *)component;

@end
