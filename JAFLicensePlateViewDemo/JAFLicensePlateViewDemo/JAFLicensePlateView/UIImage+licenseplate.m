//
//  UIImage+licenseplate.m
//  JAFLicensePlateViewDemo
//
//  Created by 张俊彬 on 2019/5/16.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import "UIImage+licenseplate.h"

@implementation UIImage (licenseplate)
+(UIImage*)jaf_colorImageColor:(UIColor*)color Rect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
