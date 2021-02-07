//
//  UITextView+LimitInput.h
//  Input
//
//  Created by mac on 2021/2/5.
//  Copyright © 2021 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitInput.h"
NS_ASSUME_NONNULL_BEGIN

@interface UITextView (LimitInput)
@property(nonatomic,assign)AvailableCharacterSet availableCharacterSet;
/**
 该block可拦截到当前输入的文本是否可用,并且可以更改不可用文本为可用文本
 */
@property(nonatomic,copy)BOOL (^isAvailableBlock)(NSString *text,BOOL result);

@end

NS_ASSUME_NONNULL_END
