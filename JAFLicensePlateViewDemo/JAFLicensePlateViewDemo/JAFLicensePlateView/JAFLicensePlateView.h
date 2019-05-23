//
//  JAFLicensePlateView.h
//  CarWash
//
//  Created by admin on 2017/12/15.
//  Copyright © 2017年 Jamfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JAFLicensePlateViewDelegate <NSObject>
@required
/** 车牌选择确定后回调 */
-(void)licenseplate_finishBackString:(NSString*)licenseplate;

/** 车牌选择取消后回调 */
-(void)licenseplate_cancel;
@end

@interface JAFLicensePlateView : UIView
@property (nonatomic, weak) id<JAFLicensePlateViewDelegate> delegate;

/** 特殊车牌输入隐藏 */
@property (nonatomic, assign) BOOL specialLicenseplateHidden;

-(instancetype)initDefaultNumber:(NSString*)defaultNumber;
+(JAFLicensePlateView*)licensePlateDefaultNumber:(NSString*)defaultNumber;
-(void)showLicenseplate;
@end
