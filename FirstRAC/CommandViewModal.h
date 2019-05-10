//
//  CommandViewModal.h
//  FirstRAC
//
//  Created by DaYu on 2019/5/9.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSUInteger, HTTPRequestStatus) {
    HTTPRequestStatusBegin,
    HTTPRequestStatusEnd,
    HTTPRequestStatusError,
};

@interface CommandViewModal : NSObject
@property(nonatomic, strong) RACCommand *requestData;
@property(nonatomic, assign) HTTPRequestStatus requestStatus;

@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSError* error;


-(void)postUrl:(NSString *)urlStr
        params:(id)parameters
   requestType:(NSString *)type
       success:(void(^)(id responseObject))success
       failure:(void(^)(NSError *)) failure;
@end
