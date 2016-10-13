//
//  AFNetworkingHandler.m
//  AFNetWorkingTest
//
//  Created by Masroor Elahi on 12/12/2014.
//  Copyright (c) 2014 Masroor. All rights reserved.
//

#import "AFNetworkingHandler.h"
#import "AFNetworking.h"
#import "UtilityClass.h"
//#import "FacebookHandler.h"
//#import "UIImageView+WebCache.h"
//#import "SDWebImageDownloader.h"
//#import "SDWebImageManager.h"
//#import "UIImageView+UIActivityIndicatorForSDWebImage.h"


@interface AFNetworkingHandler()
@property (strong,nonatomic)AFHTTPRequestOperationManager * Af_network_handler;
@end
@implementation AFNetworkingHandler

+(AFNetworkingHandler *)shareManager
{
    static AFNetworkingHandler *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.rootViewController = [UtilityClass getRootViewController];
    });
    return sharedMyManager;
}

- (void)changeRootViewController
{
    self.rootViewController = [UtilityClass getRootViewController];
}



#pragma mark Send Post with paramaters
-(void)postRequestWithMethodName:(NSString *)methodName AndParamaters:(NSMutableDictionary *)paramters andShowSpinner:(BOOL)show WithSuccess:(void(^)(id  responseData, NSString * responseMessage,NSString * resposneStatusCode))success Failuer:(void (^)(NSString * errorDescription))failure
{
    if([self checkInternetAvailablity])
    {
   
        _Af_network_handler=[AFHTTPRequestOperationManager manager];
        NSString * stringUrlForPOST=[NSString stringWithFormat:@"%@methodName=%@",SERVER_INDEX_PATH,methodName];
        NSLog(@"%@",stringUrlForPOST);
        
        show ? [UTILITY_MANAGER showSpinner:_rootViewController] : 0;
        [_Af_network_handler POST:stringUrlForPOST parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(responseObject)
                {
                    NSLog(@"%@",responseObject);
                    [UTILITY_MANAGER hideSpinner:_rootViewController];
                    responseObject=[self checkResponseValidity:[responseObject mutableCopy]];
                    success([responseObject objectForKey:RESPONSE_DATA_KEY],[responseObject objectForKey:RESPONSE_MESSAGE_KEY],[NSString stringWithFormat:@"%@",[responseObject objectForKey:RESPONSE_STATUS_KEY]]);
                }
                else
                {
                    [UTILITY_MANAGER hideSpinner:_rootViewController];
                    failure(RESPONSE_NO_DATA_ERROR);
                }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    if(error.code==-1001||error.code==-1003||error.code==-1005||error.code==-1009)
                    {

                        [UTILITY_MANAGER hideSpinner:_rootViewController];
                        failure(MSG_ERROR_INTERNET);
                    }

        }];
    }
    else
    {

        show ? [UTILITY_MANAGER hideSpinner:_rootViewController]: 0;
        failure(MSG_ERROR_INTERNET);
    }
}
-(void)sendPOSTRequestToServerWithMethodNameAndImage:(NSString *)methodName AndParamaters:(NSMutableDictionary *)paramters andShowSpinner:(BOOL)show WithSuccess:(void(^)(id  responseData, NSString * responseMessage,NSString * resposneStatusCode ))success Failuer:(void (^)(NSString * errorDescription))failure
{
    if([self checkInternetAvailablity])
    {
        NSString    *imagename          =   [paramters valueForKey:KEY_USER_IMAGE_NAME];
        NSData      *imageData          =   [paramters valueForKey:KEY_USER_IMAGE_DATA];
        _Af_network_handler=[AFHTTPRequestOperationManager manager];
        NSString * stringUrlForPOST=[NSString stringWithFormat:@"%@methodName=%@",SERVER_INDEX_PATH,methodName];
        show ? [UTILITY_MANAGER showSpinner:_rootViewController] : 0;
        [_Af_network_handler POST:stringUrlForPOST parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
             [formData appendPartWithFileData:imageData name:@"userfile" fileName:imagename mimeType:@"image/png"];
            
        }success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(responseObject)
            {
                NSLog(@"Success: %@", responseObject);
                [UTILITY_MANAGER hideSpinner:_rootViewController];
                responseObject=[self checkResponseValidity:responseObject];
                success([responseObject objectForKey:RESPONSE_DATA_KEY],[responseObject objectForKey:RESPONSE_MESSAGE_KEY],[NSString stringWithFormat:@"%@",[responseObject objectForKey:RESPONSE_STATUS_KEY]]);
            }
            else
            {
               [UTILITY_MANAGER hideSpinner:_rootViewController];
                failure(RESPONSE_NO_DATA_ERROR);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            NSLog(@"Response: %@",operation.responseString);
            if(error.code==-1001||error.code==-1003||error.code==-1005||error.code==-1009)
            {
                [UTILITY_MANAGER hideSpinner:_rootViewController];
               failure(MSG_ERROR_INTERNET);
            }
            
        }];
    }
    else
    {
       [UTILITY_MANAGER hideSpinner:_rootViewController];
       failure(MSG_ERROR_INTERNET);
    }

}



