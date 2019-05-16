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
-(void)licenseplate_finishBackString:(NSString*)licenseplate;
@end

@interface JAFLicensePlateView : UIView
@property (nonatomic, weak) id<JAFLicensePlateViewDelegate> delegate;

-(instancetype)initDefaultNumber:(NSString*)defaultNumber;
+(JAFLicensePlateView*)licensePlateDefaultNumber:(NSString*)defaultNumber;
-(void)showLicenseplate;
@end
