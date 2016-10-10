//
//  TryOnVC.m
//  Mreedazzle
//
//  Created by Faridullah on 10/6/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "TryOnVC.h"
#import "Constants.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface TryOnVC ()

@end

@implementation TryOnVC

static NSString * const customPhotoAlbumName = @"Mreedazzle Album";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_userImage) {
        _mainImage.image=_passImage;
    }
    
    UIPanGestureRecognizer * pan1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveObject:)];
    [pan1 setMaximumNumberOfTouches:1];
    [pan1 setMaximumNumberOfTouches:1];
    [_tryOnImageView addGestureRecognizer:pan1];
    
   UIPinchGestureRecognizer* twoFingerPinch = [[UIPinchGestureRecognizer alloc]
                      initWithTarget:self
                      action:@selector(twoFingerPinch:)];
    [_tryOnImageView addGestureRecognizer:twoFingerPinch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)moveObject:(UIPanGestureRecognizer *)pan;
{
    _tryOnImageView.center = [pan locationInView:_tryOnImageView.superview];
}



- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    //    NSLog(@"Pinch scale: %f", recognizer.scale);
    if (recognizer.scale >1.0f && recognizer.scale < 2.5f) {
        CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
        _tryOnImageView.transform = transform;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnAction:(id)sender {
    UIGraphicsBeginImageContext(_tryOnView.frame.size);
    [[_tryOnView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setupPhotoAlbumNamed:customPhotoAlbumName withCompletionHandler:
     ^(ALAssetsLibrary *assetsLibrary, ALAssetsGroup *group) {
         if (group)
         {
             [self addImage:screenshot toAssetsLibrary:assetsLibrary withGroup:group];
         }
     }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MSG_ALERT_TITLE message:@"Your image has been saved!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) setupPhotoAlbumNamed: (NSString*) photoAlbumName withCompletionHandler:(void(^)(ALAssetsLibrary*, ALAssetsGroup*))completion
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak ALAssetsLibrary *weakAssetsLibrary = assetsLibrary;
    [assetsLibrary addAssetsGroupAlbumWithName:photoAlbumName resultBlock:^(ALAssetsGroup *group)
     {
         NSLog(@"%@ Album result: %@", self, (group.editable ? @"success" : @"already existed"));
         if (!group)
         {
             [weakAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *g, BOOL *stop) {
                 if ([[g valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customPhotoAlbumName])
                 {
                     completion(weakAssetsLibrary, g);
                 }
             } failureBlock:^(NSError *error) {
                 NSLog(@"%@ An error has occured with description: %@", self, error.localizedDescription);
                 completion(weakAssetsLibrary, nil);
             }];
         }
         else
         {
             completion(weakAssetsLibrary, group);
         }
     } failureBlock:^(NSError *error)
     {
         NSLog(@"%@ An error has occured with description: %@", self, error.localizedDescription);
         completion(weakAssetsLibrary, nil);
     }];
}

- (void) addImage: (UIImage*) image toAssetsLibrary: (ALAssetsLibrary*) assetsLibrary withGroup: (ALAssetsGroup*) group
{
    [assetsLibrary writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(image) metadata:nil
                                    completionBlock:
     ^(NSURL *assetURL, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@ An error has occured with description: %@", self, error.localizedDescription);
         }
         else
         {
             [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset)
              {
                  [group addAsset:asset];
                  NSLog(@"%@ Image was succesfully added!", self);
              } failureBlock:^(NSError *error) {
                  NSLog(@"%@ An error has occured with description: %@", self, error.localizedDescription);
              }];
         }
     }];
}

@end
