//
//  NormalViewController.m
//  FirstRAC
//
//  Created by DaYu on 2019/4/25.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "NormalViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import "TestObj.h"
#import "MyView.h"

@interface NormalViewController () <MyViewDelegate>
@property(nonatomic,weak) IBOutlet UIView * bgView;
@property(nonatomic,weak) IBOutlet UIButton * btn1;
@property(nonatomic,strong) TestObj * testObj;
@property(nonatomic,weak) IBOutlet UITextField * textField;
@property(nonatomic,copy) NSString * desc;
@property(nonatomic,strong) MyView * myView;
@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //这里有个问题，为什么信号没有被释放?
    [[self.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
        NSLog(@"按钮1被按下");
        
        //这里发送个通知，测试通知使用
        [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil userInfo:nil];
        
        //测试KVO
        self.desc = @"我变了";
    }];
    
    //下面这段代码说明addTarget不会持有对象，那上面的代码怎么做到持有信号对象，然后每次点击都执行block的呢？
//    _testObj = [[TestObj alloc] init];
//    [self.btn1 addTarget:_testObj action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    
    //1.拦截监听方法
    RACSignal * signal = [self rac_signalForSelector:@selector(btnClick:)];
    [signal subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"你竟然响应我了 厉害了");
        NSLog(@"%@",x);
    }];
    
    
    [[self rac_signalForSelector:@selector(touchesBegan:withEvent:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"View 被touch了！");
    }];
    
    [[self rac_signalForSelector:@selector(repleacKVO)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"repleacKVO 被调用！");
    }];
    

    [self repleacKVO];
    
//    //方法2
//    [[self.bgView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"2 - %@",x);
//    }];
    

    //通知的使用
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondsToNotification:) name:@"noti" object:nil];
    
    //2 观察者
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"noti" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3.test field
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
//    [RACObserve(self.bgView, frame) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"3 - %@",x);
//    }];
    
    //4.代替delegate
    
    MyView * myView = [[MyView alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    myView.delegate = self;
    _myView = myView;
    [self.view addSubview:myView];
    
    //4
    [myView.btnClickSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
    }];
    
    //KVO
    //viewcontroller通知myView,自己的
    [self addObserver:_myView forKeyPath:@"desc" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    [_bgView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
    NSLog(@"%@",context);
    
}


- (void)respondsToNotification:(NSNotification *)noti {
    id obj = noti.object;
    NSDictionary *dic = noti.userInfo;
    NSLog(@"\n- self:%@ \n- obj:%@ \n- notificationInfo:%@", self, obj, dic);
}

-(IBAction)btnClick:(id)sender{
    NSLog(@"点击了按钮！");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)repleacKVO{
    [[self.bgView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 - %@",x);
    }];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _bgView.frame = CGRectMake(50, 60, 200, 200);
}


-(void)myViewClick:(MyView*)myView{
    NSLog(@"button clicked!");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    [self removeObserver:_myView forKeyPath:@"desc"];
    [self.bgView removeObserver:self forKeyPath:@"frame"];
}

@end
