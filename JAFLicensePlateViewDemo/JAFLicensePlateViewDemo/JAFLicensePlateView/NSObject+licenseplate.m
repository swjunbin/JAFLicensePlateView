//
//  NSObject+licenseplate.m
//  JAFLicensePlateViewDemo
//
//  Created by 张俊彬 on 2019/5/16.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import "NSObject+licenseplate.h"
#import "MBProgressHUD.h"

@implementation NSObject (licenseplate)
- (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        for(NSObject* obj in [UIApplication sharedApplication].keyWindow.subviews){
            if([obj isKindOfClass:[MBProgressHUD class]]){
                MBProgressHUD* shud = (MBProgressHUD*)obj;
                if(![shud.detailsLabelText isEqualToString:tipStr]){
                    hud.yOffset = shud.yOffset+20;
                }
            }
        }
        hud.userInteractionEnabled = NO;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.65];
        hud.detailsLabelColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.cornerRadius = 5.0;
        [hud hide:YES afterDelay:1.5];
    }
}
@end
