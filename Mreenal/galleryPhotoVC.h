//
//  galleryPhotoVC.h
//  Mreedazzle
//
//  Created by Faridullah on 10/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface galleryPhotoVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray * _recentpictureArray;
}
@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (strong, nonatomic) IBOutlet UIView *popUpView;
- (IBAction)removePopUpViewAction:(id)sender;
- (IBAction)shareImageAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *fullImageView;

@end
