//
//  NSString+LimitInput.h
//  Input
//
//  Created by mac on 2021/2/5.
//  Copyright © 2021 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LimitInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LimitInput)
-(BOOL)isValidWithAvailableCharacterSet:(AvailableCharacterSet)set;
@end

NS_ASSUME_NONNULL_END
