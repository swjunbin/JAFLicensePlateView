# JAFLicensePlateView
CarLicensePlateEditView  
为中国车牌量身定制的车牌选择控件，提供全国各地车牌，兼容普通车牌、新能源车牌、特殊车牌的输入；  
使用简单，集成方便；  

# 为什么需要？

- 针对中国车牌的三方车牌选择控件不多；
- 随新能源车牌加入，部分已不支持；
- 在移动端就可以提前规范车牌格式；

# JAFLicesePlateView有什么特色？

- 自定义的输入键盘；
- 合适的操作规范，确保车牌输入的正确性；
- 兼容新能源车牌的输入；
- 允许特殊车牌的自定义输入；

# 如何使用？

将JAFLicensePlateView文件拉入；

\#import "JAFLicensePlateView.h"；

添加协议\<JAFLicensePlateViewDelegate>；

初始化：

```objective-c
JAFLicensePlateView* licenseplate = [JAFLicensePlateView licensePlateDefaultNumber:self.displayTF.text];
licenseplate.delegate = self;
licenseplate.specialLicenseplateHidden = YES;
[licenseplate showLicenseplate];
```

实现代理：

```objective-c
#pragma mark - JAFLicensePlateViewDelegate

-(void)licenseplate_finishBackString:(NSString *)licenseplate{
    NSLog(@"call back:%@",licenseplate);
    self.displayTF.text = licenseplate;
}

-(void)licenseplate_cancel{
    NSLog(@"licenseplate close");
}
```

完成。