//
//  PickerView.h
//  Meehab
//
//  Created by xain ul abidin on 8/19/15.
//  Copyright (c) 2015 Masroor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewProtocol.h"

@interface PickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>


@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIView *backview;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSArray *pickerDataArray;
@property (nonatomic, strong) NSArray *pickerDataArray2;
@property (nonatomic, assign) int component;
@property (nonatomic, strong) UILabel *lblPicker;
@property (nonatomic, strong) id<PickerViewProtocol> delegate;
@property (strong, nonatomic) NSString *selectValue;
@property (strong, nonatomic) NSString *selectValue2;
@property (nonatomic) int pickerType;

- (id)initWithViewController:(UIViewController *)viewController withTitle:(NSString *)title withPickerType:(int)pickerType;

@end
