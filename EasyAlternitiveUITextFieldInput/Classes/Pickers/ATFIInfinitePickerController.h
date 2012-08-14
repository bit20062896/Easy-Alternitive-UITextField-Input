//
//  ATFIInfinitePickerController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/14/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIViewController.h"

@interface ATFIInfinitePickerController : ATFIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableArray *rowTitles;

- (id)initWithRowTitles:(NSArray *)someRowTitles;
- (void)setNewRowTitles:(NSArray *)someRowTitles;

@end
