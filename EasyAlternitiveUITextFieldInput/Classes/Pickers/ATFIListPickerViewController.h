//
//  ATFIListPickerViewController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/12/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIViewController.h"

@interface ATFIListPickerViewController : ATFIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableArray *rowTitles;

- (id)initWithRowTitles:(NSArray *)someRowTitles;
- (void)setNewRowTitles:(NSArray *)someRowTitles;

@end
