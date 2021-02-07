//
//  UITextField+Category.h
//  Pokio
//
//  Created by longzezhen on 2018/12/10.
//  Copyright © 2018年 深圳趣凡网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitInput.h"
@interface UITextField (Category)
@property(nonatomic,assign)AvailableCharacterSet availableCharacterSet;

/**
 该block可拦截到当前输入的文本是否可用,并且可以更改不可用文本为可用文本
 */
@property(nonatomic,copy)BOOL (^isAvailableBlock)(NSString *text,BOOL result);
@end


