//
//  ActionSheet.h
//  Mreenal
//
//  Created by Xpired on 3/31/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetProtocol.h"

@interface ActionSheet : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) id<ActionSheetProtocol> delegate;

- (IBAction)btnCameraPressed:(id)sender;
- (IBAction)btnGalleryPressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;

@end
