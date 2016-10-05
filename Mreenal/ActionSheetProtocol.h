//
//  ActionSheetProtocol.h
//  Mreenal
//
//  Created by Xpired on 4/5/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ActionSheetProtocol <NSObject>

@required

- (void)didRecieveImage:(UIImage *)image;

@end
