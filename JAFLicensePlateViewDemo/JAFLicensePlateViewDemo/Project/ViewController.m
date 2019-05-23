//
//  ViewController.m
//  JAFLicensePlateViewDemo
//
//  Created by 张俊彬 on 2019/5/16.
//  Copyright © 2019 Jamfer.iOSCoder. All rights reserved.
//

#import "ViewController.h"
#import "JAFLicensePlateView.h"

@interface ViewController ()<JAFLicensePlateViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *displayTF;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayTF.userInteractionEnabled = NO;
}

- (IBAction)editCarLicensePlate:(UIButton *)sender {
    JAFLicensePlateView* licenseplate = [JAFLicensePlateView licensePlateDefaultNumber:self.displayTF.text];
    licenseplate.delegate = self;
    licenseplate.specialLicenseplateHidden = YES;
    [licenseplate showLicenseplate];
}

#pragma mark - JAFLicensePlateViewDelegate

-(void)licenseplate_finishBackString:(NSString *)licenseplate{
    NSLog(@"call back:%@",licenseplate);
    self.displayTF.text = licenseplate;
}

-(void)licenseplate_cancel{
    NSLog(@"licenseplate close");
}

@end
