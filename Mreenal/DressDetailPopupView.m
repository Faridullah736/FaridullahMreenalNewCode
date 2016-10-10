//
//  DressDetailPopupView.m
//  Mreedazzle
//
//  Created by Faridullah on 10/6/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "DressDetailPopupView.h"
#import "TGPhotoViewController.h"
#import "Constants.h"
#import "TryOnVC.h"
#import "payementVC.h"

@interface DressDetailPopupView ()

@end

@implementation DressDetailPopupView

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",[_detailArray valueForKey:@"priceLabel"]);
    _priceLbl.text=[NSString stringWithFormat:@"Price:%@",[_detailArray valueForKey:@"priceLabel"]];
    _descriptionTxtView.text=[_detailArray valueForKey:@"description"];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[_detailArray valueForKey:@"image"] valueForKey:@"sizes"] valueForKey:@"Original"] valueForKey:@"url"]]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _detailImage.image = [UIImage imageWithData: data];
        });
        
    });
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self removeAnimate];
}
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

- (IBAction)TryOnAvaterBtnAction:(id)sender {
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    TryOnVC *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_TRYON_VC];
    [self presentViewController:Instance animated:YES completion:nil];
}
- (IBAction)addToListBtnAction:(id)sender {
}

- (IBAction)ShoppingListBtnAction:(id)sender {
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    payementVC *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_PAYEMENT_VC];
    [self presentViewController:Instance animated:YES completion:nil];
}

- (IBAction)TryOnMeBtnAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"takePhoto" object:self];
    
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:MSG_ALERT_TITLE message:@"Mreedazzle Photos" preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        
//        // Cancel button tappped.
////        [self dismissViewControllerAnimated:YES completion:^{
////        }];
//        
//    }]];
//    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        //        [self dismissViewControllerAnimated:YES completion:^{
//        //        }];
//        // Distructive button tapped.
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"takePhoto" object:self];
//   
//    }]];
//    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        // OK button tapped.
//      [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoFromGallery" object:self];
//    }]];
//    
//    // Present action sheet.
//    [self presentViewController:actionSheet animated:YES completion:nil];
}


@end
