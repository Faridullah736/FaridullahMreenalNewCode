//
//  HomeVC.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//
@import MobileCoreServices;
#import "HomeVC.h"
#import "Constants.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "DressOptionsCollection.h"
#import "UtilityClass.h"
#import "AppMenuManager.h"
#import "DressDetailPopupView.h"
#import "galleryPhotoVC.h"
#import "TryOnVC.h"
#import "TGPhotoViewController.h"
#import "expandDressCollectionViewCell.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(takePhotoNotification:)
                                                 name:@"takePhoto"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(PhotoFromGalleryNotification:)
                                                 name:@"PhotoFromGallery"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ExpandDressOptionNotification:)
                                                 name:@"ExpandDressOption"
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
-(void)ExpandDressOptionNotification:(NSNotification*)notification{
    NSDictionary* userInfo = notification.userInfo;
    expandDressesArray=[NSMutableArray arrayWithObjects:userInfo, nil];
    for (int i=0;i<[expandDressesArray[0] count]-1;i++) {
        [expandDressesArray addObject:[expandDressesArray[0] objectAtIndex:i]];
    }
    [self.expandCollectionCellView reloadData];
}
-(void)takePhotoNotification:(NSNotification*)notification{
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}
-(void)PhotoFromGalleryNotification:(NSNotification*)notification{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
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
    if (collectionView==self.expandCollectionCellView) {
        //NSLog(@"%lu",(unsigned long)expandDressesArray.count);
        return [expandDressesArray count];
    } else{
    return DRESS_CHOICE.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==self.expandCollectionCellView) {
        static NSString *identifier = @"ExpandDressCollection";
        expandDressCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[expandDressesArray[0][indexPath.row] valueForKey:@"image"] valueForKey:@"sizes"] valueForKey:@"Medium"] valueForKey:@"url"]]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                cell.expandDressImage.image = [UIImage imageWithData: data];
            });
           
        });
        cell.priceLabel.transform=CGAffineTransformMakeRotation(M_PI / 4);
        cell.priceLabel.text=[expandDressesArray[0][indexPath.row] valueForKey:@"priceLabel"];
        return cell;
    }else{
    
    static NSString *identifier = @"DressOptionsCollection";
    DressOptionsCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[DRESS_CHOICE objectAtIndex:indexPath.row]]];
        return cell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    if (collectionView==self.expandCollectionCellView) {
        UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
        DressDetailPopupView *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_DressDetail_Popup_VC];
        Instance.detailArray=[expandDressesArray objectAtIndex:indexPath.row];
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
    }else{
    self.item=[self getFilterForSelectedItem:indexPath.row];
    [self.dressTableView reloadData];
    [_lblSelectedOption setText:[DRESS_CHOICE objectAtIndex:indexPath.row]];
    [_leftMenuContainer setHidden:NO];
    }
    
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_leftMenuContainer setHidden:YES];
    [_collectionView    setHidden:YES];
    [_expandCollectionView setHidden:NO];
    [_expandCollectionView getDataFromProductAPI:_lblSelectedOption.text];
 
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
    expandDressesArray=[[NSMutableArray alloc] init];
    [self.expandCollectionCellView reloadData];
    [_expandCollectionView setHidden:YES];
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

 
}
#pragma mark -
#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    //_photoView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    // NSDictionary* userInfo = @{@"TryOnImage": @(image)};
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    TryOnVC *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_TRYON_VC];
    Instance.passImage=image;
    Instance.userImage=YES;
    [self presentViewController:Instance animated:YES completion:nil];
    
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    //_photoView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    TryOnVC *Instance  = [mystoryboard instantiateViewControllerWithIdentifier:ID_TRYON_VC];
    Instance.passImage=image;
    Instance.userImage=YES;
    [self presentViewController:Instance animated:YES completion:nil];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
     UIImage *photo=[TGAlbum imageWithMediaInfo:info];;
    [picker dismissViewControllerAnimated:YES completion:nil];
    TGPhotoViewController *viewController = [TGPhotoViewController newWithDelegate:_delegate photo:photo];
    //[self.navigationController pushViewController:viewController animated:YES];
    [viewController setAlbumPhoto:YES];
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
