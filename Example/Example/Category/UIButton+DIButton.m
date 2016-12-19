//
//  UIButton+DIButton.m
//  DIAnalytics
//
//  Created by William-José Simard-Touzet on 2016-11-04.
//  Copyright © 2016 Samuel Cote. All rights reserved.
//

#import "UIButton+DIButton.h"

@implementation UIButton (DIButton)

#define HEXCOLOR(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c>>0)&0xFF)/255.0 alpha:a]
#define DI_COLOR HEXCOLOR(0xD4D8DB, 1.0)

+(UIButton*)diButtonWithType:(DIButtonType)type {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel.font fontWithSize:16.0f];
    
    switch (type) {
        case DIButtonTypeNormal:
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIButton imageWithColor:DI_COLOR] forState:UIControlStateNormal];
            break;
            
        case DIButtonTypeRed:
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIButton imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    return button;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
