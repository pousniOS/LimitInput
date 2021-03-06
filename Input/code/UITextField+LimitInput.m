//
//  UITextField+Category.m
//  Pokio
//
//  Created by longzezhen on 2018/12/10.
//  Copyright © 2018年 深圳趣凡网络科技有限公司. All rights reserved.
//
 
#import "UITextField+LimitInput.h"
#import <objc/runtime.h>
#import "NSString+LimitInput.h"
static char UITextFieldAvailableCharacterSetKey;
static char UITextFieldIsAvailableBlockKey;


@implementation UITextField (Category)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodExchange];
    });
}
-(AvailableCharacterSet)availableCharacterSet{
    return [objc_getAssociatedObject(self, &UITextFieldAvailableCharacterSetKey) integerValue];
}
-(void)setAvailableCharacterSet:(AvailableCharacterSet)availableCharacterSet{
    objc_setAssociatedObject(self, &UITextFieldAvailableCharacterSetKey, @(availableCharacterSet), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL (^)(NSString *, BOOL))isAvailableBlock{
    return objc_getAssociatedObject(self, &UITextFieldIsAvailableBlockKey);
}
-(void)setIsAvailableBlock:(BOOL (^)(NSString *, BOOL))isAvailableBlock{
    objc_setAssociatedObject(self, &UITextFieldIsAvailableBlockKey, isAvailableBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+(void)methodExchange{
    SEL textFiledSEL = NSSelectorFromString(@"_delegateShouldChangeCharactersInTextStorageRange:replacementString:delegateCares:");
    if ([UITextField.new respondsToSelector:textFiledSEL] == NO) {
        return;
    }

    Method textFiledMethod = class_getInstanceMethod(UITextField.class, textFiledSEL);
    Method exTextFiledMethod = class_getInstanceMethod([self class], @selector(_ex_delegateShouldChangeCharactersInTextStorageRange:replacementString:delegateCares:));
    method_exchangeImplementations(textFiledMethod, exTextFiledMethod);
}
-(BOOL)_ex_delegateShouldChangeCharactersInTextStorageRange:(NSRange)range replacementString:text delegateCares:(BOOL *)cares{
    BOOL result = [self _ex_delegateShouldChangeCharactersInTextStorageRange:range replacementString:text delegateCares:cares];
    if (result == YES && self.availableCharacterSet != AvailableCharacterSetAll) {
        result = [text isValidWithAvailableCharacterSet:self.availableCharacterSet];
        if (self.isAvailableBlock) {
            return self.isAvailableBlock(text,result);
        }
        return result;
    }
    return result;
}
@end

