//
//  JAFCustomerBlurEffectView.h
//  JAFFaceAPPNormalClient
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 Jamfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAFCustomBlurEffectView : UIView
-(instancetype)initWithBlurStyle:(UIBlurEffectStyle)blurStyle Frame:(CGRect)frame;
+(JAFCustomBlurEffectView*)blurEffectViewStyle:(UIBlurEffectStyle)blurStyle Frame:(CGRect)frame;
@end
