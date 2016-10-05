//
//  HomeVC.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "HomeVC.h"
#import "Constants.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "DressOptionsCollection.h"
#import "UtilityClass.h"
#import "AppMenuManager.h"



@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.backgroundImage = [UIImage new];
     self.item = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5"];
    // Do any additional setup after loading the view, typically from a nib.
    _photoView.clipsToBounds = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self prefersStatusBarHidden];
    [self setNavigationProperties];

    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self prefersStatusBarHidden];
    self.mm_drawerController.navigationController.navigationBarHidden = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return DRESS_CHOICE.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identifier = @"DressOptionsCollection";
    DressOptionsCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[DRESS_CHOICE objectAtIndex:indexPath.row]]];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    [_collectionView    setHidden:NO];
    [_lblSelectedOption setText:[DRESS_CHOICE objectAtIndex:indexPath.row]];
    [_lblSelectedOption setTag:indexPath.row];
    [_leftMenuContainer setHidden:NO];
    
}
#pragma mark - UINavigation Properties

- (void)setNavigationProperties
{
    self.mm_drawerController.navigationController.navigationBarHidden = YES;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (IBAction)btnMenuPressed:(id)sender {
    
    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
    [_searchBar resignFirstResponder];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)btnFinishPressed:(id)sender {


}

- (IBAction)btnBackPressed:(id)sender {
    
    [_leftMenuContainer setHidden:YES];
    [_collectionView    setHidden:NO];
}

- (IBAction)btnFilterPressed:(id)sender {
    
    if ([self getFilterForSelectedItem:_lblSelectedOption.tag] != nil) {
        
        DYAlertPickView *picker = [[DYAlertPickView alloc] initWithHeaderTitle:_lblSelectedOption.text cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Done" switchButtonTitle:@""];
        picker.delegate = self;
        picker.dataSource = self;
        [picker showAndSelectedIndex:3];
        
    }
 
}
#pragma mark - DYAlertPickView Delegate Methods
- (NSAttributedString *)pickerview:(DYAlertPickView *)pickerView titleForRow:(NSInteger)row{
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:[self getFilterForSelectedItem:_lblSelectedOption.tag][row]];
    return str;
}
- (NSInteger)numberOfRowsInPickerview:(DYAlertPickView *)pickerView {
    return [self getFilterForSelectedItem:_lblSelectedOption.tag].count;
}
- (void)pickerview:(DYAlertPickView *)pickerView didConfirmWithItemAtRow:(NSInteger)row{
    NSLog(@"%@ didConfirm", DRESS_FILTER[row]);
}

- (void)pickerviewDidClickCancelButton:(DYAlertPickView *)pickerView {
    NSLog(@"Canceled");
}

- (NSArray *)getFilterForSelectedItem:(NSInteger)index
{
    switch (index) {
        case kTypeCoats:
            return COATS_FILTER;
            break;
        case kTypeDresses:
            return DRESS_FILTER;
            break;
        case kTypeEvenings:
            return EVENING_FILTER;
            break;
        case kTypeJackets:
            return JACKETS_AND_VESTS_FILTER;
            break;
        case kTypeJeans:
            return JEANS_FILTER;
            break;
        case kTypeJumpSuits:
            return nil;
            break;
        case kTypeNighty:
            return nil;
            break;
        case kTypeSkirts:
            return nil;
            break;
        case kTypeSweaters:
            return SWEATERS_FILTER;
            break;
        case kTypeSwimWear:
            return SWIMWEAR_AND_COVERUPS_FILTER;
            break;
        case kTypeTops:
            return TOPS_FILTER;
            break;
            
        default:
            return nil;
            break;
    }
}
- (IBAction)cultureChangeBtnAction:(id)sender {
    if ([sender isSelected]) {
        [sender setSelected: NO];
        [sender setBackgroundColor:[UIColor clearColor]];
        
    } else {
        [sender setSelected: YES];
    }
}
- (IBAction)cameraBtnAction:(id)sender {
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    _photoView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    _photoView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - TGCameraDelegate optional

- (void)cameraWillTakePhoto
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)cameraDidSavePhotoAtPath:(NSURL *)assetURL
{
    NSLog(@"%s album path: %@", __PRETTY_FUNCTION__, assetURL);
}

- (void)cameraDidSavePhotoWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __PRETTY_FUNCTION__, error);
}


@end
