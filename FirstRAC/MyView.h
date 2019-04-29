//
//  MyView.h
//  FirstRAC
//
//  Created by DaYu on 2019/4/28.
//  Copyright © 2019年 DaYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class MyView;

@protocol MyViewDelegate <NSObject>
-(void)myViewClick:(MyView*)myView;
@end

@interface MyView : UIView
@property(nonatomic,weak) id<MyViewDelegate>  delegate;
@property (nonatomic,strong) RACSubject *btnClickSignal;        //RAC
@end
