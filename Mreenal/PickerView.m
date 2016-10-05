//
//  PickerView.m
//  Meehab
//
//  Created by xain ul abidin on 8/19/15.
//  Copyright (c) 2015 Masroor. All rights reserved.
//

#import "PickerView.h"
#import "Constants.h"
#import "UtilityClass.h"

@implementation PickerView

@synthesize selectValue,selectValue2,btnDone;

- (void)addBlackOverlay :(UIViewController *)viewController
{
    _backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)];
    _backview.backgroundColor = [UIColor blackColor];
    _backview.alpha = 0.3;
    [viewController.view addSubview:_backview];
}
- (CGRect)getPickerViewFrame : (UIViewController *)viewController
{
    CGFloat viewHeight = [[viewController view] frame].size.height;
    float y = viewHeight - 216 - PICKER_VIEW_TOOL_BAR_HEIGHT;
    CGRect frame = CGRectMake(0, y, viewController.view.frame.size.width, 216 + PICKER_VIEW_TOOL_BAR_HEIGHT);
    return frame;
}
- (id)initWithViewController:(UIViewController *)viewController withTitle:(NSString *)title withPickerType:(int)pickerType
{

    [self addBlackOverlay:viewController];
    self = [super initWithFrame:[self getPickerViewFrame:viewController]];
    
    _pickerType = pickerType;
    
    CGFloat screenWidths = [UIScreen mainScreen].bounds.size.width;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidths, 44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIImage *imgbtnDone     = [[UIImage imageNamed:@"btnDoneSmall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imgbtnCancel   = [[UIImage imageNamed:@"btnCancelSmall"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithImage:imgbtnDone
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(btnDonePressed)];
    UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithImage:imgbtnCancel
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(btnCancelPressed)];
    
    UILabel *toolbarLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    toolbarLabel.text = title;
    [toolbarLabel sizeToFit];
    [toolbarLabel setFont:[UIFont fontWithName:@"Open Sans" size:15]];
    toolbarLabel.backgroundColor = [UIColor clearColor];
    toolbarLabel.textColor = [UIColor whiteColor];
    toolbarLabel.textAlignment = NSTextAlignmentCenter;
    UIBarButtonItem *labelItem = [[UIBarButtonItem alloc] initWithCustomView:toolbarLabel];
    
    
    
    toolBar.items = @[barButtonCancel,flex,labelItem,flex,barButtonDone];
    toolBar.barTintColor = [UIColor blackColor];
    barButtonDone.tintColor = [UIColor blackColor];
    barButtonCancel.tintColor = [UIColor blackColor];
    
    
    if (pickerType == kDatePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, PICKER_VIEW_TOOL_BAR_HEIGHT, self.frame.size.width, self.frame.size.height)];
        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
        self.datePicker.maximumDate = [NSDate date];
        [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.datePicker.backgroundColor = [UIColor blackColor];
        self.datePicker.alpha = 0.9;
        [self.datePicker setValue:[UIColor colorWithRed:(234.0/255.0) green:(168.0/255.0) blue:(56.0/255.0) alpha:1] forKey:@"textColor"];
        [self addSubview:_datePicker];
        [self addSubview:toolBar];
    }
    else
    {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, PICKER_VIEW_TOOL_BAR_HEIGHT, self.frame.size.width, self.frame.size.height)];
        _pickerView.backgroundColor = [UIColor blackColor];
    _pickerView.delegate   = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.alpha = 0.9;
    
    [self addSubview:_pickerView];
    [self addSubview:toolBar];
    }
    
    return self;
    
}


-(void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:DATE_FORMATE];
    selectValue = [_dateFormatter stringFromDate:datePicker.date];
    NSLog(@"%@",selectValue);
}


-(void)btnDonePressed
{
    if (_component == 2 && selectValue != nil && selectValue2 != nil)
        selectValue = [selectValue stringByAppendingString:selectValue2];
    
        selectValue == nil ? [self btnCancelPressed] : [self.delegate didDone:selectValue:_pickerType];
    
    
    [self removeViewsFromSuperView];
    
}

-(void)btnCancelPressed{
    
    [self removeViewsFromSuperView];
    
}
- (void)removeViewsFromSuperView
{
    [_backview removeFromSuperview];
    [self removeFromSuperview];
}
#pragma mark - PickerView Delegate Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _component;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return component == 0 ? [_pickerDataArray count] : [_pickerDataArray2 count];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return component == 0 ? [_pickerDataArray objectAtIndex:row] : [_pickerDataArray2 objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
        selectValue = [_pickerDataArray objectAtIndex:(NSUInteger)row];
    else
        selectValue2 = [_pickerDataArray2 objectAtIndex:(NSUInteger)row];
    
    
    NSLog(@"value is: %@:%@",selectValue,selectValue2);
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    return component == 0 ? [self setLabelText:[_pickerDataArray objectAtIndex:row] ofLable:(UILabel *)view] : [self setLabelText:[_pickerDataArray2 objectAtIndex:row] ofLable:(UILabel *)view];
    
}
- (UILabel *)setLabelText:(NSString *)text ofLable:(UILabel *)lbl
{
    CGRect frame = CGRectMake(0.0, 0.0, 220, 32);
    lbl = [[UILabel alloc] initWithFrame:frame];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor colorWithRed:(234.0/255.0) green:(168.0/255.0) blue:(56.0/255.0) alpha:1]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setFont:[UIFont fontWithName:@"Open Sans" size:18]];
    [lbl setAdjustsFontSizeToFitWidth: YES];
    [lbl setMinimumScaleFactor :0.5];
    [lbl setText:text];
    return lbl;
}
@end
