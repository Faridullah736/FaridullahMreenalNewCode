//
//  TGPhotoViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

@import AssetsLibrary;
#import "TGPhotoViewController.h"
#import "TGAssetsLibrary.h"
#import "TGCameraColor.h"
#import "TGCameraFilterView.h"
#import "UIImage+CameraFilters.h"
#import "TGTintedButton.h"


static NSString* const kTGCacheSatureKey = @"TGCacheSatureKey";
static NSString* const kTGCacheCurveKey = @"TGCacheCurveKey";
static NSString* const kTGCacheVignetteKey = @"TGCacheVignetteKey";



@interface TGPhotoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet TGCameraFilterView *filterView;
@property (strong, nonatomic) IBOutlet UIButton *defaultFilterButton;
@property (weak, nonatomic) IBOutlet TGTintedButton *filterWandButton;
@property (weak, nonatomic) IBOutlet TGTintedButton *cancelButton;
@property (weak, nonatomic) IBOutlet TGTintedButton *confirmButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

@property (weak) id<TGCameraDelegate> delegate;
@property (strong, nonatomic) UIView *detailFilterView;
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) NSCache *cachePhoto;
@property (nonatomic) BOOL albumPhoto;

- (IBAction)backTapped;
- (IBAction)confirmTapped;
- (IBAction)filtersTapped;

- (void)addDetailViewToButton:(UIButton *)button;
+ (instancetype)newController;

@end



@implementation TGPhotoViewController

+ (instancetype)newWithDelegate:(id<TGCameraDelegate>)delegate photo:(UIImage *)photo
{
    TGPhotoViewController *viewController = [TGPhotoViewController newController];
    
    if (viewController) {
        viewController.delegate = delegate;
        viewController.photo = photo;
        viewController.cachePhoto = [[NSCache alloc] init];
    }
    
    return viewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (CGRectGetHeight([[UIScreen mainScreen] bounds]) <= 480) {
        _topViewHeight.constant = 0;
    }
    
    _photoView.clipsToBounds = YES;
    _photoView.image = _photo;
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    [_cancelButton setImage:[UIImage imageNamed:@"CameraBack" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_confirmButton setImage:[UIImage imageNamed:@"CameraShot" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_filterWandButton setImage:[UIImage imageNamed:@"CameraFilter" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];

    if ([[TGCamera getOption:kTGCameraOptionHiddenFilterButton] boolValue] == YES) {
        _filterWandButton.hidden = YES;
    }
    
    [self addDetailViewToButton:_defaultFilterButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark - Controller actions

- (IBAction)backTapped
{
    if (_albumPhoto) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)confirmTapped
{
    if ( [_delegate respondsToSelector:@selector(cameraWillTakePhoto)]) {
        [_delegate cameraWillTakePhoto];
        
    }
    
    if ([_delegate respondsToSelector:@selector(cameraDidTakePhoto:)]) {
        _photo = _photoView.image;
        
        if (_albumPhoto) {
            [_delegate cameraDidSelectAlbumPhoto:_photo];
        } else {
            [_delegate cameraDidTakePhoto:_photo];
            
        }
    }
}

- (IBAction)filtersTapped
{
//    if ([_filterView isDescendantOfView:self.view]) {
//        [_filterView removeFromSuperviewAnimated];
//    } else {
//        [_filterView addToView:self.view aboveView:_bottomView];
//        [self.view sendSubviewToBack:_filterView];
//        [self.view sendSubviewToBack:_photoView];
//    }
  //  [self launchPhotoEditorWithImage:_photoView.image];
   // [self displayEditorForImage:_photoView.image];
    
}
- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    AdobeUXImageEditorViewController *editorController = [[AdobeUXImageEditorViewController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:YES completion:nil];
}

- (void)photoEditor:(AdobeUXImageEditorViewController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here and dismiss the editor.
    //[self doSomethingWithImage:image]; // Developer-defined method that presents the final editing-resolution image to the user, perhaps.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoEditorCanceled:(AdobeUXImageEditorViewController *)editor
{
    // Dismiss the editor.
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Private methods

- (void)addDetailViewToButton:(UIButton *)button
{
    [_detailFilterView removeFromSuperview];
    
    CGFloat height = 2.5;
    
    CGRect frame = button.frame;
    frame.size.height = height;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(button.frame) - height;
    
    _detailFilterView = [[UIView alloc] initWithFrame:frame];
    _detailFilterView.backgroundColor = [TGCameraColor tintColor];
    _detailFilterView.userInteractionEnabled = NO;
    
    [button addSubview:_detailFilterView];
}

+ (instancetype)newController
{
    return [[self alloc] initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:self.class]];
}

@end
