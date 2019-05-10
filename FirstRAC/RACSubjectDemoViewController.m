//
//  RACSubjectDemoViewController.m
//  FirstRAC
//
//  Created by DaYu on 2019/4/30.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "RACSubjectDemoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSubjectDemoViewController ()

@end

@implementation RACSubjectDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //1创建信号，
//    RACSubject * subject = [RACSubject subject];
//
//    //2订阅信号
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    //3发送数据
//    [subject sendNext:@"发送数据"];
    
    
    //----多次订阅----//
    //创建信号，
    RACSubject * subject = [RACSubject subject];
    //发送数据
    [subject sendNext:@"想发送数据看看能不能收到？"];
    //订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"1-%@",x);
    }];
    //再订阅一次
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"2-%@",x);
    }];
    //发送数据
    [subject sendNext:@"发送数据，这个数据能收到！"];

    
    RACReplaySubject * replaySubject = [[RACReplaySubject alloc] init];
    [replaySubject sendNext: @"试试这个能不能收到?"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
    }];

    
//    //用RACSignal
//    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        NSLog(@"创建信号量");
//        //3、发布信息
//        [subscriber sendNext:@"I'm send next data"];
//
//        //self.subscriber = subscriber;
//
//        NSLog(@"那我啥时候运行");
//
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"disposable");
//        }];
//    }];
//
//    //2、订阅信号量
//    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    RACDisposable *disposable2 = [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",@"又订阅了一次！");
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
