//
//  TryOnVC.h
//  Mreedazzle
//
//  Created by Faridullah on 10/6/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TryOnVC : UIViewController<UIGestureRecognizerDelegate>

- (IBAction)backBtnAction:(id)sender;
- (IBAction)saveBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *tryOnImageView;
@property (strong, nonatomic) IBOutlet UIView *tryOnView;
@end
