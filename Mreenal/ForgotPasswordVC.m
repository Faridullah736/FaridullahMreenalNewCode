//
//  ForgotPasswordVC.m
//  Mreedazzle
//
//  Created by Xpired on 4/18/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "Constants.h"
#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextFieldsPlaceHolderColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self setNavigationProperties];
}
- (void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationProperties
{
    self.navigationItem.title = @"Forgot Password";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:OPEN_SANS_BOLD size:16.0], NSFontAttributeName, nil];
    
}
- (void)setTextFieldsPlaceHolderColor
{
    [_txtEmail        setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
}

@end
