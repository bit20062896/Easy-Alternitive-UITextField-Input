//
//  ATFIImagePickerController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/13/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ATFIImagePickerController.h"
#import "ATFIPresentationViewController.h"

@interface ATFIImagePickerController ()

@end

@implementation ATFIImagePickerController
@synthesize pickerView;

- (id)initWithStrings:(NSArray *)strings andImages:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = YES;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.pickerView.frame = CGRectMake(0, 788, 768, 216);
        }
        self.view.frame = self.pickerView.frame;
        self.view = self.pickerView;
        if ([strings count] == [images count]) {
            stringsArray = strings;
            imagesArray = images;
        }
    }
    return self;
}

- (void)setNewStrings:(NSArray *)strings andImages:(NSArray *)images
{
    if ([strings count] == [images count]) {
        stringsArray = strings;
        imagesArray = images;
        [self.pickerView reloadAllComponents];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [stringsArray count];
}

//Adujusts spacing between rows. The slider automatically adjusts to content size
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.0;
}*/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (view == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ImagePickerCustomView" owner:nil options:nil];
        view = [topLevelObjects objectAtIndex:0];
    }
    
    UIImageView *imageView = (UIImageView *)[view viewWithTag:1];
    UILabel *label = (UILabel *)[view viewWithTag:2];
    
    imageView.image = [imagesArray objectAtIndex:row];
    label.text = [stringsArray objectAtIndex:row];
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.delegate changeTextField:[stringsArray objectAtIndex:row]];
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
