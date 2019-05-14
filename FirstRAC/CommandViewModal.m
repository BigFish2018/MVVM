//
//  CommandViewModal.m
//  FirstRAC
//
//  Created by DaYu on 2019/5/9.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "CommandViewModal.h"
#import <AFNetworking.h>

@implementation CommandViewModal

#define testUrl @"http://127.0.0.1:8080"

- (id)init {
    self = [super init];
    if (self) {
        [self subcribeCommandSignals];
    }
    return self;
}

- (RACCommand *)requestData {
    if (!_requestData) {
        @weakify(self);
        _requestData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString* input) {          //execute的时候这个会执行  yuxg
            
            NSLog(@"这里是外层信号吗？");
            
            @strongify(self);
            NSDictionary *body = @{@"memberCode": input};
            // 进行网络操作，同时将这个操作封装成信号 return
            
            RACSignal * signal =  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                NSLog(@"这里是内层信号吗？");
                
                [self postUrl:testUrl params:body requestType:@"json" success:^(id  _Nullable responseObject) {
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
            
            NSLog(@"%@",signal);
            return signal;
        }];
    }
    return _requestData;
}

-(void)postUrl:(NSString *)urlStr
        params:(id)parameters
   requestType:(NSString *)type
       success:(void(^)(id responseObject))success
       failure:(void(^)(NSError *)) failure
{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];

    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

- (void)subcribeCommandSignals {
    @weakify(self)
    // 1. 订阅外层信号
    [self.requestData.executionSignals subscribeNext:^(RACSignal* innerSignal) {        //execute的时候执行创建的时候传入的block，然后就会执行这个block。 yuxg
        @strongify(self)
        
        NSLog(@"外层信号的block被执行");                    //yuxg
        // 2. 订阅内层信号
        [innerSignal subscribeNext:^(NSDictionary* x) {    //这个subscribeNext，会导致RACCommand对象创建的时候返回的RACSignal中的block被执行。yuxg
            NSLog(@"内层信号的block被执行");                    //这个block在RACSignal创建的时候传入的block中，处理结束后被调用执行。
            self.data = x;
            self.requestStatus = HTTPRequestStatusEnd;
        }];
        
        NSLog(@"%@",innerSignal);
        
        self.error = nil;
        self.requestStatus = HTTPRequestStatusBegin;
    }];
    // 3. 订阅 errors 信号
    [self.requestData.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self)
        self.error = x;
        self.data = nil;
        self.requestStatus = HTTPRequestStatusError; // 这一句必须放在最后一句，否者 controller 拿不到数据
    }];
}


@end
