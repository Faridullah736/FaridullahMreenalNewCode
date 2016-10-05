//
//  LeftMenuVC.h
//  Mreedazzle
//
//  Created by Xpired on 4/26/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewLeftMenu;
@property (nonatomic)                NSInteger totalRowsForLeftMenu;
@property (strong, nonatomic)        NSMutableArray *menuOptions;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfileBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfileDp;
@property (weak, nonatomic) IBOutlet UILabel *lblName;


- (IBAction)btnInboxPressed:(id)sender;
- (IBAction)btnProfilePressed:(id)sender;
- (IBAction)btnCartPressed:(id)sender;

@end
