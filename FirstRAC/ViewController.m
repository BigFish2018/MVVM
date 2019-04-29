//
//  ViewController.m
//  FirstRAC
//
//  Created by DaYu on 2019/4/22.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()
@property(nonatomic,weak) IBOutlet UIButton * btn;
@property(nonatomic,assign) NSInteger time;
@property(nonatomic,retain) RACDisposable * dispoable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    @weakify(self)
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        x.enabled = false;
        self.time = 10;
        
        //这个就是RAC中的GCD
        self.dispoable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            _time --;
            NSString * title = _time > 0 ? [NSString stringWithFormat:@"请等待 %d 秒后重试",_time] : @"发送验证码";
            [self.btn setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
            self.btn.enabled = (_time==0)? YES : NO;
            if (_time == 0) {
                [self.dispoable dispose];
            }
        }];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