-(void)sendGETRequestToServerWithMethodName:(NSString *)methodName AndParamaters:(NSString *)paramters WithSuccess:(void(^)(id  responseData, NSString * responseMessage,NSString * resposneStatusCode ))success Failuer:(void (^)(NSString * errorDescription))failure
{
    if([self checkInternetAvailablity])
    {
        _Af_network_handler=[AFHTTPRequestOperationManager manager];
        NSString * stringUrlForPOST=[NSString stringWithFormat:@"%@methodName=%@&%@",SERVER_INDEX_PATH,methodName,paramters];
        [_Af_network_handler POST:stringUrlForPOST parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(responseObject)
            {
                NSLog(@"Success: %@", responseObject);
                responseObject=[self checkResponseValidity:[responseObject mutableCopy]];
                success([responseObject objectForKey:RESPONSE_DATA_KEY],[responseObject objectForKey:RESPONSE_MESSAGE_KEY],[NSString stringWithFormat:@"%@",[responseObject objectForKey:RESPONSE_STATUS_KEY]]);
            }
            else
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                failure(RESPONSE_NO_DATA_ERROR);
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            if(error.code==-1001||error.code==-1003||error.code==-1005||error.code==-1009)
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                //failure(INTERNET_FAILURE_ERROR);
            }
            
        }];

    }
    else
    {
        AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        UIViewController *rootController =   [appDelegate.window rootViewController];
        [UTILITY_MANAGER hideSpinner:rootController];
       // failure(INTERNET_FAILURE_ERROR);
    }
}
-(void)sendSimpleRequest:(NSString *)URLstring WithSuccess:(void (^)(id  response))success Failure:(void(^)(NSString * errorMessage))errorMessage

{
    if([self checkInternetAvailablity])
    {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:URLstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            if(error.code==-1001||error.code==-1003||error.code==-1005||error.code==-1009)
            {
                //errorMessage(INTERNET_FAILURE_ERROR);
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
            }else
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                errorMessage([error localizedDescription]);
            }
        } else {
            if(response)
            {
                success(responseObject);
            }
            else
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                //errorMessage(RESPONSE_NO_DATA_ERROR);
            }
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
    }
    else
    {
        AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        UIViewController *rootController =   [appDelegate.window rootViewController];
        [UTILITY_MANAGER hideSpinner:rootController];
        //errorMessage(INTERNET_FAILURE_ERROR);
    }
}

#pragma mark GET/POST with Simple Response For General Purpose

