//
//  TermsAndConditionsVC.m
//  Mreedazzle
//
//  Created by Xpired on 5/2/16.
//  Copyright © 2016 Xpired. All rights reserved.
//
#import "UtilityClass.h"
#import "TermsAndConditionsVC.h"

@interface TermsAndConditionsVC ()

@end

@implementation TermsAndConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (IBAction)btnAgreePressed:(id)sender {
    [UtilityClass removeBounceSubViewFromParent:self];
}
@end
