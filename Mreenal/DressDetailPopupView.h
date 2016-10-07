//
//  DressDetailPopupView.h
//  Mreedazzle
//
//  Created by Faridullah on 10/6/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGCameraViewController.h"

@interface DressDetailPopupView : UIViewController<TGCameraDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic)          UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIView *popUpView;
- (IBAction)closeBtnAction:(id)sender;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (IBAction)TryOnAvaterBtnAction:(id)sender;
- (IBAction)addToListBtnAction:(id)sender;
- (IBAction)ShoppingListBtnAction:(id)sender;
- (IBAction)TryOnMeBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTxtView;


@property (weak) id<TGCameraDelegate> delegate;
@end
