//
//  MyView.m
//  FirstRAC
//
//  Created by DaYu on 2019/4/28.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import "MyView.h"

@implementation MyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(10, 10, 180, 20);
        [button setTitle:@"代替delegate" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:button];
    }
    return self;
}

-(IBAction)buttonClick:(id)sender{
    if ([self.delegate respondsToSelector:@selector(myViewClick:)]) {
        [self.delegate myViewClick:self];
    }
    
    [_btnClickSignal sendNext:@"我可以代替代理哦"];     //RAC
}


- (RACSubject *)btnClickSignal{             //RAC
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
    NSLog(@"%@",context);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
