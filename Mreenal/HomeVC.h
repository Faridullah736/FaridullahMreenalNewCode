//
//  HomeVC.h
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAlertPickView.h"
#import "TGCameraViewController.h"

@interface HomeVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,DYAlertPickViewDataSource, DYAlertPickViewDelegate,TGCameraDelegate>

@property (weak, nonatomic) IBOutlet UIView *leftMenuContainer;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedOption;
@property NSArray *item;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTopLeftMenuView;
@property (strong, nonatomic) IBOutlet UIImageView *photoView;


- (IBAction)btnMenuPressed:(id)sender;
- (IBAction)btnFinishPressed:(id)sender;
- (IBAction)btnBackPressed:(id)sender;
- (IBAction)btnFilterPressed:(id)sender;

@end
