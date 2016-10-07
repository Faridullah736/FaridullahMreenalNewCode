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
#import "DressDetailPopupView.h"
#import "galleryPhotoVC.h"


@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.backgroundImage = [UIImage new];
     self.item = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5"];
    // Do any additional setup after loading the view, typically from a nib.
    _photoView.clipsToBounds = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(EmailToFashionExpertsNotification:)
                                                 name:@"EmailToFashionExperts"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(photoGalleryNotification:)
                                                 name:@"photoGallery"
                                               object:nil];
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
- (void) photoGalleryNotification:(NSNotification *) notification
{
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    galleryPhotoVC *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_PHOTOGALLERY_VC];
    [self presentViewController:Instance animated:YES completion:nil];
}
- (void) EmailToFashionExpertsNotification:(NSNotification *) notification
{
    // From within your active view controller
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;        // Required to invoke mailComposeController when send
        
        [mailCont setSubject:@"Mreedazzle Experts"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@""]];
        [mailCont setMessageBody:@"" isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
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
    self.item=[self getFilterForSelectedItem:indexPath.row];
    [self.dressTableView reloadData];
//    [_collectionView    setHidden:NO];
//    [_lblSelectedOption setText:[DRESS_CHOICE objectAtIndex:indexPath.row]];
//    [_lblSelectedOption setTag:indexPath.row];
    [_leftMenuContainer setHidden:NO];
    
}

#pragma mark - UITableView Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    cell.backgroundColor=[UIColor clearColor];
    UIFont *myFont = [ UIFont systemFontOfSize:11.0f];
    cell.textLabel.font  = myFont;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [self.item objectAtIndex:indexPath.row];
    return cell;
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

    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    DressDetailPopupView *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_DressDetail_Popup_VC];
    Instance.view.backgroundColor=[UIColor clearColor];
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8)
    {
        //For iOS 8
        Instance.providesPresentationContextTransitionStyle = true;
        Instance.definesPresentationContext = true;
        Instance.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    else
    {
        //For iOS 7
        Instance.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    [self presentViewController:Instance animated:YES completion:nil];
}


@end
