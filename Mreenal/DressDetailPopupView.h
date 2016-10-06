//
//  DressDetailPopupView.h
//  Mreedazzle
//
//  Created by Faridullah on 10/6/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DressDetailPopupView : UIViewController
@property (strong, nonatomic) IBOutlet UIView *popUpView;
- (IBAction)closeBtnAction:(id)sender;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@end
