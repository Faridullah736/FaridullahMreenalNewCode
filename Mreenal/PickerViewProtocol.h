//
//  PickerViewProtocol.h
//  Meehab
//
//  Created by xain ul abidin on 8/19/15.
//  Copyright (c) 2015 Masroor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol PickerViewProtocol <NSObject>

-(void)didDone:(NSString *)selectedValueFromPicker :(kPickerType)pickerType;

@end
