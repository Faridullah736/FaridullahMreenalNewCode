//
//  ActionSheet.m
//  Mreenal
//
//  Created by Xpired on 3/31/16.
//  Copyright © 2016 Xpired. All rights reserved.
//
#import "UtilityClass.h"
#import "ActionSheet.h"

@implementation ActionSheet


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnCameraPressed:(id)sender {
    
    [self presentViewController:[self getImagePicker:YES] animated:YES completion:^{}];
}

- (IBAction)btnGalleryPressed:(id)sender {
    
    [self presentViewController:[self getImagePicker:NO] animated:YES completion:^{}];
}

- (IBAction)btnCancelPressed:(id)sender {
    
    [UtilityClass removeSubViewFromParent:self];
    
}
- (UIImagePickerController *)getImagePicker :(BOOL)isCamera
{
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = isCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerController setDelegate:self];
    return imagePickerController;

}
#pragma mark - UIImagePickerController Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [_delegate didRecieveImage:image];
        [UtilityClass removeSubViewFromParent:self];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    NSLog(@"cancel picking image");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
