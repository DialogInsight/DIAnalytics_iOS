//
//  UIButton+DIButton.h
//  DIAnalytics
//
//  Created by William-José Simard-Touzet on 2016-11-04.
//  Copyright © 2016 Samuel Cote. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DIButtonTypeNormal,
    DIButtonTypeRed
}DIButtonType;


@interface UIButton (DIButton)

+(UIButton*)diButtonWithType:(DIButtonType)type;

@end
