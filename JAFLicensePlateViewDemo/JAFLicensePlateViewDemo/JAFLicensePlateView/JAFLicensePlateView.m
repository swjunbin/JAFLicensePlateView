//
//  JAFLicensePlateView.m
//  CarWash
//
//  Created by admin on 2017/12/15.
//  Copyright © 2017年 Jamfer. All rights reserved.
//

#import "JAFLicensePlateView.h"
#import "JAFCustomBlurEffectView.h"
#import "UIImage+licenseplate.h"
#import "UIView+licenseplate.h"
#import "NSObject+licenseplate.h"
#import "UIViewController+licenseplate.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define FONT_NORMAL   @"PingFang SC"              //苹方
#define FONT_BOLD     @"PingFangSC-Semibold"      //中粗体

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define Color_Assist                RGBA(62,174,255,1)
#define Color_TextColor_Deep        RGBA(183,183,183,1)
#define Color_Green                 RGBA(46,168,33,1)
#define Color_Main_PlaceHolder      RGBA(244,244,244,1)
#define Color_Main_DeepPlaceHolder  RGBA(153,153,153,1)
#define Color_Black                 RGBA(34,34,34,1)

@interface JAFLicensePlateView()
@property (nonatomic, strong) JAFCustomBlurEffectView* blurView;
@property (nonatomic, strong) UIView* pickView;

@property (nonatomic, strong) UIView* resultView;
@property (nonatomic, strong) NSMutableArray<UILabel*>* resultLabs;
@property (nonatomic, strong) NSMutableArray<UIButton*>* resultBtns;
@property (nonatomic, strong) UIView* resultSelectView;

@property (nonatomic, strong) UIView* provincialView;
@property (nonatomic, strong) NSArray<NSString*>* provincialNames;
@property (nonatomic, strong) NSMutableArray<UIButton*>* provincialNameBtns;

@property (nonatomic, strong) NSArray<NSString*>* numbers;
@property (nonatomic, strong) NSMutableArray<UIButton*>* numberBtns;
@property (nonatomic, strong) UIView* numberView;

@property (nonatomic, strong) NSArray<NSString*>* letters;
@property (nonatomic, strong) NSMutableArray<UIButton*>* letterBtns;
@property (nonatomic, strong) UIView* letterView;

@property (nonatomic, strong) UILabel* pointNumberLab;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) NSString* defaultNumber;

@property (nonatomic, assign) NSInteger numberCount;
@property (nonatomic, strong) UIButton* normalNumberBtn;
@property (nonatomic, strong) UIButton* greenNumberBtn;

@property (nonatomic, strong) UIButton* customerBtn;
@end
@implementation JAFLicensePlateView

