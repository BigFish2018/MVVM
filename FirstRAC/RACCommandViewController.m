//
//  RACCommandViewController.m
//  FirstRAC
//
//  Created by DaYu on 2019/5/7.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "RACCommandViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <MBProgressHUD.h>

#import "CommandViewModal.h"

@interface RACCommandViewController ()
@property(nonatomic,strong) CommandViewModal * viewModel;
@end

@implementation RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewModel = [CommandViewModal new];
    
    [self bindViewModel];
}

-(void)bindViewModel{
    @weakify(self)
    // 1.
    [[RACObserve(_viewModel, requestStatus) skip:1] subscribeNext:^(NSNumber* x) {
        @strongify(self)
        switch ([x intValue]) {
            case HTTPRequestStatusBegin:
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                break;
            case HTTPRequestStatusEnd:
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                break;
            case HTTPRequestStatusError:
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                //[MBProgressHUD showError:self.viewModel.error.localizedDescription toView:self.view];
                break;
        }
    }];
    
    // 2.
    RAC(self.textView,text) = [[RACObserve(_viewModel, data) skip:1] map:^id _Nullable(NSDictionary* value) {
        //return dic2str(value);
        return @"test";
    }];
    
    // 3.
    //    _button.rac_command = _viewModel.requestData;
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel.requestData execute:@"96671e1a812e46dfa4264b9b39f3e225"];
    }];
    
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
