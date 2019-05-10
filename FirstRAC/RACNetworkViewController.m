//
//  RACNetworkViewController.m
//  FirstRAC
//
//  Created by DaYu on 2019/5/6.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "RACNetworkViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACNetworkViewController ()

@end

@implementation RACNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSLog(@"发送网络请求");
//
//        [subscriber sendNext:@"得到网络请求数据"];
//
//        return nil;
//    }];
//
//    [signal subscribeNext:^(id x) {
//        NSLog(@"1 - %@",x);
//    }];
//
//    [signal subscribeNext:^(id x) {
//        NSLog(@"2 - %@",x);
//    }];
//
//    [signal subscribeNext:^(id x) {
//        NSLog(@"3 - %@",x);
//    }];

    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送网络请求");
        
        [subscriber sendNext:@"得到网络请求数据"];
        
        return nil;
    }];
    
    RACMulticastConnection *connect = [signal publish];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"1 - %@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"2 - %@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"3 - %@",x);
    }];
    
    [connect connect];
    
//    [connect.signal subscribeNext:^(id x) {
//        NSLog(@"4 - %@",x);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
