//
//  ViewController.m
//  EasyAlternitiveUITextFieldInput
//
//  Created by Brandon McQuilkin on 8/11/12.
//  Copyright (c) 2012 Brandon McQuilkin. All rights reserved.
//

#import "ViewController.h"
#import "ATFIDatePickerController.h"
#import "ATFINumberPickerController.h"
#import "ATFIListPickerViewController.h"
#import "ATFICompetitionPlacePickerController.h"
#import "ATFIImagePickerController.h"
#import "ATFIInfinitePickerController.h"
#import "ATFIPresentationViewController.h"

@implementation ViewController

@synthesize datePicker, datePickerWithToolbar, basicPicker, basicPickerWithToolbar, keyboard, keyboardWithToolbar, scrollView, presentationController, numberPicker, numberPickerWithToolbar, placePicker, imagePicker, infinitePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    datePicker.delegate = self;
    datePickerWithToolbar.delegate = self;
    basicPicker.delegate = self;
    basicPickerWithToolbar.delegate = self;
    keyboard.delegate = self;
    keyboardWithToolbar.delegate = self;
    numberPicker.delegate = self;
    numberPickerWithToolbar.delegate = self;
    placePicker.delegate = self;
    imagePicker.delegate = self;
    infinitePicker.delegate = self;
    
    self.presentationController = [[ATFIPresentationViewController alloc] init];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == datePicker) { //Date Picker
        ATFIDatePickerController *controller = [[ATFIDatePickerController alloc] init];
        [self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == datePickerWithToolbar) {
        ATFIDatePickerController *controller = [[ATFIDatePickerController alloc] init];
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)]; //Can't get it to autosize frame to default
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.presentationController action:@selector(cancelTextFieldInput:)],
                         [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self.presentationController action:@selector(clearTextField:)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.presentationController action:@selector(dismissATFIViewController)], nil];
        [self.presentationController presentATFIViewController:controller withToolbar:toolbar forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == keyboard) { //Keyboard
        [self.presentationController presentKeyboardWithToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return YES;
    } else if (textField == keyboardWithToolbar) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)]; //Can't get it to autosize frame to default
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.presentationController action:@selector(cancelKeyboardInput:)],
                         [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self.presentationController action:@selector(clearTextField:)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.presentationController action:@selector(dismissKeyboard)], nil];
        [self.presentationController presentKeyboardWithToolbar:toolbar forTextField:textField overScrollView:scrollView inViewController:self];
        return YES;
    } else if (textField == numberPicker) { //Number Picker
        ATFINumberPickerController *controller = [[ATFINumberPickerController alloc] initWithNumberOfDigits:[NSNumber numberWithInt:4]];
        [controller addDecimalToComponentIndex:[NSNumber numberWithInt:2]];
        [controller setLowerLimit:[NSNumber numberWithInt:5] andUpperLimit:nil forComponentIndex:[NSNumber numberWithInt:3]];
        controller.leadingSymbol = @"$";
        [self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == numberPickerWithToolbar) {
        ATFINumberPickerController *controller = [[ATFINumberPickerController alloc] initWithNumberOfDigits:[NSNumber numberWithInt:4]];
        [controller addDecimalToComponentIndex:[NSNumber numberWithInt:2]];
        [controller setLowerLimit:[NSNumber numberWithInt:5] andUpperLimit:nil forComponentIndex:[NSNumber numberWithInt:3]];
        controller.leadingSymbol = @"$";
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)]; //Can't get it to autosize frame to default
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.presentationController action:@selector(cancelTextFieldInput:)],
                         [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self.presentationController action:@selector(clearTextField:)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.presentationController action:@selector(dismissATFIViewController)], nil];
        [self.presentationController presentATFIViewController:controller withToolbar:toolbar forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == basicPicker) { //list Picker
        ATFIListPickerViewController *controller = [[ATFIListPickerViewController alloc] initWithRowTitles:[NSArray arrayWithObjects:@"Never", @"Gonna", @"Give", @"You", @"Up", nil]];
        [self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == basicPickerWithToolbar)
    {
        ATFIListPickerViewController *controller = [[ATFIListPickerViewController alloc] initWithRowTitles:[NSArray arrayWithObjects:@"Never", @"Gonna", @"Give", @"You", @"Up", nil]];
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)]; //Can't get it to autosize frame to default
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.presentationController action:@selector(cancelTextFieldInput:)],
                         [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self.presentationController action:@selector(clearTextField:)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.presentationController action:@selector(dismissATFIViewController)], nil];
        [self.presentationController presentATFIViewController:controller withToolbar:toolbar forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == placePicker) {
        ATFICompetitionPlacePickerController *controller = [[ATFICompetitionPlacePickerController alloc] initWithLowestPlace:[NSNumber numberWithInt:15]];
        [self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == imagePicker) {
        NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"UITabBarBookmarks.jpg"], [UIImage imageNamed:@"UITabBarContacts.jpg"], [UIImage imageNamed:@"UITabBarDownloads.jpg"], [UIImage imageNamed:@"UITabBarFavorites.jpg"], [UIImage imageNamed:@"UITabBarFeatured.jpg"], [UIImage imageNamed:@"UITabBarHistory.jpg"],  [UIImage imageNamed:@"UITabBarMore.jpg"], [UIImage imageNamed:@"UITabBarMostRecent.jpg"], [UIImage imageNamed:@"UITabBarMostViewed.jpg"], [UIImage imageNamed:@"UITabBarRecents.jpg"], [UIImage imageNamed:@"UITabBarSearch.jpg"], [UIImage imageNamed:@"UITabBarTopRated.jpg"], nil];
        NSArray *strings = [NSArray arrayWithObjects:@"Bookmarks", @"Contacts", @"Downloads", @"Favorites", @"Featured", @"History", @"More", @"Most Recent", @"Most Viewed", @"Recent", @"Search", @"Top Rated", nil];
        ATFIImagePickerController *controller = [[ATFIImagePickerController alloc] initWithStrings:strings andImages:images];
        [self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    } else if (textField == infinitePicker) {
        NSArray *strings = [NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", nil];
        ATFIInfinitePickerController *controller = [[ATFIInfinitePickerController alloc] initWithRowTitles:strings];
        [self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self];
        return NO;
    }
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