-(instancetype)initDefaultNumber:(NSString*)defaultNumber{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if(self){
        self.selectIndex = 0;
        self.numberCount = 7;
        self.defaultNumber = defaultNumber;
        self.backgroundColor = [UIColor clearColor];
        self.resultLabs = [NSMutableArray new];
        self.resultBtns = [NSMutableArray new];
        self.provincialNameBtns = [NSMutableArray new];
        self.numberBtns = [NSMutableArray new];
        self.letterBtns = [NSMutableArray new];
        self.provincialNames = @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",
                                 @"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",
                                 @"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"←"];
        
        self.numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        
        self.letters = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",
                         @"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",
                         @"U",@"V",@"W",@"X",@"Y",@"Z",@"←"];
        [self initUI];
    };
    return self;
}
+(JAFLicensePlateView*)licensePlateDefaultNumber:(NSString*)defaultNumber{
    return [[JAFLicensePlateView alloc] initDefaultNumber:defaultNumber];
}
-(void)showLicenseplate{
    [[UIViewController presentingVC].view addSubview:self];
    [self showSelf];
}
-(void)initUI{
    self.blurView = [JAFCustomBlurEffectView blurEffectViewStyle:UIBlurEffectStyleDark Frame:self.bounds];
    self.blurView.alpha = 0.0;
    [self addSubview:self.blurView];
    
    
    /*              普通、新能源号码牌切换       */
    self.normalNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normalNumberBtn.frame = CGRectMake(ScreenWidth/2.0-150+7, ScreenHeight/2.0-150+80-40, 100, 42.5);
    [self.normalNumberBtn setTitle:@"普通车牌" forState:UIControlStateNormal];
    [self.normalNumberBtn setTitleColor:Color_Assist forState:UIControlStateSelected];
    [self.normalNumberBtn setBackgroundImage:[UIImage jaf_colorImageColor:Color_TextColor_Deep Rect:self.normalNumberBtn.bounds] forState:UIControlStateNormal];
    [self.normalNumberBtn setBackgroundImage:[UIImage jaf_colorImageColor:[UIColor whiteColor] Rect:self.normalNumberBtn.bounds] forState:UIControlStateSelected];
    [self.normalNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.normalNumberBtn.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:14.0f];
    self.normalNumberBtn.tag = 0;
    self.normalNumberBtn.layer.cornerRadius = 5.0f;
    self.normalNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    self.normalNumberBtn.alpha = 0.0f;
    self.normalNumberBtn.layer.masksToBounds = YES;
    [self addSubview:self.normalNumberBtn];
    [self.normalNumberBtn addTarget:self action:@selector(changeNumberKind:) forControlEvents:UIControlEventTouchUpInside];
    self.normalNumberBtn.selected = YES;
    
    self.greenNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.greenNumberBtn.frame = CGRectMake(ScreenWidth/2.0-150+100+7, ScreenHeight/2.0-150+80-40, 100, 42.5);
    [self.greenNumberBtn setTitle:@"新能源车牌" forState:UIControlStateNormal];
    [self.greenNumberBtn setTitleColor:Color_Green forState:UIControlStateSelected];
    [self.greenNumberBtn setBackgroundImage:[UIImage jaf_colorImageColor:Color_TextColor_Deep Rect:self.greenNumberBtn.bounds] forState:UIControlStateNormal];
    [self.greenNumberBtn setBackgroundImage:[UIImage jaf_colorImageColor:[UIColor whiteColor] Rect:self.greenNumberBtn.bounds] forState:UIControlStateSelected];
    [self.greenNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.greenNumberBtn.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:14.0f];
    self.greenNumberBtn.tag = 1;
    self.greenNumberBtn.layer.cornerRadius = 5.0f;
    self.greenNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    self.greenNumberBtn.alpha = 0.0f;
    self.greenNumberBtn.layer.masksToBounds = YES;
    [self addSubview:self.greenNumberBtn];
    [self.greenNumberBtn addTarget:self action:@selector(changeNumberKind:) forControlEvents:UIControlEventTouchUpInside];
    self.greenNumberBtn.selected = NO;
    
    /*              显示结果区域       */
    
    self.pickView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2.0-310/2.0, ScreenHeight/2.0-150+80, 310, 300)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.layer.cornerRadius = 5.0f;
    [self addSubview:self.pickView];
    self.pickView.alpha = 0.0;
    
    self.resultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.pickView.jaf_width, 50)];
    self.resultView.backgroundColor = [UIColor clearColor];
    [self.pickView addSubview:self.resultView];
    UIView* line_result = [[UIView alloc] initWithFrame:CGRectMake(0, self.resultView.jaf_height-SINGLE_LINE_ADJUST_OFFSET, self.resultView.jaf_width, SINGLE_LINE_WIDTH)];
    line_result.backgroundColor = Color_Main_DeepPlaceHolder;
    [self.resultView addSubview:line_result];
    
    
    
    /*              结果                      */
    for(int index = 0; index<8; index++){
        UILabel* resultNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(10+index*(34+8.6), 8, 34, 34)];
        resultNumberLab.layer.cornerRadius = 3.0f;
        resultNumberLab.layer.borderColor = Color_Main_DeepPlaceHolder.CGColor;
        resultNumberLab.layer.borderWidth = 1.0f;
        resultNumberLab.tag = index;
        resultNumberLab.textAlignment = NSTextAlignmentCenter;
        resultNumberLab.font = [UIFont fontWithName:FONT_BOLD size:16.0f];
        [self.resultView addSubview:resultNumberLab];
        [self.resultLabs addObject:resultNumberLab];
        
        if(index == 7){
            //新能源车牌位置
            resultNumberLab.frame = CGRectMake(self.resultView.jaf_width-10-30.1, 8, 30.1, 34);
            resultNumberLab.alpha = 0;
            resultNumberLab.hidden = YES;
        }
    }
    UILabel* pointNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(10+2*34+8.6, 8, 8.6, 34)];
    pointNumberLab.textAlignment = NSTextAlignmentCenter;
    pointNumberLab.text = @"·";
    pointNumberLab.font = [UIFont fontWithName:FONT_BOLD size:16.0f];
    self.pointNumberLab = pointNumberLab;
    [self.resultView addSubview:pointNumberLab];
    
    self.resultSelectView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, 34, 34)];
    self.resultSelectView.backgroundColor = [UIColor clearColor];
    self.resultSelectView.clipsToBounds = YES;
    self.resultSelectView.layer.cornerRadius = 3.0f;
    self.resultSelectView.layer.borderWidth = 1.0f;
    self.resultSelectView.layer.borderColor = Color_Assist.CGColor;
    [self.resultView addSubview:self.resultSelectView];
    
    for(int index = 0; index<8; index++){
        UIButton* resultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resultBtn.frame = CGRectMake(10+index*(34+8.6), 8, 34, 34);
        resultBtn.tag = index;
        [resultBtn setTitle:@"" forState:UIControlStateNormal];
        [resultBtn addTarget:self action:@selector(resultAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.resultView addSubview:resultBtn];
        [self.resultBtns addObject:resultBtn];
        
        if(index == 7){
            //新能源车牌位置
            resultBtn.frame = CGRectMake(self.resultView.jaf_width-10-30.1, 8, 30.1, 34);
            resultBtn.alpha = 0;
            resultBtn.hidden = YES;
        }
    }
    
    
    /*              省                      */
    self.provincialView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.pickView.jaf_width, 200)];
    self.provincialView.backgroundColor = [UIColor clearColor];
    [self.pickView addSubview:self.provincialView];
    
    NSInteger provTag = 0;
    for(int indexRow = 0; indexRow<4; indexRow++){
        for(int index = 0; index<8; index++){
            UIButton* provBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            provBtn.frame = CGRectMake(10+index*(31.4+5.7), 5+indexRow*(42+5), 31.4, 42);
            provBtn.layer.cornerRadius = 5.0f;
            provBtn.layer.borderColor = Color_Black.CGColor;
            provBtn.layer.borderWidth = 1.0f;
            [provBtn setTitleColor:Color_Black forState:UIControlStateNormal];
            [provBtn setTitleColor:Color_Main_DeepPlaceHolder forState:UIControlStateHighlighted];
            [provBtn setTitle:self.provincialNames[provTag] forState:UIControlStateNormal];
            [provBtn addTarget:self action:@selector(provAction:) forControlEvents:UIControlEventTouchUpInside];
            provBtn.tag = provTag;
            provBtn.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:16.0f];
            [self.provincialView addSubview:provBtn];
            [self.provincialNameBtns addObject:provBtn];
            provTag ++;
        }
    }
    [self.provincialNameBtns.lastObject setBackgroundColor:Color_Assist];
    self.provincialNameBtns.lastObject.layer.borderColor = [UIColor clearColor].CGColor;
    [self.provincialNameBtns.lastObject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.provincialNameBtns.lastObject.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:16.0f];
    
    /*              数字                      */
    self.numberView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.pickView.jaf_width, 47)];
    self.numberView.backgroundColor = [UIColor clearColor];
    [self.pickView addSubview:self.numberView];
    
    for(int index = 0; index<10; index++){
        UIButton* numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        numberBtn.frame = CGRectMake(10+index*(25+4.4), 5, 25, 42);
        numberBtn.layer.cornerRadius = 3.0f;
        numberBtn.layer.borderColor = Color_Black.CGColor;
        numberBtn.layer.borderWidth = 1.0f;
        [numberBtn setTitleColor:Color_Black forState:UIControlStateNormal];
        [numberBtn setTitleColor:Color_Main_DeepPlaceHolder forState:UIControlStateHighlighted];
        [numberBtn setTitle:self.numbers[index] forState:UIControlStateNormal];
        [numberBtn addTarget:self action:@selector(numberAction:) forControlEvents:UIControlEventTouchUpInside];
        numberBtn.tag = index;
        numberBtn.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:16.0f];
        [self.numberView addSubview:numberBtn];
        [self.numberBtns addObject:numberBtn];
    }
    self.numberView.hidden = YES;
    
    /*              字母                      */
    self.letterView = [[UIView alloc] initWithFrame:CGRectMake(0, 50+5+42, self.pickView.jaf_width, 300-50-42-5-50)];
    self.letterView.backgroundColor = [UIColor clearColor];
    [self.pickView addSubview:self.letterView];
    
    NSInteger letterTag = 0;
    for(int indexRow = 0; indexRow<3; indexRow++){
        for(int index = 0; index<(indexRow==2?7:10); index++){
            UIButton* letterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            letterBtn.frame = CGRectMake(10+index*(25+4.4), 5+indexRow*(42+5), 25, 42);
            letterBtn.layer.cornerRadius = 3.0f;
            letterBtn.layer.borderColor = Color_Black.CGColor;
            letterBtn.layer.borderWidth = 1.0f;
            [letterBtn setTitleColor:Color_Black forState:UIControlStateNormal];
            [letterBtn setTitleColor:Color_Main_DeepPlaceHolder forState:UIControlStateHighlighted];
            [letterBtn setTitle:self.letters[letterTag] forState:UIControlStateNormal];
            [letterBtn addTarget:self action:@selector(letterAction:) forControlEvents:UIControlEventTouchUpInside];
            letterBtn.tag = letterTag;
            letterBtn.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:16.0f];
            [self.letterView addSubview:letterBtn];
            [self.letterBtns addObject:letterBtn];
            letterTag ++;
        }
    }
    self.letterBtns.lastObject.jaf_width = 4*25+3*4.4;
    [self.letterBtns.lastObject setBackgroundColor:Color_Assist];
    self.letterBtns.lastObject.layer.borderColor = [UIColor clearColor].CGColor;
    [self.letterBtns.lastObject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.letterBtns.lastObject.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:24.0f];
    self.letterView.hidden = YES;
    
    /*              确认                      */
    UIView* line_bottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.pickView.jaf_height-50+SINGLE_LINE_ADJUST_OFFSET, self.pickView.jaf_width, SINGLE_LINE_WIDTH)];
    line_bottom.backgroundColor = Color_Main_DeepPlaceHolder;
    [self.pickView addSubview:line_bottom];
    
    UIButton* chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButton.frame = CGRectMake(0, self.pickView.jaf_height-50, self.pickView.jaf_width/2.0, 50);
    [chooseButton setTitle:@"取消" forState:UIControlStateNormal];
    [chooseButton setTitleColor:Color_Black forState:UIControlStateNormal];
    [chooseButton setTitleColor:Color_Main_PlaceHolder forState:UIControlStateHighlighted];
    chooseButton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:18.0f];
    [chooseButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.pickView addSubview:chooseButton];
    
    UIView* line_btn = [[UIView alloc] initWithFrame:CGRectMake(self.pickView.jaf_width/2.0-SINGLE_LINE_ADJUST_OFFSET, self.pickView.jaf_height-40, SINGLE_LINE_WIDTH, 30)];
    line_btn.backgroundColor = Color_Main_DeepPlaceHolder;
    [self.pickView addSubview:line_btn];
    
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(self.pickView.jaf_width/2.0, self.pickView.jaf_height-50, self.pickView.jaf_width/2.0, 50);
    [cancelButton setTitle:@"确定" forState:UIControlStateNormal];
    [cancelButton setTitleColor:Color_Black forState:UIControlStateNormal];
    [cancelButton setTitleColor:Color_Main_PlaceHolder forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:18.0f];
    [cancelButton addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.pickView addSubview:cancelButton];
    
    /*           自定义按钮          */
    self.customerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customerBtn.frame = CGRectMake(ScreenWidth, ScreenHeight/2.0-150-30-40, 100, 30);
    self.customerBtn.backgroundColor = Color_Assist;
    self.customerBtn.layer.cornerRadius = 15;
    self.customerBtn.layer.masksToBounds = YES;
    [self.customerBtn setTitle:@"特殊车牌" forState:UIControlStateNormal];
    [self.customerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.customerBtn.titleLabel.font = [UIFont fontWithName:FONT_NORMAL size:14.0f];
    [self.customerBtn addTarget:self action:@selector(cutomerAlert) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.customerBtn];
    
    //默认
    if(self.defaultNumber.length > 0){
        NSString* finalNumber = [self.defaultNumber stringByReplacingOccurrencesOfString:@"·" withString:@""];
        for(int index = 0; index<finalNumber.length; index++){
            if(index<self.resultLabs.count){
                self.resultLabs[index].text = [finalNumber substringWithRange:NSMakeRange(index, 1)];
            }
        }
        [self setNextIndexSelect];
    }
}
-(void)resetResultUI{
    if(self.numberCount == 7){
        //普通车牌
        [UIView animateWithDuration:.3 animations:^{
            for(int index = 0; index<7; index++){
                UILabel* lab = self.resultLabs[index];
                lab.frame = CGRectMake(10+index*(34+8.6), 8, 34, 34);
                UIButton* btn = self.resultBtns[index];
                btn.frame = CGRectMake(10+index*(34+8.6), 8, 34, 34);
                self.pointNumberLab.frame = CGRectMake(10+2*34+8.6, 8, 8.6, 34);
            }
            self.resultLabs.lastObject.alpha = 0.0f;
            self.resultBtns.lastObject.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.resultLabs.lastObject.hidden = YES;
            self.resultBtns.lastObject.hidden = YES;
        }];
        if(self.selectIndex == 7){
            [UIView animateWithDuration:.3 animations:^{
                self.resultSelectView.frame = self.resultLabs[self.selectIndex-1].frame;
            } completion:^(BOOL finished) {
                [self setNextIndexSelect];
            }];
        }else{
            [UIView animateWithDuration:.3 animations:^{
                self.resultSelectView.frame = self.resultLabs[self.selectIndex].frame;
            } completion:^(BOOL finished) {
                [self setNextIndexSelect];
            }];
        }
        
        
    }else if (self.numberCount == 8){
        
        self.resultLabs.lastObject.hidden = NO;
        self.resultBtns.lastObject.hidden = NO;
        //新能源车牌
        [UIView animateWithDuration:.3 animations:^{
            for(int index = 0; index<7; index++){
                UILabel* lab = self.resultLabs[index];
                lab.frame = CGRectMake(10+index*(30.1+7), 8, 30.1, 34);
                UIButton* btn = self.resultBtns[index];
                btn.frame = CGRectMake(10+index*(30.1+7), 8, 30.1, 34);
                self.pointNumberLab.frame = CGRectMake(10+2*30.1+7, 8, 7, 34);
            }
            self.resultLabs.lastObject.alpha = 1.0f;
            self.resultBtns.lastObject.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
        [UIView animateWithDuration:.3 animations:^{
            self.resultSelectView.frame = self.resultLabs[self.selectIndex].frame;
        } completion:^(BOOL finished) {
            [self setNextIndexSelect];
        }];
    }
}

#pragma mark - setter
-(void)setSpecialLicenseplateHidden:(BOOL)specialLicenseplateHidden{
    self.customerBtn.hidden = specialLicenseplateHidden;
}

#pragma mark - Animation
-(void)showSelf{
    [UIView animateWithDuration:.5 animations:^{
        self.blurView.alpha = 1.0;
        self.pickView.alpha = 1.0;
        self.pickView.jaf_Y = ScreenHeight/2.0-150;
        self.greenNumberBtn.alpha = 1.0f;
        self.greenNumberBtn.jaf_Y = ScreenHeight/2.0-150-30;
        self.normalNumberBtn.alpha = 1.0f;
        self.normalNumberBtn.jaf_Y = ScreenHeight/2.0-150-30;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            self.customerBtn.jaf_X = ScreenWidth-100+15;
        }];
    }];
}
-(void)dismissSelf{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - Action
-(void)chooseAction{
    for(int index = 0; index<self.numberCount; index++){
        UILabel* lab = self.resultLabs[index];
        if(lab.text.length == 0){
            [lab jaf_shake];
            [self showHudTipStr:@"车牌号码尚未填写完毕"];
            return;
        }
    }
    NSString* carNumber = @"";
    for(int index = 0; index<self.numberCount; index++){
        carNumber = [carNumber stringByAppendingString:self.resultLabs[index].text];
    }
    carNumber = [NSString stringWithFormat:@"%@·%@",[carNumber substringToIndex:2],[carNumber substringWithRange:NSMakeRange(2, self.numberCount-2)]];
    if([self.delegate respondsToSelector:@selector(licenseplate_finishBackString:)]){
        [self.delegate licenseplate_finishBackString:carNumber];
    }
    [self dismissSelf];
}
-(void)changeNumberKind:(UIButton*)sender{
    if(sender.selected){
        return;
    }
    if(sender.tag == 0){
        sender.selected = YES;
        self.numberCount = 7;
        self.greenNumberBtn.selected = NO;
    }else{
        sender.selected = YES;
        self.numberCount = 8;
        self.normalNumberBtn.selected = NO;
    }
    [self resetResultUI];
}
-(void)cancelAction{
    if([self.delegate respondsToSelector:@selector(licenseplate_cancel)]){
        [self.delegate licenseplate_cancel];
    }
    [self dismissSelf];
}
-(void)resultAction:(UIButton*)sender{
    [self setSelectToIndex:sender.tag];
}
-(void)provAction:(UIButton*)sender{
    if(sender.tag == 31){
        self.resultLabs[0].text = @"";
    }else{
        self.resultLabs[0].text = self.provincialNames[sender.tag];
        [self setNextIndexSelect];
    }
}
-(void)numberAction:(UIButton*)sender{
    self.resultLabs[self.selectIndex].text = self.numbers[sender.tag];
    [self setNextIndexSelect];
}
-(void)letterAction:(UIButton*)sender{
    if(sender.tag == 26){
        if(self.resultLabs[self.selectIndex].text.length == 0){
            self.resultLabs[self.selectIndex-1].text = @"";
            [self setSelectToIndex:self.selectIndex-1];
        }else{
            self.resultLabs[self.selectIndex].text = @"";
        }
        return;
    }
    self.resultLabs[self.selectIndex].text = self.letters[sender.tag];
    [self setNextIndexSelect];
}
-(void)setNextIndexSelect{
    for(int index = 0; index<self.numberCount; index++){
        UILabel* lab = self.resultLabs[index];
        if(lab.text.length == 0){
            [self setSelectToIndex:lab.tag];
            return ;
        }
    }
}
-(void)setSelectToIndex:(NSInteger)index{
    if(self.selectIndex == index) return;
    [UIView animateWithDuration:.3 animations:^{
        self.resultSelectView.frame = self.resultLabs[index].frame;
    }];
    if(index == 0){
        self.letterView.hidden = YES;
        self.numberView.hidden = YES;
        self.provincialView.hidden = NO;
    }else if (index == 1){
        self.letterView.hidden = NO;
        self.numberView.hidden = NO;
        self.provincialView.hidden = YES;
        self.numberView.alpha = 0.4f;
        self.numberView.userInteractionEnabled = NO;
    }else{
        self.letterView.hidden = NO;
        self.numberView.hidden = NO;
        self.provincialView.hidden = YES;
        self.numberView.alpha = 1.0f;
        self.numberView.userInteractionEnabled = YES;
    }
    self.selectIndex = index;
}

-(void)cutomerAlert{
    UIAlertController* alertC = [UIAlertController alertControllerWithTitle:@"请输入车牌号" message:@"可能有些车牌输入不能完全支持，您可以在这里手动输入车牌号，请务必填写正确哦~" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        if(self.defaultNumber && self.defaultNumber.length != 0){
            textField.text = self.defaultNumber;
        }
        textField.placeholder = @"请输入您的车牌号码";
        [textField setFont:[UIFont fontWithName:FONT_NORMAL size:14.0f]];
    }];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* number = alertC.textFields.firstObject.text;
        if(number.length != 0){
            if([self.delegate respondsToSelector:@selector(licenseplate_finishBackString:)]){
                [self.delegate licenseplate_finishBackString:number];
            }
            [self dismissSelf];
        }
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [[UIViewController presentingVC] presentViewController:alertC animated:YES completion:nil];
}

@end
