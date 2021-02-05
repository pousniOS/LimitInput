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
@end

NS_ASSUME_NONNULL_END
