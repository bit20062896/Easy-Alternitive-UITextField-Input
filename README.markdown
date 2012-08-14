Easy Alternative UITextField Input
============

Easily override normal UITextField keyboard function with a custom UIPickerView. Comes with several reusable templates for quick setup. 
Features:
---------

* The picker fades out the background to prevent the user from selecting anything else while making a selection.

* Scrolls the selected UITextField into view.

* Tapping the background will close the picker.

* Easily add a custom UIToolbar to the picker, comes with already set up tie in methods for "Done", "Cancel", and "Clear".

Templates:
----------

* Basic Picker - Presents a list of possible selections. Uses an NSArray of NSStrings.

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/BasicPicker.png?raw=true "Basic Picker")

* Date Picker - Well, its a date picker, nothing to explain here…

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/DatePicker.png?raw=true "Date Picker")

* Image Picker - Presents a list of possible selections, showing an image and a title. Uses an NSArray of NSStrings, and an NSArray of UIImages.

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/ImagePicker.png?raw=true "Image Picker")

* Infinite Picker - An infinite version of the Basic Picker. Uses an NSArray of NSStrings. (Not really infinite, but will seem like it to the user. To increase the "Infiniticity" of the picker just increase the number of rows.

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/InfinitePicker.png?raw=true "Infinite Picker")

* Number Picker - Can be used to have a user select a number or money amount. Just initialize it with the number of columns needed. To to add a decimal point to a column, use "addDecimalPointToComponentIndex:", the picker can have multiple decimal points (Useful if you want something like an IPAddress.) To add a leading symbol to the first column, set the picker's "leadingSymbol" property (Useful if you want to select a money amount.) Use "setLowerLimit:andUpperLimit:forComponentIndex:" to set upper and lower bound of a column. This supports any bound, including negatives. The default bounds are 0-9.

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/Number-MoneyPickerWithToolBar.png?raw=true "Number-MoneyPickerWithToolBar")

* Place Picker - Select a place (like in a competition). Set a lowest place limit during initialization.

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/PlacePicker.png?raw=true "Place Picker")

* Keyboard - If you are displaying pickers in a view with multiple UITextFields, and one of them displays a keyboard, YOU MUST USE THIS OVERRIDE! This prevents an issue where if the user had the keyboard open, and selects a UITextField that shows a UIPickerView, the picker would display behind the keyboard, and set the first responder to the picker's text field.

![screenshot](http://github.com/Marxon13/Easy-Alternitive-UITextField-Input/blob/master/KeyboardWithToolbar.png?raw=true "Keyboard")

* I will continue to add templates as I make them, or send your own template to me and I'll include it!

Usage
-----
* First import everything in the classes folder into your project. Then #import ATFIPresentationViewController.h and any .h files for the pickers you want to use into your UIViewController subclass.

* Make your UIViewController subclass a UItextFieldDelegate, and set the delegates for all the textFields to the UIViewController subclass.

* Override "- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField" initialize and display the picker you want to display. Always return NO.

* Display the picker with one method, and the picker will handle everything else.
 "[self.presentationController presentATFIViewController:controller withToolbar:nil forTextField:textField overScrollView:scrollView inViewController:self]"

* Check out the sample to see how each picker is loaded and displayed.