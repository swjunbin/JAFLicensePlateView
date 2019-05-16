//
//  UIView+licenseplate.m
//  JAFLicensePlateViewDemo
//
//  Created by 张俊彬 on 2019/5/16.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import "UIView+licenseplate.h"


@implementation UIView (licenseplate)

-(void)jaf_shake{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.duration = 0.5;
    animation.values = @[ @(0), @(10), @(-8), @(8), @(-5), @(5), @(0) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"kAFViewShakerAnimationKey"];
}

//height

-(void)setJaf_height:(CGFloat)jaf_height{
    CGRect frame = self.frame;
    frame.size.height = jaf_height;
    self.frame = frame;
}

-(CGFloat)jaf_height{
    return self.frame.size.height;
}


//width

-(void)setJaf_width:(CGFloat)jaf_width{
    CGRect frame = self.frame;
    frame.size.width = jaf_width;
    self.frame = frame;
}

-(CGFloat)jaf_width{
    return self.frame.size.width;
}

//x

-(void)setJaf_X:(CGFloat)jaf_X{
    CGRect frame = self.frame;
    frame.origin.x = jaf_X;
    self.frame = frame;
}

-(CGFloat)jaf_X{
    return self.frame.origin.x;
}

//y

-(void)setJaf_Y:(CGFloat)jaf_Y{
    CGRect frame = self.frame;
    frame.origin.y = jaf_Y;
    self.frame = frame;
}

-(CGFloat)jaf_Y{
    return self.frame.origin.y;
}

//right

-(void)setJaf_Ritht:(CGFloat)jaf_Ritht{
    CGRect frame = self.frame;
    frame.origin.y = jaf_Ritht - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)jaf_Ritht{
    return self.frame.origin.x+self.frame.size.width;
}

//bottom

-(void)setJaf_Bottom:(CGFloat)jaf_Bottom{
    CGRect frame = self.frame;
    frame.origin.y = jaf_Bottom-self.frame.size.height;
    self.frame = frame;
}

-(CGFloat)jaf_Bottom{
    return self.frame.origin.y+self.frame.size.height;
}
@end
