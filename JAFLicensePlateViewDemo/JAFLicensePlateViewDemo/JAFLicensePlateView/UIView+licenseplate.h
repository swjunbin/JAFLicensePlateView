//
//  UIView+licenseplate.h
//  JAFLicensePlateViewDemo
//
//  Created by 张俊彬 on 2019/5/16.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (licenseplate)
@property (nonatomic, assign) CGFloat jaf_height;
@property (nonatomic, assign) CGFloat jaf_width;
@property (nonatomic, assign) CGFloat jaf_X;
@property (nonatomic, assign) CGFloat jaf_Y;
@property (nonatomic, assign) CGFloat jaf_Ritht;
@property (nonatomic, assign) CGFloat jaf_Bottom;
-(void)jaf_shake;
@end

