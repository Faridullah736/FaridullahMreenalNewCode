//
//  galleryPhotoVC.m
//  Mreedazzle
//
//  Created by Faridullah on 10/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "galleryPhotoVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Social/Social.h>

@interface galleryPhotoVC ()
@end

@implementation galleryPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [self.popUpView setHidden:YES];
    
    [self.photoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    [self getImageVideosFromGallery:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getImageVideosFromGallery:(void(^)(void))completion{
     _recentpictureArray=[[NSMutableArray alloc]init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSString *albumName = [group valueForProperty:ALAssetsGroupPropertyName];
        if ([albumName isEqualToString:@"Mreedazzle Album"]) {
            [group setAssetsFilter:[ALAssetsFilter allAssets]];
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
                
                if (alAsset) {
                    
                    if ([[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                        NSLog(@"Video");
                    }
                    else{
                        //ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                        //UIImage  *imgThumb = [UIImage imageWithCGImage:[alAsset thumbnail]];
                        UIImage *imgOriginal = [UIImage imageWithCGImage:[[alAsset defaultRepresentation]fullScreenImage]];
                        [_recentpictureArray addObject:imgOriginal];
                         [self.photoCollectionView reloadData]; // you can reload your collection view
                    }
                }
            }];
            
            if (group == nil)
            {
                completion();
            }
            
        }
    }failureBlock: ^(NSError *error) {
        NSLog(@"No groups");
    }];
    NSLog(@"Count : %lu",(unsigned long)[_recentpictureArray count]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UICollectionView Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _recentpictureArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identifier = @"photoCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundView=[[UIImageView alloc] initWithImage:_recentpictureArray[indexPath.row]];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
   
    [self.popUpView setHidden:NO];
    _fullImageView.image=_recentpictureArray[indexPath.row];
}

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)removePopUpViewAction:(id)sender {
    [self.popUpView setHidden:YES];
}

- (IBAction)shareImageAction:(id)sender {
   
    NSArray * shareItems = @[_fullImageView.image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
}


@end
