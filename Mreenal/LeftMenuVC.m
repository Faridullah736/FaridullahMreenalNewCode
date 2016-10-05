//
//  LeftMenuVC.m
//  Mreedazzle
//
//  Created by Xpired on 4/26/16.
//  Copyright © 2016 Xpired. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserModel.h"
#import "Constants.h"
#import "LeftMenuVC.h"
#import "AppMenuManager.h"
#import "NYAlertManager.h"
#import "AppDelegate.h"

@interface LeftMenuVC ()

@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    _totalRowsForLeftMenu = LEFT_MENU_OPTIONS.count;
    _menuOptions = [NSMutableArray arrayWithArray:LEFT_MENU_OPTIONS];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.view layoutIfNeeded];
    [self setupProfileDetails];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _totalRowsForLeftMenu;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    [cell.textLabel setText:[_menuOptions objectAtIndex:indexPath.row]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont fontWithName:OPEN_SANS size:12]];
    cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
//    [cell.imageView setImage:[UIImage imageNamed:[LEFT_MENU_IMAGES objectAtIndex:indexPath.row]]];
    [cell setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:57.0/255.0 alpha:1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            
        case kOptionBySeason:
            [self addBySeasonSubOptions];
            break;
        case kOptionBrands:
            
            break;
        case kOptionDesignerBrands:
            
            break;
        case kOptionType:
            break;
        case kOptionLogout:
            [self logoutUser];
            break;
        default:
            
            break;
    }
    
    
}
- (void)updateDataArray :(NSArray *)dataArray
{
//    for (int i =1; i == dataArray.count; i++) {
    [_menuOptions insertObject:@"aa" atIndex:1];
    [_menuOptions insertObject:@"aa" atIndex:2];
    [_menuOptions insertObject:@"aa" atIndex:3];
    [_menuOptions insertObject:@"aa" atIndex:4];
//    }
    
}
- (void)updateDataSource :(NSInteger)rows
{
    _totalRowsForLeftMenu = _totalRowsForLeftMenu + rows;
}
- (void)addBySeasonSubOptions
{
    [self updateDataSource:BY_SEASON_OPTIONS.count];
    [self updateDataArray:BY_SEASON_OPTIONS];
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (int i = 0; i < BY_SEASON_OPTIONS.count; i++)
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    
    [_tableViewLeftMenu beginUpdates];
    [_tableViewLeftMenu insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [_tableViewLeftMenu endUpdates];
   
  
}
- (void)logoutUser
{
        [NYAlertManager showAlertViewWithMessage:MSG_LOGOUT_MSG forViewController:self :^(BOOL okPressed) {
            
            if (okPressed)
            {
                AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                [appDelegate showLoginViewController];
            }
            else
                [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
    
    
}
- (void)setupProfileDetails
{
    [_imgProfileDp.layer            setCornerRadius: _imgProfileDp.frame.size.height/2];
    [_imgProfileDp.layer            setMasksToBounds: YES];
    [_imgProfileDp.layer            setBorderWidth:10.0];
    [_imgProfileDp.layer            setBorderColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f].CGColor];
    
    [_imgProfileBg sd_setImageWithURL:[NSURL URLWithString:USER_MODEL_MANAGER.imageUrl]
                                    placeholderImage:[UIImage imageNamed:@"imgPlaceHolder"]];
    [_imgProfileDp sd_setImageWithURL:[NSURL URLWithString:USER_MODEL_MANAGER.imageUrl]
                                    placeholderImage:[UIImage imageNamed:@"imgPlaceHolder"]];
    
    [_lblName setText:[NSString stringWithFormat:@"%@ %@",USER_MODEL_MANAGER.fname,USER_MODEL_MANAGER.lname]];
}

- (IBAction)btnInboxPressed:(id)sender {
}

- (IBAction)btnProfilePressed:(id)sender {
    
}

- (IBAction)btnCartPressed:(id)sender {
}
@end