-(void)sendPOSTRequestToServerWithMethodNameGeneric:(NSString *)methodName AndParamaters:(NSMutableDictionary *)paramters WithSuccess:(void(^)(id  responseData))success Failuer:(void (^)(NSString * errorDescription))failure
{
    if([self checkInternetAvailablity])
    {
        
        _Af_network_handler=[AFHTTPRequestOperationManager manager];
        NSString * stringUrlForPOST=[NSString stringWithFormat:@"%@methodName=%@",SERVER_INDEX_PATH,methodName];
        [_Af_network_handler POST:stringUrlForPOST parameters:paramters  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(responseObject)
            {
                NSLog(@"Success: %@", responseObject);
                success(responseObject);
            }
            else
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                failure(RESPONSE_NO_DATA_ERROR);
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            if(error.code==-1001||error.code==-1003||error.code==-1005||error.code==-1009)
            {
               // failure(INTERNET_FAILURE_ERROR);
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
            }
            
        }];
    }
    else
    {
       // failure(INTERNET_FAILURE_ERROR);
    }

}
-(void)sendGETRequestToServerWithMethodNameGeneric:(NSString *)methodName AndParamaters:(NSString *)paramters WithSuccess:(void(^)(id  responseData))success Failuer:(void (^)(NSString * errorDescription))failure
{
    if([self checkInternetAvailablity])
    {
        _Af_network_handler=[AFHTTPRequestOperationManager manager];

        NSString * stringUrlForPOST=[NSString stringWithFormat:@"%@methodName=%@&%@",SERVER_INDEX_PATH,methodName,paramters];
        [_Af_network_handler POST:stringUrlForPOST parameters:paramters  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(responseObject)
            {
                NSLog(@"Success: %@", responseObject);
                success(responseObject);
            }
            else
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                failure(RESPONSE_NO_DATA_ERROR);
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            if(error.code==-1001||error.code==-1003||error.code==-1005||error.code==-1009)
            {
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIViewController *rootController =   [appDelegate.window rootViewController];
                [UTILITY_MANAGER hideSpinner:rootController];
                //failure(INTERNET_FAILURE_ERROR);
            }
            
        }];
        
    }
    else
    {
        AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        UIViewController *rootController =   [appDelegate.window rootViewController];
        [UTILITY_MANAGER hideSpinner:rootController];
        //failure(INTERNET_FAILURE_ERROR);
    }

}
#pragma mark Image Download
-(void)downloadImageFromServerWithPath:(NSString *)imageName WithSuccess:(void(^)(UIImage * image))success Failure:(void(^)(NSString *errorMessage))failure
{
    
}
-(void)downloadImageFromFacebook:(NSString *)imageName WithSuccess:(void(^)(UIImage * image))success Failure:(void(^)(NSString *errorMessage))failure
{
    
}

#pragma mark Image Upload
#pragma mark Helper Methods For Services
-(NSMutableDictionary *)checkResponseValidity:(NSMutableDictionary *)DataForCheck
{
    NSArray * DataKeys=[DataForCheck allKeys];
    DataForCheck=[DataForCheck mutableCopy];
    for (int i=0; i<DataKeys.count; i++) {
        if([[DataForCheck objectForKey:[DataKeys objectAtIndex:i]] isEqual:[NSNull null]])
        {
            [DataForCheck setObject:@"NULL" forKey:[DataKeys objectAtIndex:i]];
        }
    }
    return DataForCheck;
}
-(BOOL)checkInternetAvailablity
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus==NotReachable) {
        return NO;
    }
    else
        return YES;
}
//-(NSString *)generateUniqueNameForImageUpload
//{
//    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//    NSMutableString *randomString = [NSMutableString stringWithCapacity:10];
//    
//    for (int i=0; i<10; i++) {
//        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random_uniform((int)[letters length])]];
//    }
//    
//    return randomString;
//}
//-(void)downloadAndCacheImageOnImageView:(UIImageView *)imageViewForDownload WithUrlString:(NSString *)imageUrlString WithPlaceholderImage:(UIImage *)placeHolderImage
//{
////    [imageViewForDownload setImageWithURL:[NSURL URLWithString:imageUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    [imageViewForDownload setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:placeHolderImage usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//}
//-(void)setImageCacheDownloader
//{
//    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
//    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
//}
@end
