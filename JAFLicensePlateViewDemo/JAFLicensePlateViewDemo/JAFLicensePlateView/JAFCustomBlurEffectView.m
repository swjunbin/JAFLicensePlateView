//
//  JAFCustomerBlurEffectView.m
//  JAFFaceAPPNormalClient
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 Jamfer. All rights reserved.
//

#import "JAFCustomBlurEffectView.h"

@interface JAFCustomBlurEffectView (){
    //毛玻璃
    UIVisualEffectView* _effectView;
}
@end
@implementation JAFCustomBlurEffectView
-(instancetype)initWithBlurStyle:(UIBlurEffectStyle)blurStyle Frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:blurStyle];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_effectView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_effectView];
    }
    return self;
}
+(JAFCustomBlurEffectView*)blurEffectViewStyle:(UIBlurEffectStyle)blurStyle Frame:(CGRect)frame{
    return [[JAFCustomBlurEffectView alloc] initWithBlurStyle:blurStyle Frame:frame];
}

@end
