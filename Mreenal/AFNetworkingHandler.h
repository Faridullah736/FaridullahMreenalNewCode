//
//  AFNetworkingHandler.h
//  AFNetWorkingTest
//
//  Created by Masroor Elahi on 12/12/2014.
//  Copyright (c) 2014 Masroor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Reachability.h"
#import "Constants.h"
#import "AppDelegate.h"



@interface AFNetworkingHandler : NSObject

@property (strong, nonatomic) UIViewController *rootViewController;

- (void)postRequestWithMethodName:(NSString *)methodName AndParamaters:(NSMutableDictionary *)paramters andShowSpinner:(BOOL)show WithSuccess:(void(^)(id  responseData, NSString * responseMessage,NSString * resposneStatusCode ))success Failuer:(void (^)(NSString * errorDescription))failure;
- (void)sendGETRequestToServerWithMethodName:(NSString *)methodName AndParamaters:(NSString *)paramters WithSuccess:(void(^)(id  responseData, NSString * responseMessage,NSString * resposneStatusCode ))success Failuer:(void (^)(NSString * errorDescription))failure;
- (void)sendSimpleRequest:(NSString *)URLstring WithSuccess:(void (^)(id  response))success Failure:(void(^)(NSString * errorMessage))errorMessage;
+ (AFNetworkingHandler *)shareManager;


#pragma mark GET/POST with Simple Response For General Purpose

- (void)sendPOSTRequestToServerWithMethodNameGeneric:(NSString *)methodName AndParamaters:(NSMutableDictionary *)paramters WithSuccess:(void(^)(id  responseData))success Failuer:(void (^)(NSString * errorDescription))failure;
- (void)sendGETRequestToServerWithMethodNameGeneric:(NSString *)methodName AndParamaters:(NSString *)paramters WithSuccess:(void(^)(id  responseData))success Failuer:(void (^)(NSString * errorDescription))failure;

#pragma mark Image Download

- (void)downloadImageFromServerWithPath:(NSString *)imageName WithSuccess:(void(^)(UIImage * image))success Failure:(void(^)(NSString *errorMessage))failure;
- (void)downloadImageFromFacebook:(NSString *)imageName WithSuccess:(void(^)(UIImage * image))success Failure:(void(^)(NSString *errorMessage))failure;
-(void)sendPOSTRequestToServerWithMethodNameAndImage:(NSString *)methodName AndParamaters:(NSMutableDictionary *)paramters andShowSpinner:(BOOL)show WithSuccess:(void(^)(id  responseData, NSString * responseMessage,NSString * resposneStatusCode ))success Failuer:(void (^)(NSString * errorDescription))failure;
- (void)changeRootViewController;
//-(void)downloadAndCacheImageOnImageView:(UIImageView *)imageViewForDownload WithUrlString:(NSString *)imageUrlString WithPlaceholderImage:(UIImage *)placeHolderImage;
@end
