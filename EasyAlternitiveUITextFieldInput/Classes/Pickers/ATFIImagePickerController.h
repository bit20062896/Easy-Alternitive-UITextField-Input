//
//  ATFIImagePickerController.h
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/13/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIViewController.h"

@interface ATFIImagePickerController : ATFIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *imagesArray;
    NSArray *stringsArray;
}

@property (nonatomic, retain) UIPickerView *pickerView;

- (id)initWithStrings:(NSArray *)strings andImages:(NSArray *)images;
- (void)setNewStrings:(NSArray *)strings andImages:(NSArray *)images;

@end
