//
//  ATFICompetitionPlacePickerController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/13/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIViewController.h"

@interface ATFICompetitionPlacePickerController : ATFIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSNumber *lowestPlace;

- (id)initWithLowestPlace:(NSNumber *)aPlace;

@end
